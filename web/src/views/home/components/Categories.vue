<template>
  <v-row justify="space-around" align="center" class="mt-2">
    <v-col xl="10" lg="10" md="8" sm="6" xs="6">
      <v-chip-group multiple active-class="primary--text">
        <v-chip v-for="tag in tags" :key="tag" to="/search">
          {{ tag }}
        </v-chip>
      </v-chip-group>
    </v-col>
    <v-col xl="2" lg="2" md="4" sm="6" xs="6">
      <v-btn text color="primary" to="/categories"> Ver Todas </v-btn>
    </v-col>
  </v-row>
</template>

<script>
export default {
  data: () => ({
    tags: [
      'Tecnologia',
      'Decoração',
      'Economia',
      'Culinária',
      'Arte',
      'Escrita',
      'Pintura',
      'Finanças Pessoais',
      'Inglês',
      'Fotografia',
      'Exercícios',
      'Matemática',
      'Filosofia',
      'Biologia',
      'Química',
      'Português',
      'História',
      'Física',
    ],
  }),
};
</script>
