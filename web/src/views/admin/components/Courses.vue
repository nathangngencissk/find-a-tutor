<template>
  <v-container>
    <v-data-table
      :headers="headers"
      :items="courses"
      hide-default-footer
      item-key="name"
      class="elevation-1"
      :items-per-page="itemsPerPage"
      :search="search"
    >
      <template v-slot:top>
        <v-toolbar flat>
          <v-toolbar-title>Cursos</v-toolbar-title>
          <v-divider class="mx-4" inset vertical></v-divider>
          <v-text-field v-model="search" label="Filtrar" class="mx-4"></v-text-field>
        </v-toolbar>
      </template>
      <template v-slot:item.selectCourse="{ item }">
        <v-btn color="primary" text @click="selectCourse($event, item)">Ver Mais</v-btn>
      </template>
    </v-data-table>
    <v-overlay :value="loading">
      <v-progress-circular indeterminate size="64"></v-progress-circular>
    </v-overlay>
    <v-dialog v-model="dialog" scrollable max-width="600px">
      <v-card>
        <v-img
          class="white--text align-end"
          height="200px"
          :src="$cloudfrontUrl + 'public/' + selectedCourse.image"
        >
          <v-card-title>{{ selectedCourse.name }}</v-card-title>
        </v-img>
        <v-divider></v-divider>
        <v-card-subtitle class="pb-0 my-2">
          <b class="mr-1">Criador: </b> {{ selectedCourse.owner_id }}
          <p class="my-2"><b class="mr-1">Descrição: </b> {{ selectedCourse.short_description }}</p>
        </v-card-subtitle>
        <v-divider></v-divider>

        <v-card-text class="text--primary">
          <v-divider></v-divider>
          <div v-for="step in selectedCourse.steps" :key="step.id">
            <v-subheader class="subtitle-1">{{ step.name }}</v-subheader>
            <vue-plyr ref="plyr">
              <video
                controls
                crossorigin
                playsinline
                :src="$cloudfrontUrl + 'public/' + step.video"
              >
                <source
                  size="720"
                  :src="$cloudfrontUrl + 'public/' + step.video"
                  type="video/mp4"
                />
              </video>
            </vue-plyr>
            <p class="mt-2">
              {{ step.description }}
            </p>
          </div>
        </v-card-text>
        <v-divider></v-divider>
        <v-card-actions>
          <v-btn
            class="white--text mr-4"
            color="success"
            @click="changeCourseStatus($event, selectedCourse, 'APROVADO')"
          >
            Aprovar
          </v-btn>
          <v-btn
            class="white--text mr-4"
            color="error"
            @click="changeCourseStatus($event, selectedCourse, 'NEGADO')"
          >
            Negar
          </v-btn>
          <v-btn class="white--text" color="error" text @click="dialog = false"> Fechar </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </v-container>
</template>

<script>
import { getCoursesForApproval, changeCourseStatus } from '@/graphql/queries';

export default {
  title: 'Cursos | Find a Tutor',
  data() {
    return {
      loading: true,
      search: '',
      courses: [],
      dialog: false,
      selectedCourse: {},
      itemsPerPage: -1,
    };
  },
  computed: {
    headers() {
      return [
        {
          text: 'Usuário',
          align: 'start',
          value: 'owner_id',
        },
        { text: 'Curso', value: 'name', align: 'center' },
        { text: 'Descrição', value: 'short_description', align: 'center' },
        { text: 'Data', value: 'created_at', align: 'center' },
        { text: 'Status', value: 'status', align: 'center' },
        { text: 'Ver Mais', value: 'selectCourse', sortable: false, align: 'center' },
      ];
    },
  },
  methods: {
    selectCourse(event, course) {
      this.selectedCourse = course;
      this.dialog = true;
    },
    getCoursesForApproval() {
      this.$gqlClient
        .query({
          query: this.$gql(getCoursesForApproval),
          fetchPolicy: 'network-only',
        })
        .then((response) => {
          const result = JSON.parse(response.data.getCoursesForApproval);
          this.courses = result;
          this.loading = false;
        });
    },
    changeCourseStatus(event, course, status) {
      this.loading = true;
      this.$gqlClient
        .query({
          query: this.$gql(changeCourseStatus),
          fetchPolicy: 'network-only',
          variables: {
            id: course.id,
            status,
            updated_at: this.$getFormattedDate(),
          },
        })
        // eslint-disable-next-line no-unused-vars
        .then((response) => {
          this.loading = false;
          this.dialog = false;
          this.getCoursesForApproval();
        });
    },
  },
  created() {
    this.getCoursesForApproval();
  },
};
</script>
