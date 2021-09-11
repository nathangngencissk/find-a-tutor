<template>
  <v-container>
    <v-row justify="center">
      <v-col xl="10" cols="12">
        <v-alert type="error" :value="alert">
          {{ alertMessage }}
        </v-alert>
        <v-sheet elevation="1" class="pa-4">
          <h3>Visão geral</h3>
          <v-sheet elevation="2" class="ma-2 pa-2">
            <v-row>
              <v-col cols="8">
                <v-subheader> Saldo na Carteira </v-subheader>
                <h2 class="ma-2">
                  R$ {{ accountBalance }}
                  <v-btn class="ml-2" color="primary accent-2" depressed @click="withdraw"
                    >Sacar</v-btn
                  >
                </h2>
              </v-col>
              <v-divider vertical></v-divider>
              <v-col cols="4">
                <v-subheader>
                  Conta selecionada
                  <v-btn class="ml-2" text color="primary accent-3" to="/dashboard/account"
                    >Mais</v-btn
                  >
                </v-subheader>
                <v-row justify="start" v-if="selectedAccount != {}">
                  <v-col cols="2">
                    <v-icon>fas fa-university</v-icon>
                  </v-col>
                  <v-col cols="6">
                    <b>{{ selectedAccount.bank_name }}</b>
                  </v-col>
                  <v-col cols="4">
                    <v-row justify="start" class="text-body-2">
                      <b class="mr-1">Ag:</b> {{ selectedAccount.agencia }}
                    </v-row>
                    <v-row justify="start" class="text-body-2">
                      <b class="mr-1">Conta:</b> {{ selectedAccount.conta }}
                    </v-row>
                  </v-col>
                </v-row>
                <v-row justify="start" v-else>
                  <v-col cols="2">
                    <v-icon>fas fa-university</v-icon>
                  </v-col>
                  <v-col cols="6">
                    <b>Nenhuma conta selecionada</b>
                  </v-col>
                </v-row>
              </v-col>
            </v-row>
          </v-sheet>
          <h3 class="my-4">Histórico de saques</h3>
          <v-data-table
            :headers="headers"
            :items="filteredPayouts"
            :page.sync="page"
            :items-per-page="itemsPerPage"
            @page-count="pageCount = $event"
            hide-default-footer
            item-key="name"
            class="elevation-1"
          >
            <template v-slot:top>
              <v-toolbar flat>
                <v-toolbar-title>Saques</v-toolbar-title>
              </v-toolbar>
            </template>
          </v-data-table>
          <div class="text-center pt-2">
            <v-pagination
              v-model="page"
              :length="pagesLength"
              circle
              v-on:change="changePage"
            ></v-pagination>
          </div>
        </v-sheet>
      </v-col>
      <v-overlay :value="loading">
        <v-progress-circular indeterminate size="64"></v-progress-circular>
      </v-overlay>
    </v-row>
    <v-dialog v-model="dialog" scrollable max-width="450px">
      <v-card class="pa-4" min-width="450px">
        <v-card-title>Saque</v-card-title>
        <v-divider></v-divider>
        <v-card-text style="height: 150px" class="mt-2">
          <validation-observer ref="observer" v-slot="{ invalid }">
            <v-form @submit.prevent="submit">
              <validation-provider
                v-slot="{ errors }"
                name="valor"
                :rules="{ required: true, min_value: 1, regex: /^\d*\.?\d*$/ }"
              >
                <v-text-field
                  label="Valor"
                  v-model="amount"
                  :error-messages="errors"
                  required
                ></v-text-field>
              </validation-provider>
              <v-btn class="white--text mr-4" color="success" type="submit" :disabled="invalid">
                Sacar
              </v-btn>
              <v-btn class="white--text" color="error" @click="dialog = false" text> Fechar </v-btn>
            </v-form>
          </validation-observer>
        </v-card-text>
      </v-card>
    </v-dialog>
  </v-container>
</template>

<script>
import { mapGetters } from 'vuex';
import { getMyBankAccounts, getMyPayouts, createPayout, getMyBalance } from '@/graphql/queries';
// eslint-disable-next-line camelcase
import { required, regex, min_value } from 'vee-validate/dist/rules';
import { extend, ValidationObserver, ValidationProvider, setInteractionMode } from 'vee-validate';

setInteractionMode('eager');

extend('required', {
  ...required,
  message: '{_field_} não pode ser vazio',
});

extend('regex', {
  ...regex,
  message: '{_field_} em formato inválido.',
});

extend('min_value', {
  // eslint-disable-next-line camelcase
  ...min_value,
  message: '{_field_} não pode ser 0 ou negativo.',
});

export default {
  title: 'Saque | Find a Tutor',
  components: {
    ValidationProvider,
    ValidationObserver,
  },
  data() {
    return {
      page: 1,
      pagesLength: 1,
      pages: [],
      itemsPerPage: 10,
      search: '',
      amount: 0.0,
      loading: true,
      show: false,
      dialog: false,
      zIndex: 2,
      payouts: [],
      filteredPayouts: [],
      accountBalance: 0.0,
      selectedAccount: {},
      alert: false,
      alertMessage: '',
    };
  },
  computed: {
    headers() {
      return [
        { text: 'Data', value: 'updated_at', align: 'center' },
        { text: 'Valor', value: 'value', align: 'center' },
        { text: 'Status', value: 'status', align: 'center' },
      ];
    },
    ...mapGetters('auth', ['currentUser']),
  },
  methods: {
    withdraw() {
      this.amount = 0.0;
      this.dialog = true;
    },
    paginate() {
      const numPages = Math.ceil(this.filteredPayouts.length / 12);
      const paginated = this.$chunkify(this.filteredPayouts, numPages, false);
      this.pagesLength = paginated.length;
      this.pages = paginated;
      // eslint-disable-next-line prefer-destructuring
      this.filteredPayouts = paginated[0];
    },
    changePage() {
      this.filteredPayouts = this.pages[this.page - 1];
    },
    getMyBankAccounts() {
      this.$gqlClient
        .query({
          query: this.$gql(getMyBankAccounts),
          fetchPolicy: 'network-only',
          variables: { user_id: this.currentUser.username },
        })
        .then((response) => {
          const result = JSON.parse(response.data.getMyBankAccounts);
          result.forEach((account) => {
            if (account.favorite) {
              this.selectedAccount = account;
            }
          });
          this.accounts = result;
        });
    },
    getMyPayouts() {
      this.$gqlClient
        .query({
          query: this.$gql(getMyPayouts),
          fetchPolicy: 'network-only',
          variables: { user_id: this.currentUser.username },
        })
        .then((response) => {
          const result = JSON.parse(response.data.getMyPayouts);
          this.payouts = result;
          this.filteredPayouts = result;
          this.paginate();
          this.loading = false;
        });
    },
    getMyBalance() {
      try {
        this.$gqlClient
          .query({
            query: this.$gql(getMyBalance),
            fetchPolicy: 'network-only',
            variables: { user_id: this.currentUser.username },
          })
          .then((response) => {
            const result = JSON.parse(response.data.getMyBalance);
            this.accountBalance = result;
          });
      } catch (error) {
        this.alertMessage = 'Ocorreu um erro.';
        this.alert = true;
      }
    },
    submit() {
      this.$refs.observer.validate();
      if (this.amount > this.accountBalance) {
        this.dialog = false;
        this.alertMessage = 'Você não possui saldo suficiente para essa operação';
        this.alert = true;
      } else {
        this.createPayout();
      }
    },
    createPayout() {
      this.$gqlClient
        .query({
          query: this.$gql(createPayout),
          fetchPolicy: 'network-only',
          variables: {
            user_id: this.currentUser.username,
            value: this.amount,
          },
        })
        .then((response) => {
          const result = JSON.parse(response.data.createPayout);
          this.payouts.push(result);
          this.paginate();
          this.changePage(-1);
          this.dialog = false;
          this.alert = false;
          this.getMyBalance();
        });
    },
  },
  created() {
    this.getMyBankAccounts();
    this.getMyPayouts();
    this.getMyBalance();
  },
};
</script>
