<template>
  <v-container>
    <h2>{{ post.title }}</h2>
    <p class="mt-4">{{ post.body }}</p>
  </v-container>
</template>

<script>
export default {
  name: 'ClassPost',
  data: () => ({}),
  computed: {
    post() {
      return this.$route.params.post;
    },
  },
};
</script>
