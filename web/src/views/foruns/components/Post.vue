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
          <v-col
            cols="2"
            class="d-flex flex-column justify-center"
            v-if="commentLiked != 'no' && ownerUsername !== currentUser.username"
          >
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
import { mapGetters } from 'vuex';
import { likeComment } from '@/graphql/queries';

export default {
  name: 'Post',
  data: () => ({
    commentLiked: null,
  }),
  computed: {
    ...mapGetters('auth', ['currentUser']),
    liked() {
      return this.commentLiked === true;
    },
    disliked() {
      return this.commentLiked === false;
    },
  },
  props: ['id', 'title', 'text', 'ownerImage', 'ownerName', 'propLiked', 'ownerUsername'],
  methods: {
    like() {
      this.commentLiked = this.commentLiked ? null : true;
      this.likeComment(this.commentLiked);
    },
    dislike() {
      this.commentLiked = this.commentLiked === false ? null : false;
      this.likeComment(this.commentLiked);
    },
    likeComment(value) {
      this.$gqlClient.query({
        query: this.$gql(likeComment),
        fetchPolicy: 'network-only',
        variables: {
          value,
          user_id: this.currentUser.username,
          post_comment_id: this.id,
        },
      });
    },
  },
  created() {
    this.commentLiked = this.propLiked;
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
