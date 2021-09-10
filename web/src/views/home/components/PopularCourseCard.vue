<template>
  <v-card :loading="loading" class="mx-auto mr-4 mb-2" max-width="400">
    <template slot="progress">
      <v-progress-linear color="deep-purple" height="10" indeterminate></v-progress-linear>
    </template>

    <v-img height="250" :src="picture"></v-img>

    <v-card-title>{{ name }}</v-card-title>

    <v-card-text>
      <v-row align="center" class="mx-0">
        <v-rating :value="rating" color="amber" dense half-increments readonly size="14"></v-rating>

        <div class="grey--text ml-4">{{ rating }} ({{ reviews }})</div>
      </v-row>

      <div class="mt-4 mb-2 subtitle-1">R${{ price }}</div>

      <div>
        {{ description }}
      </div>
    </v-card-text>

    <v-divider class="mx-4"></v-divider>

    <v-card-title>Turmas disponíveis em breve</v-card-title>

    <v-card-text>
      <v-chip-group column>
        <v-chip v-for="cl in classes" :key="cl.id">{{ cl.schedule }}</v-chip>
      </v-chip-group>
    </v-card-text>

    <v-card-actions>
      <v-btn color="primary" :to="'/course/' + id"> Ver Curso </v-btn>
    </v-card-actions>
  </v-card>
</template>

<script>
export default {
  name: 'PopularCourses',
  props: [
    'id',
    'name',
    'category',
    'classes',
    'description',
    'rating',
    'price',
    'reviews',
    'image',
    'loading',
  ],
  data: () => ({
    picture: '',
  }),
  async created() {
    this.picture = await this.$getKeyUrl(this.image);
  },
};
</script>
