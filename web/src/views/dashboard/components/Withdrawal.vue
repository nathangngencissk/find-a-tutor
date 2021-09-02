<template>
  <v-container>
    <v-row justify="center">
      <v-col xl="10" cols="12">
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
    <v-overlay :z-index="zIndex" :value="overlay" :dark="$vuetify.theme.dark">
      <v-card class="pa-4" min-width="600px">
        <v-form>
          <v-text-field label="Valor" v-model="amount"></v-text-field>
        </v-form>
        <v-btn class="white--text mr-4" color="success" @click="createPayout"> Sacar </v-btn>
        <v-btn class="white--text" color="error" @click="overlay = false" text> Fechar </v-btn>
      </v-card>
    </v-overlay>
  </v-container>
</template>

<script>
import { mapGetters } from 'vuex';
import { getMyBankAccounts, getMyPayouts, createPayout, getMyBalance } from '@/graphql/queries';

export default {
  title: 'Saque | Find a Tutor',
  data() {
    return {
      page: 1,
      pagesLength: 1,
      pages: [],
      itemsPerPage: 10,
      search: '',
      amount: '',
      loading: true,
      show: false,
      overlay: false,
      zIndex: 2,
      payouts: [],
      filteredPayouts: [],
      accountBalance: 0.0,
      selectedAccount: {},
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
      this.amount = '';
      this.overlay = true;
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
          this.overlay = false;
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
