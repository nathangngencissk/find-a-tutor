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
                  R$ 7284,52
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
                <v-row justify="start">
                  <v-col cols="2">
                    <v-icon>fas fa-university</v-icon>
                  </v-col>
                  <v-col cols="6">
                    <b>Banco Inter</b>
                  </v-col>
                  <v-col cols="4"> 12345-0 </v-col>
                </v-row>
              </v-col>
            </v-row>
          </v-sheet>
          <h3 class="my-4">Histórico de saques</h3>
          <v-data-table
            :headers="headers"
            :items="withdrawals"
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
            <v-pagination v-model="page" :length="pageCount"></v-pagination>
            <v-text-field
              :value="itemsPerPage"
              label="Itens por página"
              type="number"
              min="-1"
              max="15"
              @input="itemsPerPage = parseInt($event, 10)"
            ></v-text-field>
          </div>
        </v-sheet>
      </v-col>
    </v-row>
    <v-overlay :z-index="zIndex" :value="overlay" :dark="$vuetify.theme.dark">
      <v-card class="pa-4" min-width="600px">
        <v-form>
          <v-text-field label="Valor" :value="amount"></v-text-field>
          <v-text-field
            v-model="password"
            label="Senha"
            required
            :append-icon="show ? 'mdi-eye' : 'mdi-eye-off'"
            :type="show ? 'text' : 'password'"
            :rules="passwordRules"
            @click:append="show = !show"
          ></v-text-field>
        </v-form>
        <v-btn class="white--text mr-4" color="success" @click="overlay = false"> Sacar </v-btn>
        <v-btn class="white--text" color="error" @click="overlay = false"> Fechar </v-btn>
      </v-card>
    </v-overlay>
  </v-container>
</template>

<script>
export default {
  title: 'Saque | Find a Tutor',
  data() {
    return {
      page: 1,
      pageCount: 0,
      itemsPerPage: 10,
      search: '',
      amount: '',
      password: '',
      show: false,
      overlay: false,
      zIndex: 2,
      passwordRules: [
        (v) => !!v || 'Senha é necessária',
        (v) => (v && v.length >= 8) || 'Senha deve ter no mínimo 8 caracteres',
      ],
      withdrawals: [
        {
          id: 1,
          date: '2021-06-20 14:32',
          amount: 'R$140,32',
          status: 'COMPLETO',
        },
        {
          id: 2,
          date: '2021-05-26 19:45',
          amount: 'R$2062,45',
          status: 'COMPLETO',
        },
      ],
    };
  },
  computed: {
    headers() {
      return [
        { text: 'Data', value: 'date', align: 'center' },
        { text: 'Valor', value: 'amount', align: 'center' },
        { text: 'Status', value: 'status', align: 'center' },
      ];
    },
  },
  methods: {
    withdraw() {
      this.amount = '';
      this.password = '';
      this.overlay = true;
    },
  },
};
</script>
