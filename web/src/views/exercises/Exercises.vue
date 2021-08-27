<template>
  <v-container>
    <v-row justify="center">
      <v-col xl="6" cols="12">
        <v-subheader color="primary">Palavras-chave</v-subheader>
        <v-combobox
          v-model="selectedKeywords"
          :items="keywords"
          :search-input.sync="search"
          v-on:change="filter(selectedKeywords)"
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
        <v-skeleton-loader
          v-bind="attrs"
          type="article, actions"
          v-if="loading"
        ></v-skeleton-loader>
        <v-expansion-panels popout v-else>
          <v-expansion-panel v-for="exercise in filteredExercises" :key="exercise.i">
            <v-expansion-panel-header
              >{{ exercise.title }}
              <div class="text-center" v-if="exercise.status !== null">
                <v-chip
                  :color="exercise.status === 'Em Andamento' ? 'secondary' : 'success'"
                  class="mr-2"
                  label
                  ><v-icon left>
                    {{
                      exercise.status === 'Em Andamento'
                        ? 'fas fa-clipboard'
                        : 'fas fa-clipboard-check'
                    }}
                  </v-icon>
                  {{ exercise.status }}
                </v-chip>
                <v-chip :color="exercise.status === 'Em Andamento' ? 'secondary' : 'success'" label>
                  {{ exercise.total_user }}/ {{ exercise.total }}
                </v-chip>
              </div>
            </v-expansion-panel-header>
            <v-expansion-panel-content>
              <p>
                {{ exercise.description }}
              </p>
              <v-row>
                <v-subheader> Tags </v-subheader>
                <v-chip-group>
                  <v-chip v-for="tag in exercise.tags.split(', ')" :key="tag">
                    {{ tag }}
                  </v-chip>
                </v-chip-group>
              </v-row>
              <v-row>
                <v-btn
                  color="primary"
                  depressed
                  text
                  :to="{ name: 'Exercise', params: { id: exercise.id } }"
                  >Ver Lista</v-btn
                >
              </v-row>
            </v-expansion-panel-content>
          </v-expansion-panel>
        </v-expansion-panels>
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
import { getExerciseLists } from '@/graphql/queries';

export default {
  name: 'Exercises',

  title: 'Exercícios | Find a Tutor',

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
    tags: ['Programação', 'Jogos'],
    selectedKeywords: [],
    search: null,
    exercises: [],
    filteredExercises: [],
  }),
  methods: {
    getExerciseLists() {
      this.$gqlClient
        .query({
          query: this.$gql(getExerciseLists),
          fetchPolicy: 'network-only',
          variables: { user_id: this.currentUser.username },
        })
        .then((response) => {
          const result = JSON.parse(response.data.getExerciseLists);
          this.exercises = result;
          this.filteredExercises = result;
          this.paginate();
          this.loading = false;
        });
    },
    filter(selectedKeywords) {
      if (selectedKeywords.length > 0) {
        this.filteredExercises = this.exercises.filter(
          (exercise) =>
            selectedKeywords.every((keyword) => exercise.title.includes(keyword)) ||
            selectedKeywords.every((keyword) => exercise.description.includes(keyword)) ||
            selectedKeywords.every((keyword) => exercise.tags.includes(keyword))
        );
      } else {
        this.filteredExercises = this.exercises;
      }
    },
    paginate() {
      const numPages = Math.ceil(this.filteredExercises.length / 12);
      const paginated = this.$chunkify(this.filteredExercises, numPages, false);
      this.pagesLength = paginated.length;
      this.pages = paginated;
      // eslint-disable-next-line prefer-destructuring
      this.filteredExercises = paginated[0];
    },
    changePage() {
      this.filteredExercises = this.pages[this.page - 1];
    },
  },
  computed: {
    ...mapGetters('auth', ['currentUser']),
  },
  created() {
    this.getExerciseLists();
  },
};
</script>
