<template>
  <v-slide-group v-model="model" class="pa-4" active-class="success" show-arrows>
    <v-slide-item v-for="n in 6" :key="n">
      <v-card class="mx-auto mr-4" max-width="400" :loading="loading">
        <v-img
          class="white--text align-end"
          height="200px"
          src="https://cdn.vuetifyjs.com/images/cards/docks.jpg"
        >
          <v-card-title>Programação C#</v-card-title>
        </v-img>

        <v-card-subtitle class="pb-0"> Tecnologia </v-card-subtitle>

        <v-card-text class="text--primary">
          <v-row align="center" class="mx-0 my-2">
            <v-rating
              :value="4.5"
              color="amber"
              dense
              half-increments
              readonly
              size="14"
            ></v-rating>

            <div class="grey--text ml-2 mr-4">4.5 (413)</div>
            <div class="my-4 subtitle-1">R$150</div>
            <div class="ml-4">
              <v-img max-height="20" max-width="20" src="@/assets/flags/pt-br.png"></v-img>
            </div>
          </v-row>
          <div>
            Lorem ipsum, dolor sit amet consectetur adipisicing elit. Quia soluta alias eveniet
            ipsam recusandae quam? Repellendus, neque delectus explicabo consequatur perspiciatis
            rem quos nisi ipsa libero ex necessitatibus dolorem quo?
          </div>
        </v-card-text>

        <v-card-actions>
          <v-btn color="blue darken-4" text> Ver Curso </v-btn>
        </v-card-actions>
      </v-card>
    </v-slide-item>
  </v-slide-group>
</template>

<script>
export default {
  name: 'StudyingCourses',

  data: () => ({
    loading: false,
    selection: 1,
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
