<template>
  <v-container>
    <h2>{{ post.title }} {{ postId }}</h2>
    <p class="mt-4">{{ post.body }}</p>
  </v-container>
</template>

<script>
export default {
  name: 'ClassPost',
  data: () => ({
    post: {
      id: 1,
      action: '15 min',
      body: 'Lorem ipsum, dolor sit amet consectetur adipisicing elit. Cumque aliquam similique repudiandae, repellendus deserunt velit provident delectus. Odio, cumque in quo fugit veritatis, molestias repudiandae corrupti earum ex est a.',
      subtitle: `I'll be in your neighborhood doing errands this weekend. Do you want to hang out?`,
      title: 'Título',
    },
  }),
  computed: {
    postId() {
      return this.$route.params.postId;
    },
  },
};
</script>
