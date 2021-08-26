<template>
  <v-container>
    <v-row>
      <v-col xl="3" lg="3" md="12" sm="12" xs="12">
        <v-sheet elevation="1" width="100%" class="mb-4">
          <v-subheader color="primary">Salvos</v-subheader>
          <v-skeleton-loader v-bind="attrs" type="card-heading" v-if="loading"></v-skeleton-loader>
          <v-list-item v-for="bookmark in savedPaths" :key="bookmark.id" v-else>
            <v-list-item-content>
              <v-list-item-title
                ><v-icon class="mr-2">fas fa-bookmark </v-icon
                ><v-btn :to="{ name: 'Path', params: { id: bookmark.id } }">
                  {{ bookmark.name }}</v-btn
                ></v-list-item-title
              >
            </v-list-item-content>
          </v-list-item>
        </v-sheet>
        <v-sheet elevation="1" width="100%">
          <v-container>
            <v-subheader color="primary">Palavras-chave</v-subheader>
            <v-combobox
              v-model="selectedKeywords"
              :items="keywords"
              :search-input.sync="search"
              v-on:change="filter(selectedKeywords, ratingsRange, orderBy)"
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
            <v-subheader color="primary">Ordenar por</v-subheader>
            <v-radio-group
              v-model="orderBy"
              v-on:change="filter(selectedKeywords, ratingsRange, orderBy)"
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
              v-on:change="filter(selectedKeywords, ratingsRange, orderBy)"
            ></v-range-slider>
          </v-container>
        </v-sheet>
      </v-col>
      <v-col xl="9" lg="9" md="12" sm="12" xs="12">
        <v-row justify="start">
          <v-col cols="12" xl="4" lg="4" md="6" v-if="loading">
            <v-skeleton-loader v-bind="attrs" type="card, article, actions"></v-skeleton-loader>
          </v-col>

          <v-col cols="12" xl="4" lg="4" md="6" v-for="path in filteredPaths" :key="path.id" v-else>
            <PathCard
              :pathName="path.name"
              :pathImage="path.image"
              :pathRating="path.avg_rating"
              :pathReviews="path.reviews"
              :pathDescription="path.description"
              :pathId="path.id"
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
import PathCard from '@/components/PathCard.vue';
import { mapGetters } from 'vuex';
import { getAllPaths, getMySavedPaths } from '@/graphql/queries';

export default {
  name: 'Paths',

  title: 'Trilhas | Find a Tutor',

  components: {
    PathCard,
  },

  data: () => ({
    loading: true,
    attrs: {
      class: 'mb-6',
      boilerplate: true,
      elevation: 2,
    },
    page: 1,
    pagesLength: 1,
    pages: [],
    keywords: ['Programação', 'Python', 'Jogos', 'Música'],
    selectedKeywords: [],
    search: null,
    ratings: ['1', '', '2', '', '3', '', '4', '', '5'],
    orderBy: ['ratings'],
    price: [],
    paths: [],
    savedPaths: [],
    filteredPaths: [],
    ratingsRange: [1, 5],
  }),

  methods: {
    getAllPaths() {
      this.$gqlClient
        .query({
          query: this.$gql(getAllPaths),
          fetchPolicy: 'network-only',
        })
        .then((response) => {
          const result = JSON.parse(response.data.getAllPaths);
          this.paths = result;
          this.filteredPaths = result;
          this.paginate();
          this.loading = false;
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
          this.savedPaths = result;
        });
    },
    filter(selectedKeywords, ratingsRange, orderBy) {
      let filteredPaths = this.paths.filter(
        (path) => path.avg_rating >= ratingsRange[0] && path.avg_rating <= ratingsRange[1]
      );
      if (selectedKeywords.length > 0) {
        filteredPaths = filteredPaths.filter(
          (path) =>
            selectedKeywords.every((keyword) => path.name.includes(keyword)) ||
            selectedKeywords.every((keyword) => path.description.includes(keyword))
        );
      }
      if (orderBy !== '') {
        filteredPaths.sort((a, b) => a[orderBy] - b[orderBy]);
      }
      this.filteredPaths = filteredPaths;
    },
    paginate() {
      const numPages = Math.ceil(this.filteredPaths.length / 12);
      const paginated = this.$chunkify(this.filteredPaths, numPages, false);
      this.pagesLength = paginated.length;
      this.pages = paginated;
      // eslint-disable-next-line prefer-destructuring
      this.filteredPaths = paginated[0];
    },
    changePage() {
      this.filteredPaths = this.pages[this.page - 1];
    },
    removeBookmark(event, item) {
      const index = this.bookmarks.indexOf(item);
      if (index > -1) {
        this.bookmarks.splice(index, 1);
      }
    },
  },
  computed: {
    ...mapGetters('auth', ['currentUser']),
  },
  created() {
    this.getAllPaths();
    this.getMySavedPaths();
  },
};
</script>
