<template>
  <v-slide-group
    v-model="model"
    class="pa-4"
    active-class="success"
    v-if="courses.length > 0"
    show-arrows
  >
    <v-slide-item v-for="course in courses" :key="course.id">
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
      <v-skeleton-loader
        class="mx-auto mr-2"
        width="400"
        height="800"
        type="card"
      ></v-skeleton-loader>
    </v-slide-item>
  </v-slide-group>
</template>

<script>
import CourseCardFull from '@/components/CourseCardFull.vue';
import { getStudyingNow } from '@/graphql/queries';

export default {
  name: 'StudyingCourses',

  components: {
    CourseCardFull,
  },

  data: () => ({
    loading: false,
    selection: 1,
    model: null,
    courses: [],
  }),

  methods: {
    reserve() {
      this.loading = true;

      // eslint-disable-next-line no-return-assign
      setTimeout(() => (this.loading = false), 2000);
    },
    getStudyingNow() {
      this.$gqlClient
        .query({
          query: this.$gql(getStudyingNow),
        })
        .then((response) => {
          const courses = JSON.parse(response.data.getStudyingNow);
          this.courses = courses;
        });
    },
  },
  created() {
    this.getStudyingNow();
  },
};
</script>
