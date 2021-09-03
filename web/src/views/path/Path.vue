<template>
  <v-container>
    <v-row justify="center">
      <v-col xl="6" lg="6" md="6" sm="12" xs="12">
        <v-stepper v-model="e6" vertical>
          <template v-for="course in pathCourses">
            <v-stepper-step
              :complete="e6 > course.order"
              :step="course.order"
              @click="e6 = course.order"
              class="stepper-clickable"
              :key="course.id"
            >
              {{ course.section_name }}
            </v-stepper-step>

            <v-stepper-content :step="course.order" :key="course.id + course.order">
              <v-skeleton-loader
                v-bind="attrs"
                type="card, article, actions"
                v-if="loading"
              ></v-skeleton-loader>
              <CourseCardFull
                :courseName="course.name"
                :courseImage="course.image"
                :courseRating="course.avg_rating"
                :courseReviews="course.reviews"
                :courseCategory="course.category_name"
                :courseDescription="course.short_description"
                :courseId="course.id"
                courseLanguage="pt-br"
                :courseCost="course.price"
                v-else
              />
              <v-btn
                color="primary"
                @click="e6 = course.order + 1"
                v-if="course.order <= pathCourses.length"
              >
                Continuar
              </v-btn>
              <v-btn text v-if="course.order <= pathCourses.length"> Cancelar </v-btn>
            </v-stepper-content>
          </template>
        </v-stepper>
      </v-col>
      <v-col xl="6" lg="6" md="6" sm="12" xs="12">
        <v-skeleton-loader
          v-bind="attrs"
          type="card, article, actions"
          v-if="loadingPath"
        ></v-skeleton-loader>
        <v-card width="400" v-else>
          <v-img height="200px" :src="$cloudfrontUrl + 'public/' + path.image"> </v-img>

          <v-card-text class="text--primary">
            <v-row align="center" class="mx-0 my-2">
              <v-card-title> {{ path.name }} </v-card-title>

              <v-rating
                v-model="path.avg_rating"
                color="amber"
                dense
                half-increments
                readonly
                size="14"
              ></v-rating>

              <div class="grey--text ml-2 mr-4">{{ path.avg_rating }} ({{ path.reviews }})</div>
              <v-btn class="my-4" color="primary" text @click="unsavePath" v-if="saved">
                <v-icon class="mr-2">{{ bookmarkIcon }} </v-icon> {{ bookmarkText }}
              </v-btn>
              <v-btn class="my-4" color="primary" text @click="savePath" v-else>
                <v-icon class="mr-2">{{ bookmarkIcon }} </v-icon> {{ bookmarkText }}
              </v-btn>
            </v-row>

            <div>
              {{ path.description }}
            </div>
            <v-avatar size="56" class="mt-10">
              <img alt="Foto do criador da trilha" :src="pathOwnerPicture" />
            </v-avatar>
            <p class="my-2">{{ path.owner_name }}</p>
          </v-card-text>
        </v-card>
        <v-card width="400" class="mt-4">
          <v-card-text class="text--primary">
            <v-subheader>Deixe sua avaliação</v-subheader>
            <v-rating
              class="mb-4"
              v-model="rating"
              background-color="orange lighten-3"
              color="orange"
              half-increments
              large
            ></v-rating>
            <v-btn color="primary" @click="ratePath" text> Avaliar </v-btn>
          </v-card-text>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import CourseCardFull from '@/components/CourseCardFull.vue';
import { mapGetters } from 'vuex';
import {
  getPath,
  getPathCourses,
  getMySavedPaths,
  ratePath,
  savePath,
  unsavePath,
  getPathRate,
} from '@/graphql/queries';

export default {
  name: 'Path',
  title: 'Detalhes da trilha | Find a Tutor',
  components: {
    CourseCardFull,
  },
  data: () => ({
    attrs: {
      class: 'mb-6',
      boilerplate: true,
      elevation: 2,
    },
    loading: true,
    loadingPath: true,
    e6: 1,
    saved: false,
    rating: 0,
    pathOwnerPicture: '',
    path: {},
    pathCourses: [
      {
        name: 'nome',
        image: 'imagem',
        avg_rating: 5,
        reviews: 1,
        category_name: 'categoria',
        short_description: 'descrição',
        id: 1,
        price: 100,
        order: 1,
        section_name: 'seção',
      },
    ],
  }),
  computed: {
    bookmarkIcon() {
      if (this.saved) {
        return 'fas fa-bookmark';
      }
      return 'far fa-bookmark';
    },
    bookmarkText() {
      if (this.saved) {
        return 'Remover';
      }
      return 'Salvar';
    },
    ...mapGetters('auth', ['currentUser']),
  },
  methods: {
    getPath() {
      this.$gqlClient
        .query({
          query: this.$gql(getPath),
          variables: { id: this.$route.params.id },
          fetchPolicy: 'network-only',
        })
        .then((response) => {
          const result = JSON.parse(response.data.getPath);
          this.path = result;
          this.$getProfilePicture(result.creator_id, result.owner_picture).then((resultPicture) => {
            this.pathOwnerPicture = resultPicture;
          });
          this.loadingPath = false;
        });
    },
    getPathCourses() {
      this.$gqlClient
        .query({
          query: this.$gql(getPathCourses),
          variables: { path_id: this.$route.params.id },
          fetchPolicy: 'network-only',
        })
        .then((response) => {
          const result = JSON.parse(response.data.getPathCourses);
          this.pathCourses = result;
          this.loading = false;
        });
    },
    getPathRate() {
      this.$gqlClient
        .query({
          query: this.$gql(getPathRate),
          variables: {
            path_id: this.$route.params.id,
            user_id: this.currentUser.username,
          },
          fetchPolicy: 'network-only',
        })
        .then((response) => {
          const result = JSON.parse(response.data.getPathRate);
          if (result.length > 0) {
            // eslint-disable-next-line prefer-destructuring
            this.rating = result[0].rating;
          }
        });
    },
    getMySavedPaths() {
      this.$gqlClient
        .query({
          query: this.$gql(getMySavedPaths),
          variables: { id: this.currentUser.username },
          fetchPolicy: 'network-only',
        })
        .then((response) => {
          const result = JSON.parse(response.data.getMySavedPaths);
          result.forEach((path) => {
            if (path.id === this.$route.params.id) {
              this.saved = true;
            }
          });
        });
    },
    ratePath() {
      this.$gqlClient.query({
        query: this.$gql(ratePath),
        variables: {
          path_id: this.$route.params.id,
          user_id: this.currentUser.username,
          rating: this.rating,
        },
        fetchPolicy: 'network-only',
      });
    },
    savePath() {
      this.$gqlClient.query({
        query: this.$gql(savePath),
        variables: {
          path_id: this.$route.params.id,
          user_id: this.currentUser.username,
        },
        fetchPolicy: 'network-only',
      });
      this.saved = true;
    },
    unsavePath() {
      this.$gqlClient.query({
        query: this.$gql(unsavePath),
        variables: {
          path_id: this.$route.params.id,
          user_id: this.currentUser.username,
        },
        fetchPolicy: 'network-only',
      });
      this.saved = false;
    },
  },
  created() {
    this.getPath();
    this.getPathCourses();
    this.getMySavedPaths();
    this.getPathRate();
  },
  register() {
    this.updateView();
  },
};
</script>

<style lang="css" scoped>
.stepper-clickable :hover {
  cursor: pointer;
}
</style>
