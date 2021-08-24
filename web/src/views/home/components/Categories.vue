<template>
  <v-row justify="space-around" align="center" class="mt-2">
    <v-col xl="10" lg="10" md="8" sm="6" xs="6">
      <v-chip-group multiple active-class="primary--text">
        <v-chip v-for="category in categories" :key="category.id" to="/search">
          {{ category.name }}
        </v-chip>
      </v-chip-group>
    </v-col>
    <v-col xl="2" lg="2" md="4" sm="6" xs="6">
      <v-btn text color="primary" to="/categories"> Ver Todas </v-btn>
    </v-col>
  </v-row>
</template>

<script>
import { getAllCourseCategories } from '@/graphql/queries';

export default {
  data: () => ({
    categories: [],
  }),
  methods: {
    getCategories() {
      this.$gqlClient
        .query({
          query: this.$gql(getAllCourseCategories),
        })
        .then((response) => {
          const categories = JSON.parse(response.data.getAllCourseCategories);
          this.categories = categories;
        });
    },
  },
  created() {
    this.getCategories();
  },
};
</script>
