<template>
  <v-container>
    <v-row justify="center">
      <v-col xl="2" lg="8" md="8" sm="12" xs="12">
        <v-card class="d-flex flex-column mt-6">
          <v-btn :to="{ name: 'DashboardMain' }" tile>Informações</v-btn>
          <v-btn :to="{ name: 'DashboardWithdrawal' }" tile>Saque</v-btn>
          <v-btn :to="{ name: 'DashboardWithdrawalAccount' }" tile>Contas Bancárias</v-btn>
          <v-btn :to="{ name: 'DashboardCourses' }" tile>Cursos</v-btn>
          <v-btn :to="{ name: 'DashboardClasses' }" tile>Turmas</v-btn>
          <v-btn :to="{ name: 'DashboardExercises' }" tile>Exercícios</v-btn>
          <v-btn :to="{ name: 'DashboardPaths' }" tile>Trilhas</v-btn>
        </v-card>
      </v-col>
      <v-col xl="10" lg="12" md="8" sm="12" xs="12">
        <router-view></router-view>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
export default {
  name: 'Dashboard',

  title: 'Painel | Find a Tutor',

  data: () => ({}),
  methods: {},
};
</script>
