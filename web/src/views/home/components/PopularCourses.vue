<template>
  <v-slide-group v-model="model" class="pa-4" active-class="success" show-arrows>
    <v-slide-item v-for="n in 6" :key="n">
      <v-card :loading="loading" class="mx-auto mr-4" max-width="400">
        <template slot="progress">
          <v-progress-linear color="deep-purple" height="10" indeterminate></v-progress-linear>
        </template>

        <v-img height="250" src="@/assets/interFace4.png"></v-img>

        <v-card-title>Nome do Curso</v-card-title>

        <v-card-text>
          <v-row align="center" class="mx-0">
            <v-rating
              :value="4.5"
              color="amber"
              dense
              half-increments
              readonly
              size="14"
            ></v-rating>

            <div class="grey--text ml-4">4.5 (413)</div>
          </v-row>

          <div class="mt-4 mb-2 subtitle-1">R$150</div>
          <div class="mb-2">
            <v-img max-height="20" max-width="20" src="@/assets/flags/pt-br.png"></v-img>
          </div>

          <div>
            Lorem ipsum dolor sit amet consectetur, adipisicing elit. Quibusdam autem, nulla ut
            pariatur atque, voluptates amet accusamus temporibus totam dignissimos eius quasi ipsa
            veritatis repudiandae eaque, eum fuga facere rerum.
          </div>
        </v-card-text>

        <v-divider class="mx-4"></v-divider>

        <v-card-title>Turmas disponíveis em breve</v-card-title>

        <v-card-text>
          <v-chip-group column>
            <v-chip>Segunda-feira 5:30PM</v-chip>

            <v-chip>Segunda-feira 7:30PM</v-chip>

            <v-chip>Quinta-feira 8:00PM</v-chip>

            <v-chip>Domingo 9:00PM</v-chip>
          </v-chip-group>
        </v-card-text>

        <v-card-actions>
          <v-btn color="primary" text @click="reserve" to="/course/1"> Ver Curso </v-btn>
        </v-card-actions>
      </v-card>
    </v-slide-item>
  </v-slide-group>
</template>

<script>
export default {
  name: 'PopularCourses',

  data: () => ({
    loading: false,
    model: null,
  }),

  methods: {
    reserve() {
      this.loading = true;

      // eslint-disable-next-line no-return-assign
      setTimeout(() => (this.loading = false), 2000);
    },
  },
};
</script>
