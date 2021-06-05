<template>
  <v-container>
    <v-rating
      class="mb-4"
      v-model="rating"
      background-color="orange lighten-3"
      color="orange"
      large
    ></v-rating>
    <v-textarea
      outlined
      v-model="review"
      v-if="editing"
      name="input-7-4"
      label="Comentário"
    ></v-textarea>
    <p v-else>{{ review }}</p>
    <v-btn v-if="editing" color="success" @click="editing = false">Salvar</v-btn>
    <v-btn v-else color="primary" @click="editing = true">Alterar</v-btn>
  </v-container>
</template>

<script>
export default {
  name: 'CourseReview',
  props: ['id'],
  data: () => ({
    title: '',
    body: '',
    editing: false,
    notes: [],
    rating: 5,
    review: 'Excelente curso',
  }),
  methods: {},
  computed: {},
};
</script>
