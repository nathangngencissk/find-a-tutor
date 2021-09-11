<template>
  <v-container>
    <v-data-table
      :headers="headers"
      :items="classes"
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
          <v-toolbar-title>Turmas</v-toolbar-title>
          <v-divider class="mx-4" inset vertical></v-divider>
          <v-text-field v-model="search" label="Filtrar" class="mx-4"></v-text-field>
          <v-btn
            color="success"
            dark
            class="mb-2"
            :to="{ name: 'DashboardEditClass', params: { class: newClass } }"
          >
            Adicionar
          </v-btn>
        </v-toolbar>
      </template>
      <template v-slot:item.edit="{ item }">
        <v-btn color="primary" text :to="{ name: 'DashboardEditClass', params: { class: item } }"
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
    <v-overlay :value="loading">
      <v-progress-circular indeterminate size="64"></v-progress-circular>
    </v-overlay>
    <v-bottom-sheet v-model="sheet">
      <v-sheet class="text-center" height="200px">
        <v-btn class="mt-6" text color="red" @click="remove"> Remover </v-btn>
        <v-btn class="mt-6" color="primary" @click="sheet = !sheet"> Fechar </v-btn>
        <div class="py-3">
          Tem certeza que deseja remover o curso <b>{{ removingClass.name }}</b>
        </div>
      </v-sheet>
    </v-bottom-sheet>
  </v-container>
</template>

<script>
import { mapGetters } from 'vuex';
import { getTutorCourseClasses, deleteCourseClass } from '@/graphql/queries';

export default {
  data() {
    return {
      loading: true,
      page: 1,
      pagesLength: 1,
      pages: [],
      itemsPerPage: 10,
      search: '',
      newClass: {
        id: null,
        name: '',
        course_id: '',
        description: '',
        image: '',
        start_date: '',
        end_date: '',
        how_to_access: '',
        created_at: '',
        updated_at: '',
        duration: '',
        schedule: '',
        posts: [],
      },
      classes: [],
      removingClass: {},
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
        { text: 'Começa em', value: 'start_date', align: 'center' },
        { text: 'Termina em', value: 'end_date', align: 'center' },
        { text: 'Editar', value: 'edit', sortable: false, align: 'center' },
        { text: 'Remover', value: 'remove', sortable: false, align: 'center' },
      ];
    },
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
    edit(event, item) {
      console.log(event, item);
    },
    remove(event, item) {
      this.deleteCourseClass(item.id);
      this.sheet = false;
    },
    confirmRemove(event, item) {
      this.sheet = true;
      this.removingClass = item;
    },
    paginate() {
      const numPages = Math.ceil(this.filteredClasses.length / 12);
      const paginated = this.$chunkify(this.filteredClasses, numPages, false);
      this.pagesLength = paginated.length;
      this.pages = paginated;
      // eslint-disable-next-line prefer-destructuring
      this.filteredClasses = paginated[0];
    },
    changePage() {
      this.filteredClasses = this.pages[this.page - 1];
    },
    getTutorCourseClasses() {
      this.$gqlClient
        .query({
          query: this.$gql(getTutorCourseClasses),
          fetchPolicy: 'network-only',
          variables: { user_id: this.currentUser.username },
        })
        .then((response) => {
          const result = JSON.parse(response.data.getTutorCourseClasses);
          this.classes = result;
          this.filteredClasses = result;
          this.paginate();
          this.loading = false;
        });
    },
    deleteCourseClass(courseId) {
      this.loading = true;
      this.$gqlClient
        .query({
          query: this.$gql(deleteCourseClass),
          fetchPolicy: 'network-only',
          variables: { id: courseId },
        })
        // eslint-disable-next-line no-unused-vars
        .then((response) => {
          this.classes.forEach((course) => {
            if (course.id === courseId) {
              const index = this.classes.indexOf(course);
              if (index > -1) {
                this.classes.splice(index, 1);
              }
            }
          });
          this.loading = false;
        });
    },
  },
  created() {
    this.getTutorCourseClasses();
  },
};
</script>
