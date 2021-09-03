<template>
  <v-slide-group
    v-model="model"
    class="pa-4"
    active-class="success"
    v-if="popularCourses.length > 0"
    show-arrows
  >
    <v-slide-item v-for="course in popularCourses" :key="course.id">
      <CourseCardFull
        :courseName="course.name"
        :courseImage="course.image"
        :courseRating="course.avg_rating"
        :courseReviews="course.reviews"
        :courseCategory="course.category_name"
        :courseDescription="course.short_description"
        :courseId="course.id"
        courseLanguage="pt-br"
        :courseCost="course.price"
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
import CourseCardFull from '@/components/CourseCardFull.vue';
import { getPopularCourses } from '@/graphql/queries';

export default {
  name: 'PopularCourses',
  components: { CourseCardFull },
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
