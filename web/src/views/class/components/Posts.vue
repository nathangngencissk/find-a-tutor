<template>
  <v-container>
    <v-subheader>Postagens</v-subheader>
    <v-row>
      <v-col cols="4">
        <v-list subheader two-line flat>
          <v-list-item-group v-model="settings" multiple>
            <v-list-item
              v-for="post in posts"
              :key="post.id"
              :to="{ name: 'ClassPost', params: { post: post } }"
            >
              <template v-slot:default="{ active }">
                <v-list-item-action>
                  <v-checkbox :input-value="active" color="primary"></v-checkbox>
                </v-list-item-action>

                <v-list-item-content>
                  <v-list-item-title>{{ post.title }}</v-list-item-title>
                  <v-list-item-subtitle>{{ post.body }}</v-list-item-subtitle>
                </v-list-item-content>
                <v-list-item-action>
                  <v-list-item-action-text v-text="post.action"></v-list-item-action-text>
                </v-list-item-action>
              </template>
            </v-list-item>
          </v-list-item-group>
        </v-list>
      </v-col>
      <v-divider vertical inset></v-divider>
      <v-col cols="8">
        <router-view></router-view>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import { getCourseClassPosts } from '@/graphql/queries';

export default {
  name: 'ClassPosts',
  title: 'Turma Programação C# | Postagens | Find a Tutor',
  data: () => ({
    settings: [],
    posts: [],
  }),
  methods: {
    getCourseClassPosts() {
      this.$gqlClient
        .query({
          query: this.$gql(getCourseClassPosts),
          fetchPolicy: 'network-only',
          variables: { course_class_id: this.$route.params.id },
        })
        .then((response) => {
          const result = JSON.parse(response.data.getCourseClassPosts);
          this.posts = result;
          console.log(result);
        });
    },
  },
  created() {
    this.getCourseClassPosts();
  },
};
</script>
