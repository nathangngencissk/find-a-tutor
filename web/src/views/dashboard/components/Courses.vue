<template>
  <v-container>
    <v-data-table
      :headers="headers"
      :items="courses"
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
          <v-toolbar-title>Cursos</v-toolbar-title>
          <v-divider class="mx-4" inset vertical></v-divider>
          <v-text-field v-model="search" label="Filtrar" class="mx-4"></v-text-field>
          <v-btn
            color="success"
            dark
            class="mb-2"
            :to="{ name: 'DashboardEditCourse', params: { course: newCourse } }"
          >
            Adicionar
          </v-btn>
        </v-toolbar>
      </template>
      <template v-slot:item.edit="{ item }">
        <v-btn color="primary" text :to="{ name: 'DashboardEditCourse', params: { course: item } }"
          >Editar</v-btn
        >
      </template>
      <template v-slot:item.remove="{ item }">
        <v-btn color="error" text @click="remove($event, item)">Remover</v-btn>
      </template>
    </v-data-table>
    <v-overlay :value="loading">
      <v-progress-circular indeterminate size="64"></v-progress-circular>
    </v-overlay>
    <div class="text-center pt-2">
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
import { getCourses, deleteCourse } from '@/graphql/queries';

export default {
  title: 'Cursos | Find a Tutor',
  data() {
    return {
      loading: true,
      page: 1,
      pagesLength: 1,
      pages: [],
      itemsPerPage: 10,
      search: '',
      newCourse: {
        id: null,
        name: '',
        category_id: null,
        price: 0.0,
        description: '',
        short_description: '',
        image: '',
        status: 'EM AVALIAÇÃO',
        owner_id: '',
        created_at: '',
        updated_at: '',
        steps: [],
      },
      courses: [],
      filteredCourses: [],
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
        { text: 'Valor (R$)', value: 'price', align: 'center' },
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
    remove(event, item) {
      this.deleteCourse(item.id);
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
    getCourses() {
      this.$gqlClient
        .query({
          query: this.$gql(getCourses),
          fetchPolicy: 'network-only',
          variables: { user_id: this.currentUser.username },
        })
        .then((response) => {
          const result = JSON.parse(response.data.getCourses);
          this.courses = result;
          this.filteredCourses = result;
          this.paginate();
          this.loading = false;
        });
    },
    deleteCourse(courseId) {
      this.loading = true;
      this.$gqlClient
        .query({
          query: this.$gql(deleteCourse),
          fetchPolicy: 'network-only',
          variables: { course_id: courseId },
        })
        // eslint-disable-next-line no-unused-vars
        .then((response) => {
          this.courses.forEach((course) => {
            if (course.id === courseId) {
              const index = this.courses.indexOf(course);
              if (index > -1) {
                this.courses.splice(index, 1);
              }
            }
          });
          this.loading = false;
        });
    },
  },
  created() {
    this.getCourses();
  },
};
</script>
