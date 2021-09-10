<template>
  <v-container>
    <h1>{{ cl.name }}</h1>
    <v-row class="mt-4">
      <v-col xl="3" lg="3" md="4" sm="12" xs="12">
        <v-card class="mb-4 mr-2" max-width="400" height="100%">
          <v-img class="white--text align-end" height="200px" :src="classImage" />

          <v-list dense>
            <v-list-item v-for="item in items" :key="item.title">
              <v-list-item-icon>
                <v-icon>{{ item.icon }}</v-icon>
              </v-list-item-icon>

              <v-list-item-content>
                <v-btn depressed :to="{ name: item.url }" block>{{ item.title }}</v-btn>
              </v-list-item-content>
            </v-list-item>
          </v-list>
          <v-divider></v-divider>

          <v-card-text class="text--primary">
            <v-row justify="center">
              <div class="my-6">
                de <b>{{ cl.start_date }}</b> até <b>{{ cl.end_date }}</b>
              </div>
            </v-row>
          </v-card-text>

          <v-card-actions>
            <v-row justify="center" align="center">
              <v-col cols="8" class="d-flex flex-column">
                <v-btn color="primary" outlined class="mb-4" to="/course/1"> Acessar Curso </v-btn>
                <v-btn color="error" text> Cancelar Matricula </v-btn>
              </v-col>
            </v-row>
          </v-card-actions>
        </v-card>
      </v-col>
      <v-col xl="9" lg="9" md="8" sm="12" xs="12">
        <v-sheet height="100%" width="100%" elevation="1">
          <router-view></router-view>
        </v-sheet>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import { getCourseClass } from '@/graphql/queries';

export default {
  name: 'Class',
  title: 'Detalhes da Turma | Find a Tutor',
  data: () => ({
    items: [
      { title: 'Aula', icon: 'far fa-play-circle', url: 'ClassLecture' },
      { title: 'Postagens', icon: 'fas fa-chalkboard', url: 'ClassPosts' },
    ],
    cl: {},
    classImage: '',
  }),
  methods: {
    getCourseClass() {
      this.$gqlClient
        .query({
          query: this.$gql(getCourseClass),
          variables: { id: this.$route.params.id },
        })
        .then(async (response) => {
          const result = JSON.parse(response.data.getCourseClass);
          // eslint-disable-next-line prefer-destructuring
          this.cl = result[0];
          this.classImage = await this.$getKeyUrl(this.cl.image);
        });
    },
  },
  created() {
    this.getCourseClass();
  },
};
</script>
