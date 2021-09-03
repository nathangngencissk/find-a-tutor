<template>
  <v-row dense>
    <template v-for="category in mainCategories">
      <v-col :key="category.id" xl="3" lg="4" md="6" sm="6" xs="6">
        <v-hover v-slot="{ hover }">
          <v-card
            class="mx-auto"
            :class="{ 'on-hover': hover }"
            max-width="344"
            :to="{ name: 'Search', query: { search: category.name } }"
          >
            <v-img :src="category.image" height="200px"></v-img>

            <v-card-title> {{ category.name }} </v-card-title>
          </v-card>
        </v-hover>
      </v-col>
    </template>
  </v-row>
</template>

<script>
import { getMainCourseCategories } from '@/graphql/queries';

export default {
  data: () => ({
    transparent: 'rgba(255, 255, 255, 0)',
    mainCategories: [],
  }),
  methods: {
    getMainCourseCategories() {
      this.$gqlClient
        .query({
          query: this.$gql(getMainCourseCategories),
        })
        .then((response) => {
          const mainCategories = JSON.parse(response.data.getMainCourseCategories);
          this.mainCategories = mainCategories;
        });
    },
  },
  created() {
    this.getMainCourseCategories();
  },
};
</script>

<style scoped>
.v-card {
  transition: opacity 0.4s ease-in-out;
}

.on-hover {
  opacity: 0.6;
}

.show-btns {
  color: rgba(255, 255, 255, 1) !important;
}
</style>
