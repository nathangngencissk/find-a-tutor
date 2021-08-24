<template>
  <v-container>
    <v-row>
      <v-col xl="3" lg="3" md="12" sm="12" xs="12">
        <v-sheet elevation="1" width="100%">
          <v-container>
            <v-subheader color="primary">Palavras-chave</v-subheader>
            <v-combobox
              v-model="selectedKeywords"
              :items="keywords"
              :search-input.sync="search"
              v-on:change="filter(selectedKeywords, activeCategory, ratingsRange, orderBy)"
              hide-selected
              multiple
              small-chips
            >
              <template v-slot:no-data>
                <v-list-item>
                  <v-list-item-content>
                    <v-list-item-title>
                      Nenhum resultado para "<strong>{{ search }}</strong
                      >". Aperte <kbd>enter</kbd> para adicionar de qualquer maneira.
                    </v-list-item-title>
                  </v-list-item-content>
                </v-list-item>
              </template>
            </v-combobox>
            <v-subheader color="primary">Categorias</v-subheader>
            <v-list>
              <v-list-group
                v-for="category in categories"
                :key="category.id"
                @click="activeCategory = category.name"
                v-on:change="filter(selectedKeywords, activeCategory, ratingsRange, orderBy)"
                :prepend-icon="category.icon"
                no-action
              >
                <template v-slot:activator>
                  <v-list-item-content>
                    <v-list-item-title v-text="category.name"></v-list-item-title>
                  </v-list-item-content>
                </template>
              </v-list-group>
            </v-list>
            <v-divider></v-divider>
            <v-subheader color="primary">Ordenar por</v-subheader>
            <v-radio-group
              v-model="orderBy"
              v-on:change="filter(selectedKeywords, activeCategory, ratingsRange, orderBy)"
            >
              <v-radio label="Avaliação" value="ratings"></v-radio>
              <v-radio label="Quantidade de avaliações" value="reviews"></v-radio>
            </v-radio-group>
            <v-divider></v-divider>
            <v-subheader color="primary">Avaliação</v-subheader>
            <v-range-slider
              class="mx-5 my-5"
              step="0.5"
              max="5"
              min="1"
              :tick-labels="ratings"
              v-model="ratingsRange"
              v-on:change="filter(selectedKeywords, activeCategory, ratingsRange, orderBy)"
            ></v-range-slider>
          </v-container>
        </v-sheet>
      </v-col>
      <v-col xl="9" lg="9" md="12" sm="12" xs="12">
        <v-row justify="start">
          <v-col cols="12" lg="4" md="6" v-for="course in filteredCourses" :key="course.id">
            <CourseCardFull
              :courseName="course.name"
              :courseImage="course.image"
              :courseRating="course.avg_rating"
              :courseReviews="course.reviews"
              :courseCategory="course.category_name"
              :courseDescription="course.short_description"
              :courseId="course.id"
              courseLanguage="pt-br"
            />
          </v-col>
        </v-row>
      </v-col>
    </v-row>
    <div class="text-center my-10">
      <v-pagination
        v-model="page"
        :length="pagesLength"
        circle
        v-on:change="changePage"
      ></v-pagination>
    </div>
  </v-container>
</template>

<script>
import { mapGetters } from 'vuex';
import CourseCardFull from '@/components/CourseCardFull.vue';
import { myCourses, getAllCourseCategories } from '@/graphql/queries';

export default {
  name: 'MyCourses',

  title: 'Meus Cursos | Find a Tutor',

  components: {
    CourseCardFull,
  },

  data: () => ({
    page: 1,
    pagesLength: 1,
    pages: [],
    keywords: ['Programação', 'Python', 'Jogos', 'Música'],
    selectedKeywords: [],
    search: null,
    ratings: ['1', '', '2', '', '3', '', '4', '', '5'],
    orderBy: '',
    price: [],
    language: [],
    categories: [],
    activeCategory: '',
    courses: [],
    filteredCourses: [],
    ratingsRange: [1, 5],
  }),
  computed: {
    ...mapGetters('auth', ['currentUser']),
  },
  methods: {
    myCourses() {
      this.$gqlClient
        .query({
          query: this.$gql(myCourses),
          variables: { id: this.currentUser.username },
        })
        .then((response) => {
          const courses = JSON.parse(response.data.myCourses);
          this.courses = courses;
          this.filteredCourses = courses;
          this.paginate();
        });
    },
    getCategories() {
      this.$gqlClient
        .query({
          query: this.$gql(getAllCourseCategories),
        })
        .then((response) => {
          const categories = JSON.parse(response.data.getAllCourseCategories);
          this.categories = categories;
        });
    },
    filter(selectedKeywords, activeCategory, ratingsRange, orderBy) {
      let filteredCourses = this.courses.filter(
        (course) => course.avg_rating >= ratingsRange[0] && course.avg_rating <= ratingsRange[1]
      );
      if (activeCategory !== '') {
        filteredCourses = filteredCourses.filter(
          (course) => course.category_name === activeCategory
        );
      }
      if (selectedKeywords.length > 0) {
        filteredCourses = filteredCourses.filter(
          (course) =>
            selectedKeywords.every((keyword) => course.name.includes(keyword)) ||
            selectedKeywords.every((keyword) => course.short_description.includes(keyword)) ||
            selectedKeywords.every((keyword) => course.category_name.includes(keyword))
        );
      }
      if (orderBy !== '') {
        filteredCourses.sort((a, b) => a[orderBy] - b[orderBy]);
      }
      this.filteredCourses = filteredCourses;
    },
    paginate() {
      const numPages = Math.ceil(this.filteredCourses.length / 12);
      const paginated = this.$chunkify(this.filteredCourses, numPages, false);
      this.pagesLength = paginated.length;
      this.pages = paginated;
      // eslint-disable-next-line prefer-destructuring
      this.filteredCourses = paginated[0];
    },
    changePage() {
      this.filteredCourses = this.pages[this.page - 1];
    },
  },
  created() {
    this.myCourses();
    this.getCategories();
  },
};
</script>
