<template>
  <v-container>
    <v-row justify="center">
      <v-col xl="2" lg="2" md="3" sm="3" xs="4">
        <h1>Find a Tutor</h1>
      </v-col>
    </v-row>
    <v-row justify="center">
      <v-col xl="2" lg="2" md="3" sm="3" xs="4">
        <v-img
          :aspect-ratio="16 / 9"
          max-height="200"
          max-width="200"
          min-width="100"
          min-height="100"
          src="@/assets/main-logo.png"
          id="main_logo"
        ></v-img>
      </v-col>
    </v-row>
    <v-row justify="center">
      <v-col cols="8">
        <p>
          Plataforma de comercialização de cursos, apresentada como requisito parcial de aprovação
          da disciplina de Trabalho de Conclusão de Curso de Bacharelado em Sistemas de Informação
          da Universidade Positivo.
        </p>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
export default {
  title: 'Sobre | Find a Tutor',
};
</script>
