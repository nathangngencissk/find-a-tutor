<template>
  <v-slide-group v-model="model" class="pa-4" active-class="success" show-arrows>
    <v-slide-item v-for="n in 6" :key="n">
      <CourseCardFull
        courseName="Programação C#"
        courseImage="https://cdn.vuetifyjs.com/images/cards/docks.jpg"
        courseRating="4.5"
        courseReviews="413"
        courseCategory="Tecnologia"
        courseDescription="Lorem ipsum dolor sit amet, consectetur adipisicing elit. Repellat nemo inventore dolor fugiat exercitationem sint expedita facilis ea itaque, illum, doloremque praesentium autem similique quis placeat id maxime sunt nulla!"
        courseId="2"
        courseLanguage="pt-br"
        courseCost="150"
      />
    </v-slide-item>
  </v-slide-group>
</template>

<script>
import CourseCardFull from '@/components/CourseCardFull.vue';

export default {
  name: 'StudyingCourses',

  components: {
    CourseCardFull,
  },

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
