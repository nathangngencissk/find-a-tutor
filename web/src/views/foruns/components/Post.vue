<template>
  <v-container>
    <v-card elevation="1">
      <v-card-title>
        <v-row justify="start">
          <v-col cols="2" class="d-flex flex-column justify-center align-center">
            <v-avatar size="75">
              <v-img :src="ownerImage"></v-img>
            </v-avatar>
            <span class="post-owner-name">{{ ownerName }}</span>
          </v-col>
          <v-col cols="8" class="d-flex flex-column">
            <h1 class="post-title">{{ title }}</h1>
            <v-card-text>
              <p>
                {{ text }}
              </p>
            </v-card-text>
          </v-col>
          <v-col cols="2" class="d-flex flex-column justify-center">
            <v-btn icon :color="liked ? 'orange' : 'grey darken-1'" @click="like">
              <v-icon>mdi-thumb-up</v-icon>
            </v-btn>
            <v-btn icon :color="disliked ? 'indigo' : 'grey darken-1'" @click="dislike">
              <v-icon>mdi-thumb-down</v-icon>
            </v-btn>
          </v-col>
        </v-row>
      </v-card-title>
    </v-card>
  </v-container>
</template>

<script>
export default {
  name: 'Post',
  data: () => ({
    liked: false,
    disliked: false,
  }),
  props: ['id', 'title', 'text', 'ownerImage', 'ownerName'],
  methods: {
    like() {
      this.liked = !this.liked;
      this.disliked = false;
    },
    dislike() {
      this.disliked = !this.disliked;
      this.liked = false;
    },
  },
};
</script>

<style lang="scss" scoped>
.post-owner-name {
  font-weight: 300;
  line-height: 1.4;
  font-size: 0.9rem;
  margin-top: 8px;
}
</style>
