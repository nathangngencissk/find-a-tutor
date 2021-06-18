<template>
  <v-container>
    <v-row justify="center">
      <v-col xl="8" lg="10" cols="12">
        <v-sheet elevation="1" class="px-4">
          <v-subheader> Contas Bancárias </v-subheader>
          <v-row>
            <v-col v-for="account in accounts" :key="account.id" xl="6" lg="6" cols="12">
              <v-card>
                <v-card-text>
                  <div v-if="account.id === primaryAccount">
                    {{ account.bank_name }}
                    <v-icon color="success accent-2">fas fa-check-circle</v-icon>
                  </div>

                  <div v-else>
                    {{ account.bank_name }}
                  </div>

                  <p class="text-h4 text--primary">{{ account.titular }}</p>
                  <p>{{ account.tipo_conta }}</p>
                  <div class="text--primary">
                    Agência: {{ account.agencia }}<br />
                    Conta: {{ account.conta }}
                  </div>
                </v-card-text>
                <v-card-actions>
                  <v-btn text color="primary accent-4" @click="edit($event, account)">
                    Editar
                  </v-btn>
                  <v-btn text color="error accent-4"> Excluir </v-btn>
                  <v-btn text color="success accent-2" v-if="account.id !== primaryAccount"
                    >Favoritar</v-btn
                  >
                </v-card-actions>
              </v-card>
            </v-col>
          </v-row>
        </v-sheet>
        <v-btn class="mt-6" color="success" @click="add">Adicionar</v-btn>
      </v-col>
    </v-row>
    <v-overlay :z-index="zIndex" :value="overlay" :dark="$vuetify.theme.dark">
      <v-card class="pa-4" min-width="600px">
        <v-form>
          <v-text-field label="Nome do Titular" :value="titular"></v-text-field>
          <v-text-field label="Banco" :value="bank_name"></v-text-field>
          <v-text-field label="Agência" :value="agencia"></v-text-field>
          <v-text-field label="Conta" :value="conta"></v-text-field>
          <v-text-field label="Tipo de Conta" :value="conta"></v-text-field>
        </v-form>
        <v-btn class="white--text mr-4" color="success" @click="overlay = false"> Salvar </v-btn>
        <v-btn class="white--text" color="error" @click="overlay = false"> Fechar </v-btn>
      </v-card>
    </v-overlay>
  </v-container>
</template>

<script>
export default {
  title: 'Saque | Find a Tutor',
  data: () => ({
    primaryAccount: 1,
    accounts: [
      {
        id: 1,
        titular: 'Nathan Gencissk',
        bank_name: 'Banco Inter',
        agencia: '1234',
        conta: '12345-0',
        tipo_conta: 'Conta Corrente',
      },
      {
        id: 2,
        titular: 'Nathan Gencissk',
        bank_name: 'Itaú',
        agencia: '4321',
        conta: '54321-0',
        tipo_conta: 'Conta Corrente',
      },
    ],
    overlay: false,
    zIndex: 2,
    titular: '',
    bank_name: '',
    agencia: '',
    conta: '',
    tipo_conta: '',
  }),
  methods: {
    add() {
      this.titular = '';
      this.bank_name = '';
      this.agencia = '';
      this.conta = '';
      this.tipo_conta = '';
      this.overlay = true;
    },
    edit(event, account) {
      this.titular = account.titular;
      this.bank_name = account.bank_name;
      this.agencia = account.agencia;
      this.conta = account.conta;
      this.tipo_conta = account.tipo_conta;
      this.overlay = true;
    },
  },
};
</script>
