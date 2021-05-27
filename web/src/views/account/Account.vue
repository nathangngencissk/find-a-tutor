<template>
  <v-container>
    <v-row justify="center">
      <v-col cols="2">
        <v-card class="d-flex flex-column mt-6">
          <v-btn to="/account/personal" tile>Informações Pessoais</v-btn>
          <v-btn to="/account/picture" tile>Foto</v-btn>
          <v-btn to="/account/email" tile>Email</v-btn>
          <v-btn to="/account/password" tile>Senha</v-btn>
        </v-card>
      </v-col>
      <v-col cols="6">
        <router-view></router-view>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
export default {
  name: 'Account',

  title: 'Minha Conta | Find a Tutor',

  data: () => ({}),
  methods: {},
};
</script>
