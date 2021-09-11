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
      <template v-slot:item.price="{ item }">
        {{ parseFloat(item.price).toFixed(2) }}
      </template>
      <template v-slot:item.status="{ item }">
        <v-tooltip bottom v-if="item.status === 'NEGADO'">
          <template v-slot:activator="{ on, attrs }">
            <span v-bind="attrs" v-on="on">{{ item.status }}</span>
          </template>
          <span
            >Este Curso infringiu algum de nossos termos, por favor entre em contato com o
            suporte!</span
          >
        </v-tooltip>
        <span v-else>{{ item.status }}</span>
      </template>
      <template v-slot:item.edit="{ item }">
        <v-btn color="primary" text :to="{ name: 'DashboardEditCourse', params: { course: item } }"
          >Editar</v-btn
        >
      </template>
      <template v-slot:item.remove="{ item }">
        <v-btn color="error" text @click="confirmRemove($event, item)">Remover</v-btn>
      </template>
    </v-data-table>
    <v-overlay :value="loading">
      <v-progress-circular indeterminate size="64"></v-progress-circular>
    </v-overlay>
    <v-bottom-sheet v-model="sheet">
      <v-sheet class="text-center" height="200px">
        <v-btn class="mt-6" text color="red" @click="remove"> Remover </v-btn>
        <v-btn class="mt-6" color="primary" @click="sheet = !sheet"> Fechar </v-btn>
        <div class="py-3">
          Tem certeza que deseja remover o curso <b>{{ removingCourse.name }}</b>
        </div>
      </v-sheet>
    </v-bottom-sheet>
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
  name: 'DashboardCourses',
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
      removingCourse: {},
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
    remove() {
      this.deleteCourse(this.removingCourse.id);
      this.sheet = false;
    },
    confirmRemove(event, item) {
      this.sheet = true;
      this.removingCourse = item;
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
