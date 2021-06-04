<template>
  <v-container>
    <v-row justify="center">
      <v-col cols="2">
        <v-card class="d-flex flex-column mt-6">
          <v-btn :to="{ name: 'DashboardMain' }" tile>Informações</v-btn>
          <v-btn :to="{ name: 'DashboardCourses' }" tile>Cursos</v-btn>
          <v-btn :to="{ name: 'DashboardClasses' }" tile>Turmas</v-btn>
          <v-btn :to="{ name: 'DashboardExercises' }" tile>Exercícios</v-btn>
        </v-card>
      </v-col>
      <v-col cols="10">
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
