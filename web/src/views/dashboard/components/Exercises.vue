<template>
  <v-container>
    <v-row justify="center">
      <v-col cols="10">
        <v-data-table
          :headers="headers"
          :items="filteredExercisesLists"
          :page.sync="page"
          :items-per-page="itemsPerPage"
          @page-count="pageCount = $event"
          hide-default-footer
          item-key="name"
          class="elevation-1"
          :search="search"
        >
          <template v-slot:top>
            <v-toolbar flat>
              <v-toolbar-title>Listas de exercícios</v-toolbar-title>
              <v-divider class="mx-4" inset vertical></v-divider>
              <v-text-field v-model="search" label="Filtrar" class="mx-4"></v-text-field>
              <v-btn
                color="success"
                dark
                class="mb-2"
                :to="{ name: 'DashboardEditExercise', params: { exerciseList: newExerciseList } }"
              >
                Adicionar
              </v-btn>
            </v-toolbar>
          </template>
          <template v-slot:item.status="{ item }">
            <v-tooltip bottom v-if="item.status === 'NEGADO'">
              <template v-slot:activator="{ on, attrs }">
                <span v-bind="attrs" v-on="on">{{ item.status }}</span>
              </template>
              <span
                >Este Exercício infringiu algum de nossos termos, por favor entre em contato com o
                suporte!</span
              >
            </v-tooltip>
            <span v-else>{{ item.status }}</span>
          </template>
          <template v-slot:item.edit="{ item }">
            <v-btn
              color="primary"
              text
              :to="{ name: 'DashboardEditExercise', params: { exerciseList: item } }"
              >Editar</v-btn
            >
          </template>
          <template v-slot:item.remove="{ item }">
            <v-btn color="error" text @click="confirmRemove($event, item)">Remover</v-btn>
          </template>
        </v-data-table>
        <div class="text-center pt-2">
          <v-pagination
            v-model="page"
            :length="pagesLength"
            circle
            v-on:change="changePage"
          ></v-pagination>
        </div>
      </v-col>
      <v-overlay :value="loading">
        <v-progress-circular indeterminate size="64"></v-progress-circular>
      </v-overlay>
      <v-bottom-sheet v-model="sheet">
        <v-sheet class="text-center" height="200px">
          <v-btn class="mt-6" text color="red" @click="remove"> Remover </v-btn>
          <v-btn class="mt-6" color="primary" @click="sheet = !sheet"> Fechar </v-btn>
          <div class="py-3">
            Tem certeza que deseja remover o exercício <b>{{ removingExercise.title }}</b>
          </div>
        </v-sheet>
      </v-bottom-sheet>
    </v-row>
  </v-container>
</template>

<script>
import { mapGetters } from 'vuex';
import { getTutorExerciseLists, deleteExerciseList } from '@/graphql/queries';

export default {
  data() {
    return {
      loading: true,
      page: 1,
      pagesLength: 1,
      pages: [],
      itemsPerPage: 10,
      search: '',
      newExerciseList: {
        id: null,
        creator_id: null,
        title: '',
        status: 'EM AVALIAÇÃO',
        description: '',
        tags: [],
        exercises: [],
      },
      exercisesLists: [],
      filteredExercisesLists: [],
      removingExercise: {},
      sheet: false,
    };
  },
  computed: {
    ...mapGetters('auth', ['currentUser']),
    headers() {
      return [
        {
          text: 'Nome',
          align: 'start',
          value: 'title',
        },
        { text: 'Tags', value: 'tags', align: 'center' },
        { text: 'Status', value: 'status', align: 'center' },
        { text: 'Editar', value: 'edit', sortable: false, align: 'center' },
        { text: 'Remover', value: 'remove', sortable: false, align: 'center' },
      ];
    },
  },
  methods: {
    edit(event, item) {
      console.log(event, item);
    },
    confirmRemove(event, item) {
      this.sheet = true;
      this.removingExercise = item;
    },
    remove(event, item) {
      this.deleteExerciseList(item.id);
      this.sheet = false;
    },
    paginate() {
      const numPages = Math.ceil(this.filteredExercisesLists.length / 12);
      const paginated = this.$chunkify(this.filteredExercisesLists, numPages, false);
      this.pagesLength = paginated.length;
      this.pages = paginated;
      // eslint-disable-next-line prefer-destructuring
      this.filteredExercisesLists = paginated[0];
    },
    changePage() {
      this.filteredExercisesLists = this.pages[this.page - 1];
    },
    getTutorExerciseLists() {
      this.$gqlClient
        .query({
          query: this.$gql(getTutorExerciseLists),
          fetchPolicy: 'network-only',
          variables: { user_id: this.currentUser.username },
        })
        .then((response) => {
          const result = JSON.parse(response.data.getTutorExerciseLists);
          this.exercisesLists = result;
          this.filteredExercisesLists = result;
          this.paginate();
          this.loading = false;
        });
    },
    deleteExerciseList(courseId) {
      this.loading = true;
      this.$gqlClient
        .query({
          query: this.$gql(deleteExerciseList),
          fetchPolicy: 'network-only',
          variables: { id: courseId },
        })
        // eslint-disable-next-line no-unused-vars
        .then((response) => {
          this.exercisesLists.forEach((course) => {
            if (course.id === courseId) {
              const index = this.exercisesLists.indexOf(course);
              if (index > -1) {
                this.exercisesLists.splice(index, 1);
              }
            }
          });
          this.loading = false;
        });
    },
  },
  created() {
    this.getTutorExerciseLists();
  },
};
</script>
