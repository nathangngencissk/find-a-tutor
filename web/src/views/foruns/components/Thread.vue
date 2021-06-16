<template>
  <v-container>
    <v-row justify="center">
      <v-col xl="8" cols="12">
        <Post
          v-for="post in thread.posts"
          :key="post.id"
          :id="post.id"
          :title="post.title"
          :text="post.text"
          :ownerImage="post.ownerImage"
          :ownerName="post.ownerName"
        />
        <Post
          v-for="post in thread.replies"
          :key="post.id"
          :id="post.id"
          :text="post.text"
          :ownerImage="post.ownerImage"
          :ownerName="post.ownerName"
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
          <v-btn color="primary" @click="post">Responder</v-btn>
        </v-sheet>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import { mapGetters } from 'vuex';
import Post from '@/views/foruns/components/Post.vue';

export default {
  name: 'Thread',
  data: () => ({
    threadResponse: '',
  }),
  components: { Post },
  computed: {
    ...mapGetters('auth', ['currentUser']),
    ...mapGetters('profile', ['profilePicture']),
    thread() {
      return this.$route.params.thread;
    },
  },
  methods: {
    post() {
      if (this.threadResponse !== '') {
        const newPost = {
          text: this.threadResponse,
          ownerName: `${this.currentUser.attributes.name} ${this.currentUser.attributes.family_name}`,
          ownerImage: this.profilePicture,
        };
        this.thread.replies.push(newPost);
        console.log(this.thread.replies);
      }
    },
  },
};
</script>
