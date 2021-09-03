<template>
  <v-container>
    <v-row justify="center">
      <v-col xl="2" lg="8" md="8" sm="12" xs="12">
        <v-card class="d-flex flex-column mt-6">
          <v-btn :to="{ name: 'AdminMain' }" tile>Informações</v-btn>
          <v-btn :to="{ name: 'AdminPayments' }" tile>Pagamentos</v-btn>
          <v-btn :to="{ name: 'AdminPayouts' }" tile>Remessas</v-btn>
          <v-btn :to="{ name: 'AdminCourses' }" tile>Cursos</v-btn>
          <v-btn :to="{ name: 'AdminExercises' }" tile>Exercícios</v-btn>
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
  name: 'Admin',

  title: 'Painel Admin | Find a Tutor',

  data: () => ({}),
  methods: {},
};
</script>
