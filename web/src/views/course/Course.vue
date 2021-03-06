<template>
  <v-container>
    <v-row justify="center">
      <v-col xs="12" xl="6" lg="12" md="12" sm="12" class="mt-4">
        <h2 class="mb-6">{{ courseName }}</h2>
        <h3 class="mb-2">Descrição</h3>
        <v-sheet elevation="1" class="pa-6">
          <div v-html="compiledMarkdown"></div>
        </v-sheet>
        <h3 class="mt-4" v-if="classes.length > 0">Turmas disponíveis em breve</h3>
        <v-chip-group column v-if="classes.length > 0">
          <v-chip v-for="c in classes" :key="c.id">
            {{ cronToDatetime(c.start_date, c.schedule) }}
          </v-chip>
        </v-chip-group>
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
            <v-col justify="center" align="center" xl="4" lg="4" md="6" sm="12" xs="12">
              <v-avatar width="150" height="150">
                <img :src="ownerPicture" alt="Foto do criador do curso" />
              </v-avatar>
            </v-col>
            <v-col xl="8" lg="8" md="6" sm="12" xs="12">
              <h4 class="mb-4">{{ ownerName }}</h4>
              <ul>
                <li>Número de cursos na plataforma: {{ countUserCourses }}</li>
                <li>Média de avaliações: {{ avgRatingOwner }}</li>
                <li>Membro desde {{ ownerCreatedAt }}</li>
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
              readonly
              empty-icon="$ratingFull"
              size="40"
            ></v-rating>
          </v-col>
          <v-col xl="1" lg="2" md="6" sm="12" xs="12">
            <span id="course-rating-average-subtitle" class="indigo--text">{{ courseRating }}</span>
          </v-col>
        </v-row>
        <v-row justify="center" align="center">
          <v-col cols="2">
            <v-rating
              :value="parseInt('5')"
              background-color="indigo lighten-3"
              empty-icon="$ratingFull"
              color="indigo"
              half-increments
              readonly
              size="10"
            ></v-rating>
          </v-col>
          <v-col cols="10">
            <v-progress-linear
              :value="(courseRating5 / courseRatingCount) * 100"
            ></v-progress-linear>
          </v-col>
        </v-row>
        <v-row justify="center" align="center">
          <v-col cols="2">
            <v-rating
              :value="parseInt('4')"
              background-color="indigo lighten-3"
              empty-icon="$ratingFull"
              color="indigo"
              half-increments
              readonly
              size="10"
            ></v-rating>
          </v-col>
          <v-col cols="10">
            <v-progress-linear
              :value="(courseRating4 / courseRatingCount) * 100"
            ></v-progress-linear>
          </v-col>
        </v-row>
        <v-row justify="center" align="center">
          <v-col cols="2">
            <v-rating
              :value="parseInt('3')"
              background-color="indigo lighten-3"
              empty-icon="$ratingFull"
              color="indigo"
              half-increments
              readonly
              size="10"
            ></v-rating>
          </v-col>
          <v-col cols="10">
            <v-progress-linear
              :value="(courseRating3 / courseRatingCount) * 100"
            ></v-progress-linear>
          </v-col>
        </v-row>
        <v-row justify="center" align="center">
          <v-col cols="2">
            <v-rating
              :value="parseInt('2')"
              background-color="indigo lighten-3"
              empty-icon="$ratingFull"
              color="indigo"
              half-increments
              readonly
              size="10"
            ></v-rating>
          </v-col>
          <v-col cols="10">
            <v-progress-linear
              :value="(courseRating2 / courseRatingCount) * 100"
            ></v-progress-linear>
          </v-col>
        </v-row>
        <v-row justify="center" align="center">
          <v-col cols="2">
            <v-rating
              :value="parseInt('1')"
              background-color="indigo lighten-3"
              empty-icon="$ratingFull"
              color="indigo"
              half-increments
              readonly
              size="10"
            ></v-rating>
          </v-col>
          <v-col cols="10">
            <v-progress-linear
              :value="(courseRating1 / courseRatingCount) * 100"
            ></v-progress-linear>
          </v-col>
        </v-row>
        <h3 class="mt-8">Comentários</h3>
        <div v-for="review in reviews" :key="review.user_id">
          <v-row justify="center" align="center" class="mt-1">
            <v-col xl="3" lg="3" md="6" sm="12" xs="12" align="center" justify="center">
              <v-avatar width="75" height="75">
                <img :src="review.reviewer_picture" alt="Foto do avaliador" />
              </v-avatar>
              <v-subheader class="ml-4">{{ review.reviewer_name }}</v-subheader>
            </v-col>
            <v-col xl="8" lg="9" md="6" sm="12" xs="12">
              <p class="headline">
                <v-rating
                  :value="review.rating"
                  color="yellow darken-3"
                  background-color="grey darken-1"
                  empty-icon="$ratingFull"
                  half-increments
                  readonly
                  size="10"
                ></v-rating>
              </p>
              <p class="body-2">
                {{ review.content }}
              </p>
            </v-col>
          </v-row>
          <v-divider></v-divider>
        </div>
      </v-col>
      <v-col xl="3" lg="3" md="6" sm="12" xs="12">
        <v-card width="400">
          <v-img height="200px" :src="courseImage" />

          <v-card-text class="text--primary">
            <h1>R${{ parseFloat(courseCost).toFixed(2) }}</h1>
            <div class="my-6">
              <v-btn x-large color="success" block @click="addToCart">
                Adicionar ao Carrinho
              </v-btn>
            </div>
            <v-row align="center" class="mx-0 my-2">
              <v-rating
                :value="courseRatingFloat"
                color="amber"
                empty-icon="$ratingFull"
                background-color="grey darken-1"
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
      <v-overlay :value="loading">
        <v-progress-circular indeterminate size="64"></v-progress-circular>
      </v-overlay>
    </v-row>
  </v-container>
</template>

<script>
import { mapGetters } from 'vuex';
import { getCourse, getCourseSteps, getCourseClasses, getCourseReviews } from '@/graphql/queries';
import DOMPurify from 'dompurify';

export default {
  name: 'Course',
  title: 'Programação C# | Find a Tutor',
  data: () => ({
    classes: [],
    course: {},
    courseName: '',
    courseImage: '',
    courseRating: '',
    courseRating1: '',
    courseRating2: '',
    courseRating3: '',
    courseRating4: '',
    courseRating5: '',
    courseRatingCount: 1,
    courseReviews: '',
    courseCategory: '',
    courseShortDescription: '',
    courseDescription: '',
    courseId: '1',
    courseLanguage: 'pt-br',
    courseCost: 0.0,
    countUserCourses: '',
    ownerName: '',
    ownerPicture: '',
    ownerCreatedAt: '',
    avgRatingOwner: '',
    courseSteps: [],
    reviews: [],
    loading: true,
  }),

  computed: {
    courseRatingFloat() {
      return parseFloat(this.courseRating);
    },
    compiledMarkdown() {
      return this.$marked(DOMPurify.sanitize(this.courseDescription));
    },
    ...mapGetters('auth', ['currentUser']),
  },

  methods: {
    // eslint-disable-next-line camelcase
    cronToDatetime(start_date, schedule) {
      const startDate = new Date(Date.parse(start_date));
      const options = {
        currentDate: startDate,
        endDate: this.addDays(startDate, 7),
        iterator: true,
      };
      const optionsFormatDate = { weekday: 'long', hour: '2-digit', minute: '2-digit' };
      const interval = this.$parser.parseExpression(schedule, options);
      const frequency = [];
      // eslint-disable-next-line no-constant-condition
      while (true) {
        try {
          const obj = interval.next();
          const d = new Date(obj.value);
          const formattedDate = d.toLocaleDateString('pt-br', optionsFormatDate);
          frequency.push(formattedDate);
        } catch (e) {
          break;
        }
      }
      const uniqueFrequency = [...new Set(frequency)];
      return uniqueFrequency.join('; ');
    },
    addDays(date, days) {
      const result = new Date(date);
      result.setDate(result.getDate() + days);
      return result;
    },
    getCourse() {
      this.$gqlClient
        .query({
          query: this.$gql(getCourse),
          fetchPolicy: 'network-only',
          variables: { id: this.$route.params.id },
        })
        .then(async (response) => {
          const result = JSON.parse(response.data.getCourse);
          this.course = result;
          this.courseName = result.name;
          this.courseImage = await this.$getKeyUrl(result.image);
          this.courseRating = result.avg_rating;
          this.courseRating1 = result.rating_1;
          this.courseRating2 = result.rating_2;
          this.courseRating3 = result.rating_3;
          this.courseRating4 = result.rating_4;
          this.courseRating5 = result.rating_5;
          this.courseRatingCount =
            result.rating_1 + result.rating_2 + result.rating_3 + result.rating_4 + result.rating_5;
          this.courseReviews = result.reviews;
          this.courseCategory = result.category_name;
          this.courseShortDescription = result.short_description;
          this.courseDescription = result.description;
          this.courseId = result.id;
          this.courseCost = result.price;
          this.countUserCourses = result.count_user_courses;
          this.avgRatingOwner = result.avg_rating_owner;
          this.ownerName = result.owner_name;
          this.ownerCreatedAt = result.owner_created_at;
          this.$getProfilePicture(result.owner_username, result.owner_picture).then(
            (responsePicture) => {
              this.ownerPicture = responsePicture;
            }
          );
          this.loading = false;
        });
    },
    getCourseSteps() {
      this.$gqlClient
        .query({
          query: this.$gql(getCourseSteps),
          fetchPolicy: 'network-only',
          variables: { id: this.$route.params.id },
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
          fetchPolicy: 'network-only',
          variables: { id: this.$route.params.id },
        })
        .then((response) => {
          const result = JSON.parse(response.data.getCourseReviews);
          const reviews = [];
          result.forEach((review) => {
            this.$getProfilePicture(review.reviewer_username, review.reviewer_picture).then(
              (resultPicture) => {
                reviews.push({
                  user_id: review.user_id,
                  content: review.content,
                  rating: review.rating,
                  reviewer_name: review.reviewer_name,
                  reviewer_picture: resultPicture,
                });
              }
            );
          });
          this.reviews = reviews;
        });
    },
    async addToCart() {
      await this.$store.dispatch('shopping/addToCart', {
        course: this.course,
      });
    },
  },
  created() {
    this.getCourse();
    this.getCourseSteps();
    this.getCourseReviews();
    this.getCourseClasses();
  },
};
</script>

<style lang="scss" scoped>
#course-rating-average-subtitle {
  font-size: 3rem;
}
</style>
