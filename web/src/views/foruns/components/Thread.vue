<template>
  <v-container>
    <v-row justify="center">
      <v-col xl="8" cols="12" v-if="loading">
        <v-skeleton-loader v-bind="attrs" type="article, actions"></v-skeleton-loader>
      </v-col>
      <v-col xl="8" cols="12" v-else>
        <Post
          :key="'post' + post.id"
          :id="post.id"
          :title="post.title"
          :text="post.description"
          :ownerImage="post.avatar"
          :ownerName="post.owner_name"
          propLiked="no"
        />
        <Post
          v-for="comment in comments"
          :key="'comment' + comment.id"
          :id="comment.id"
          :text="comment.content"
          :propLiked="comment.like"
          :ownerImage="comment.avatar"
          :ownerName="comment.creator_name"
          :ownerUsername="comment.user_id"
        />
      </v-col>
    </v-row>
    <v-row justify="center">
      <v-col xl="6" cols="12">
        <v-sheet elevation="1" class="pa-4">
          <v-textarea
            outlined
            name="input-7-4"
            label="Mensagem"
            v-model="threadResponse"
          ></v-textarea>
          <v-btn color="primary" @click="createComment">Responder</v-btn>
        </v-sheet>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import { mapGetters } from 'vuex';
import Post from '@/views/foruns/components/Post.vue';
import { getPost, commentPost } from '@/graphql/queries';

export default {
  name: 'Thread',
  data: () => ({
    loading: true,
    attrs: {
      class: 'mb-6',
      boilerplate: true,
      elevation: 2,
    },
    threadResponse: '',
    post: {},
    comments: [],
  }),
  components: { Post },
  computed: {
    ...mapGetters('auth', ['currentUser']),
    ...mapGetters('profile', ['profilePicture']),
    threadId() {
      return this.$route.params.threadId;
    },
  },
  methods: {
    createComment() {
      if (this.threadResponse !== '') {
        this.commentPost();
      }
    },
    commentPost() {
      this.$gqlClient
        .query({
          query: this.$gql(commentPost),
          fetchPolicy: 'network-only',
          variables: {
            content: this.threadResponse,
            user_id: this.currentUser.username,
            post_id: this.threadId,
          },
        })
        .then((response) => {
          const newPost = JSON.parse(response.data.commentPost);
          newPost.text = this.threadResponse;
          newPost.creator_name = `${this.currentUser.attributes.name} ${this.currentUser.attributes.family_name}`;
          newPost.avatar = this.profilePicture;
          this.comments.push(newPost);
        });
    },
    loadPost() {
      this.$gqlClient
        .query({
          query: this.$gql(getPost),
          fetchPolicy: 'network-only',
          variables: {
            id: this.threadId,
            user_id: this.currentUser.username,
          },
        })
        .then((response) => {
          const post = JSON.parse(response.data.getPost);
          this.$getProfilePicture(post.creator_id, post.owner_picture).then(
            (responsePictureCreator) => {
              // eslint-disable-next-line no-param-reassign
              post.avatar = responsePictureCreator;
              post.comments.forEach((comment) => {
                this.$getProfilePicture(comment.user_id, comment.creator_picture).then(
                  (responsePicture) => {
                    // eslint-disable-next-line no-param-reassign
                    comment.avatar = responsePicture;
                    this.comments.push(comment);
                  }
                );
              });
              this.post = post;
              this.loading = false;
            }
          );
        });
    },
  },
  created() {
    this.loadPost();
  },
};
</script>
