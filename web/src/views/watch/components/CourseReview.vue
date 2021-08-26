<template>
  <v-container>
    <v-rating
      class="mb-4"
      v-model="rate.rating"
      background-color="orange lighten-3"
      color="orange"
      large
    ></v-rating>
    <v-textarea
      outlined
      v-model="rate.content"
      v-if="editing"
      name="input-7-4"
      label="Comentário"
    ></v-textarea>
    <p v-else>{{ rate.content }}</p>
    <v-btn v-if="editing" color="success" @click="save">Salvar</v-btn>
    <v-btn v-else color="primary" @click="editing = true">Alterar</v-btn>
  </v-container>
</template>

<script>
import { rateCourse } from '@/graphql/queries';

export default {
  name: 'CourseReview',
  props: ['rate', 'courseId'],
  data: () => ({
    title: '',
    body: '',
    editing: false,
    notes: [],
  }),
  methods: {
    save() {
      this.editing = false;
      this.rateCourse();
    },
    rateCourse() {
      this.$gqlClient.query({
        query: this.$gql(rateCourse),
        variables: {
          course_id: this.$route.params.id,
          user_id: this.currentUser.username,
          rating: this.rate.rating,
          content: this.rate.content,
        },
      });
    },
  },
  computed: {},
  created() {
    console.log(this.rate);
  },
};
</script>
