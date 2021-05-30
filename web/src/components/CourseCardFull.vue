<template>
  <v-card class="mb-4 mr-2" max-width="400">
    <v-img class="white--text align-end" height="200px" :src="courseImage">
      <v-card-title>{{ courseName }}</v-card-title>
    </v-img>

    <v-card-subtitle class="pb-0"> {{ courseCategory }} </v-card-subtitle>

    <v-card-text class="text--primary">
      <v-row align="center" class="mx-0 my-2">
        <v-rating
          :value="courseRatingInteger"
          color="amber"
          dense
          half-increments
          readonly
          size="14"
        ></v-rating>

        <div class="grey--text ml-2 mr-4">{{ courseRating }} ({{ courseReviews }})</div>
        <div v-if="courseCost" class="subtitle-1">R${{ courseCost }}</div>
        <div class="ml-4">
          <v-img max-height="20" max-width="20" :src="flagLanguage"></v-img>
        </div>
      </v-row>
      <div>
        {{ courseDescription }}
      </div>
    </v-card-text>

    <v-card-actions>
      <v-btn color="primary" text to="/course/1"> Ver Curso </v-btn>
    </v-card-actions>
  </v-card>
</template>

<script>
export default {
  name: 'CourseCardFull',

  props: [
    'courseName',
    'courseImage',
    'courseRating',
    'courseReviews',
    'courseCategory',
    'courseDescription',
    'courseId',
    'courseLanguage',
    'courseCost',
  ],

  data: () => ({}),

  computed: {
    flagLanguage() {
      return `@/assets/flags/${this.courseLanguage}.png`;
    },
    courseRatingInteger() {
      return parseFloat(this.courseRating);
    },
  },

  methods: {},
};
</script>
