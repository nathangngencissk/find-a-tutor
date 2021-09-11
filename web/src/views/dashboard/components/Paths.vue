<template>
  <v-container>
    <v-row justify="center">
      <v-col cols="10">
        <v-data-table
          :headers="headers"
          :items="filteredPaths"
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
              <v-toolbar-title>Trilhas de aprendizagem</v-toolbar-title>
              <v-divider class="mx-4" inset vertical></v-divider>
              <v-text-field v-model="search" label="Filtrar" class="mx-4"></v-text-field>
              <v-btn
                color="success"
                dark
                class="mb-2"
                :to="{ name: 'DashboardEditPath', params: { path: newPath } }"
              >
                Adicionar
              </v-btn>
            </v-toolbar>
          </template>
          <template v-slot:item.edit="{ item }">
            <v-btn color="primary" text :to="{ name: 'DashboardEditPath', params: { path: item } }"
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
            Tem certeza que deseja remover a trilha <b>{{ removingPath.name }}</b>
          </div>
        </v-sheet>
      </v-bottom-sheet>
    </v-row>
  </v-container>
</template>

<script>
import { mapGetters } from 'vuex';
import { getTutorPaths, deletePath } from '@/graphql/queries';

export default {
  data() {
    return {
      loading: true,
      page: 1,
      pagesLength: 1,
      pages: [],
      itemsPerPage: 10,
      search: '',
      newPath: {
        id: null,
        name: '',
        description: '',
        image: '',
        creator_id: '',
        created_at: this.$getFormattedDate(),
        updated_at: this.$getFormattedDate(),
        courses: [],
      },
      paths: [],
      filteredPaths: [],
      removingPath: {},
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
          value: 'name',
        },
        { text: 'Descrição', value: 'description', align: 'center' },
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
      this.removingPath = item;
    },
    remove(event, item) {
      this.deletePath(item.id);
      this.sheet = false;
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
    getTutorPaths() {
      this.$gqlClient
        .query({
          query: this.$gql(getTutorPaths),
          fetchPolicy: 'network-only',
          variables: { user_id: this.currentUser.username },
        })
        .then((response) => {
          const result = JSON.parse(response.data.getTutorPaths);
          this.paths = result;
          this.filteredPaths = result;
          this.paginate();
          this.loading = false;
        });
    },
    deletePath(courseId) {
      this.loading = true;
      this.$gqlClient
        .query({
          query: this.$gql(deletePath),
          fetchPolicy: 'network-only',
          variables: { id: courseId },
        })
        // eslint-disable-next-line no-unused-vars
        .then((response) => {
          this.paths.forEach((course) => {
            if (course.id === courseId) {
              const index = this.paths.indexOf(course);
              if (index > -1) {
                this.paths.splice(index, 1);
              }
            }
          });
          this.loading = false;
        });
    },
  },
  created() {
    this.getTutorPaths();
  },
};
</script>
