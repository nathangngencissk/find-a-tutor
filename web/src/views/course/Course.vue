<template>
  <v-container>
    <v-row justify="center">
      <v-col xs="12" xl="6" lg="12" md="12" sm="12" class="mt-4">
        <h2 class="mb-6">{{ courseName }}</h2>
        <h3 class="mb-2">Descrição</h3>
        <v-sheet elevation="1" class="pa-6">
          <div v-html="compiledMarkdown"></div>
        </v-sheet>
        <h3 class="mt-4">Turmas disponíveis em breve</h3>
        <v-chip-group column>
          <v-chip v-for="c in classes" :key="c.id">
            {{ c.schedule }}
          </v-chip>
        </v-chip-group>
        <h3 class="mt-4">Requisitos</h3>
        <ul>
          <li>Lógica de programação</li>
          <li>Entendimento de conceitos de orientaçõa a objetos</li>
        </ul>
        <h3 class="my-4">Conteúdos</h3>
        <v-expansion-panels popout>
          <v-expansion-panel v-for="step in courseSteps" :key="step.id">
            <v-expansion-panel-header> {{ step.name }} </v-expansion-panel-header>
            <v-expansion-panel-content>
              <p>
                {{ step.description }}
              </p>
            </v-expansion-panel-content>
          </v-expansion-panel>
        </v-expansion-panels>
        <h3 class="my-4">Tutor</h3>
        <v-card>
          <v-row justify="center" align="center">
            <v-col xl="3" lg="4" md="6" sm="12" xs="12">
              <v-avatar width="150" height="150">
                <img :src="ownerPicture" alt="Foto do criador do curso" />
              </v-avatar>
            </v-col>
            <v-col xl="9" lg="8" md="6" sm="12" xs="12">
              <h4 class="mb-4">{{ ownerName }}</h4>
              <ul>
                <li>Número de cursos na plataforma: {{ countUserCourses }}</li>
                <li>Média de avaliações: {{ avgRatingOwner }}</li>
                <li>Membro desde Maio/2021</li>
              </ul>
            </v-col>
          </v-row>
        </v-card>
        <h3 class="mt-8">Avaliações</h3>
        <v-row justify="center" align="center">
          <v-col xl="5" lg="8" md="6" sm="12" xs="12">
            <v-rating
              v-model="courseRatingFloat"
              background-color="indigo lighten-3"
              color="indigo"
              half-increments
              size="40"
            ></v-rating>
          </v-col>
          <v-col xl="1" lg="2" md="6" sm="12" xs="12">
            <span id="course-rating-average-subtitle" class="indigo--text">4.5</span>
          </v-col>
        </v-row>
        <v-row justify="center" align="center">
          <v-col cols="2">
            <v-rating
              value="5"
              background-color="indigo lighten-3"
              color="indigo"
              half-increments
              size="10"
            ></v-rating>
          </v-col>
          <v-col cols="10">
            <v-progress-linear value="70"></v-progress-linear>
          </v-col>
        </v-row>
        <v-row justify="center" align="center">
          <v-col cols="2">
            <v-rating
              value="4"
              background-color="indigo lighten-3"
              color="indigo"
              half-increments
              size="10"
            ></v-rating>
          </v-col>
          <v-col cols="10">
            <v-progress-linear value="20"></v-progress-linear>
          </v-col>
        </v-row>
        <v-row justify="center" align="center">
          <v-col cols="2">
            <v-rating
              value="3"
              background-color="indigo lighten-3"
              color="indigo"
              half-increments
              size="10"
            ></v-rating>
          </v-col>
          <v-col cols="10">
            <v-progress-linear value="6"></v-progress-linear>
          </v-col>
        </v-row>
        <v-row justify="center" align="center">
          <v-col cols="2">
            <v-rating
              value="2"
              background-color="indigo lighten-3"
              color="indigo"
              half-increments
              size="10"
            ></v-rating>
          </v-col>
          <v-col cols="10">
            <v-progress-linear value="3"></v-progress-linear>
          </v-col>
        </v-row>
        <v-row justify="center" align="center">
          <v-col cols="2">
            <v-rating
              value="1"
              background-color="indigo lighten-3"
              color="indigo"
              half-increments
              size="10"
            ></v-rating>
          </v-col>
          <v-col cols="10">
            <v-progress-linear value="1"></v-progress-linear>
          </v-col>
        </v-row>
        <h3 class="mt-8">Comentários</h3>
        <v-row justify="center" align="center" class="mt-1">
          <v-col xl="2" lg="3" md="6" sm="12" xs="12">
            <v-avatar width="75" height="75" class="ml-4" color="red">
              <span class="white--text headline">CJ</span>
            </v-avatar>
            <v-subheader class="mx-auto">Carlos Jonas</v-subheader>
          </v-col>
          <v-col xl="8" lg="9" md="6" sm="12" xs="12">
            <p class="headline">
              <v-rating
                value="4.5"
                color="yellow darken-3"
                background-color="grey darken-1"
                empty-icon="$ratingFull"
                half-increments
                readonly
                size="10"
              ></v-rating>
            </p>
            <p class="body-2">
              Lorem ipsum dolor sit amet consectetur adipisicing elit. Fuga enim animi quaerat iusto
              ad repudiandae iure in adipisci dignissimos cum facere suscipit velit, quis
              reprehenderit rem voluptas ipsam cumque ipsum.
            </p>
          </v-col>
        </v-row>
        <v-divider></v-divider>
        <v-row justify="center" align="center" class="mt-1">
          <v-col xl="2" lg="3" md="6" sm="12" xs="12">
            <v-avatar width="75" height="75" class="ml-4">
              <img src="https://cdn.vuetifyjs.com/images/john.jpg" alt="John" />
            </v-avatar>
            <v-subheader class="mx-auto">João Flores</v-subheader>
          </v-col>
          <v-col xl="8" lg="9" md="6" sm="12" xs="12">
            <p class="headline">
              <v-rating
                value="5"
                color="yellow darken-3"
                background-color="grey darken-1"
                empty-icon="$ratingFull"
                half-increments
                readonly
                size="10"
              ></v-rating>
            </p>
            <p class="body-2">
              Lorem ipsum dolor sit amet consectetur adipisicing elit. Fuga enim animi quaerat iusto
              ad repudiandae iure in adipisci dignissimos cum facere suscipit velit, quis
              reprehenderit rem voluptas ipsam cumque ipsum.
            </p>
          </v-col>
        </v-row>
        <div class="my-2">
          <v-btn large color="primary" outlined block> Ver mais comentários </v-btn>
        </div>
      </v-col>
      <v-col xl="3" lg="3" md="6" sm="12" xs="12">
        <v-card width="400">
          <v-img height="200px" :src="courseImage" />

          <v-card-text class="text--primary">
            <h1>R${{ courseCost }},00</h1>
            <div class="my-6">
              <v-btn x-large color="success" block to="/cart"> Adicionar ao Carrinho </v-btn>
            </div>
            <v-row align="center" class="mx-0 my-2">
              <v-rating
                :value="courseRatingFloat"
                color="amber"
                dense
                half-increments
                readonly
                size="14"
              ></v-rating>

              <div class="grey--text ml-2 mr-4">{{ courseRating }} ({{ courseReviews }})</div>
            </v-row>
            <div>
              {{ courseShortDescription }}
            </div>
            <v-avatar size="56" class="mt-10">
              <img alt="Foto do criador do curso" :src="ownerPicture" />
            </v-avatar>
            <p class="my-2">{{ ownerName }}</p>
          </v-card-text>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import { mapGetters } from 'vuex';
import { getCourse, getCourseSteps, getCourseClasses, getCourseReviews } from '@/graphql/queries';

export default {
  name: 'Course',
  title: 'Programação C# | Find a Tutor',
  data: () => ({
    classes: [],
    courseName: '',
    courseImage: '',
    courseRating: '',
    courseRating1: '',
    courseRating2: '',
    courseRating3: '',
    courseRating4: '',
    courseRating5: '',
    courseReviews: '',
    courseCategory: '',
    courseShortDescription: '',
    courseDescription: '',
    courseId: '1',
    courseLanguage: 'pt-br',
    courseCost: '',
    countUserCourses: '',
    ownerName: '',
    ownerPicture: '',
    avgRatingOwner: '',
    courseSteps: [],
    reviews: [],
  }),

  computed: {
    courseRatingFloat() {
      return parseFloat(this.courseRating);
    },
    compiledMarkdown() {
      return this.$marked(this.courseDescription, { sanitize: true });
    },
    ...mapGetters('auth', ['currentUser']),
  },

  methods: {
    getCourse() {
      this.$gqlClient
        .query({
          query: this.$gql(getCourse),
          variables: { id: this.$route.params.id },
        })
        .then((response) => {
          const result = JSON.parse(response.data.getCourse);
          this.courseName = result.name;
          this.courseImage = result.image;
          this.courseRating = result.avg_rating;
          this.courseRating1 = result.rating_1;
          this.courseRating2 = result.rating_2;
          this.courseRating3 = result.rating_3;
          this.courseRating4 = result.rating_4;
          this.courseRating5 = result.rating_5;
          this.courseReviews = result.reviews;
          this.courseCategory = result.category_name;
          this.courseShortDescription = result.short_description;
          this.courseDescription = result.description;
          this.courseId = result.id;
          this.courseCost = result.price;
          this.countUserCourses = result.count_user_courses;
          this.avgRatingOwner = result.avg_rating_owner;
          this.ownerName = result.owner_name;
          this.ownerPicture = result.owner_picture;
          this.classes = result.classes;
        });
    },
    getCourseSteps() {
      this.$gqlClient
        .query({
          query: this.$gql(getCourseSteps),
          variables: { course_id: this.$route.params.id },
        })
        .then((response) => {
          const result = JSON.parse(response.data.getCourseSteps);
          this.courseSteps = result;
        });
    },
    getCourseClasses() {
      this.$gqlClient
        .query({
          query: this.$gql(getCourseClasses),
          variables: {
            course_id: this.$route.params.id,
            user_id: this.currentUser.username,
          },
        })
        .then((response) => {
          const result = JSON.parse(response.data.getCourseClasses);
          this.classes = result;
        });
    },
    getCourseReviews() {
      this.$gqlClient
        .query({
          query: this.$gql(getCourseReviews),
          variables: { course_id: this.$route.params.id },
        })
        .then((response) => {
          const result = JSON.parse(response.data.getCourseReviews);
          this.reviews = result;
        });
    },
  },
  created() {
    this.getCourse();
    this.getCourseSteps();
    this.getCourseReviews();
  },
};
</script>

<style lang="scss" scoped>
#course-rating-average-subtitle {
  font-size: 3rem;
}
</style>
