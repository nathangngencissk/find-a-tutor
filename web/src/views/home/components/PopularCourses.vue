<template>
  <v-slide-group
    v-model="model"
    class="pa-4"
    active-class="success"
    v-if="popularCourses.length > 0"
    show-arrows
  >
    <v-slide-item v-for="course in popularCourses" :key="course.id">
      <PopularCourseCard
        :id="course.id"
        :name="course.name"
        :category="course.category_name"
        :description="course.short_description"
        :price="course.price"
        :rating="course.avg_rating"
        :classes="course.classes"
        :reviews="course.reviews"
        :image="course.image"
        :loading="loading"
      />
    </v-slide-item>
  </v-slide-group>
  <v-slide-group v-else>
    <v-slide-item v-for="index in 5" :key="index">
      <v-skeleton-loader width="400" class="mx-auto mr-2" type="card"></v-skeleton-loader>
    </v-slide-item>
  </v-slide-group>
</template>

<script>
import PopularCourseCard from '@/views/home/components/PopularCourseCard.vue';
import { getPopularCourses } from '@/graphql/queries';

export default {
  name: 'PopularCourses',
  components: { PopularCourseCard },
  data: () => ({
    loading: false,
    model: null,
    popularCourses: [],
  }),
  methods: {
    reserve() {
      this.loading = true;

      // eslint-disable-next-line no-return-assign
      setTimeout(() => (this.loading = false), 2000);
    },
    getPopularCourses() {
      this.$gqlClient
        .query({
          query: this.$gql(getPopularCourses),
          fetchPolicy: 'network-only',
        })
        .then((response) => {
          const popularCourses = JSON.parse(response.data.getPopularCourses);
          this.popularCourses = popularCourses;
        });
    },
  },
  created() {
    this.getPopularCourses();
  },
};
</script>
