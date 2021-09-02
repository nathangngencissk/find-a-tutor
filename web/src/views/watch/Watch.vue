<template>
  <v-container>
    <v-row>
      <v-col xl="8" lg="8" cols="12">
        <v-row>
          <v-sheet width="100%" height="100%" elevation="1">
            <vue-plyr ref="plyr">
              <video controls crossorigin playsinline :src="videoUrl">
                <source size="720" :src="videoUrl" type="video/mp4" />
              </video>
            </vue-plyr>
          </v-sheet>
        </v-row>
        <v-row>
          <v-tabs v-model="tab" color="primary" fixed-tabs :dark="$vuetify.theme.dark">
            <v-tab v-for="item in items" :key="item.name">
              {{ item.name }}
            </v-tab>
          </v-tabs>
          <v-tabs-items v-model="tab" id="tabs-items">
            <v-tab-item>
              <v-card color="basil" flat min-height="200px">
                <CourseNotes :notes="notes" :courseId="$route.params.id" />
              </v-card>
            </v-tab-item>
            <v-tab-item>
              <v-card color="basil" flat min-height="200px">
                <CourseClasses :classes="classes" :courseId="$route.params.id" />
              </v-card>
            </v-tab-item>
            <v-tab-item>
              <v-card color="basil" flat min-height="200px">
                <CourseReview :rate="rate" :courseId="$route.params.id" />
              </v-card>
            </v-tab-item>
          </v-tabs-items>
        </v-row>
      </v-col>
      <v-col xl="4" lg="4" cols="12">
        <v-subheader>Aulas</v-subheader>
        <v-expansion-panels popout>
          <v-expansion-panel v-for="step in courseSteps" :key="step.id">
            <v-expansion-panel-header> {{ step.name }} </v-expansion-panel-header>
            <v-expansion-panel-content>
              <p>
                {{ step.description }}
              </p>
              <v-btn color="primary" depressed text @click="changeVideo(step.video)"
                >Assistir</v-btn
              >
            </v-expansion-panel-content>
          </v-expansion-panel>
        </v-expansion-panels>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import CourseNotes from '@/views/watch/components/CourseNotes.vue';
import CourseClasses from '@/views/watch/components/CourseClasses.vue';
import CourseReview from '@/views/watch/components/CourseReview.vue';
import { mapGetters } from 'vuex';
import { getCourseSteps, getCourseRate, getCourseNotes, getCourseClasses } from '@/graphql/queries';

export default {
  name: 'Watch',
  title: 'Programação C# | Find a Tutor',
  components: { CourseNotes, CourseClasses, CourseReview },
  data: () => ({
    tab: null,
    items: [
      {
        name: 'Anotações',
        body: '',
      },
      {
        name: 'Turmas',
        body: '',
      },
      {
        name: 'Avaliar',
        body: '',
      },
    ],
    courseSteps: [],
    player: {},
    rate: {},
    notes: [],
    classes: [],
    videoUrl: '',
  }),
  methods: {
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
          this.changeVideo(result[0].video);
        });
    },
    getCourseRate() {
      this.$gqlClient
        .query({
          query: this.$gql(getCourseRate),
          fetchPolicy: 'network-only',
          variables: { course_id: this.$route.params.id, user_id: this.currentUser.username },
        })
        .then((response) => {
          const result = JSON.parse(response.data.getCourseRate);
          // eslint-disable-next-line prefer-destructuring
          this.rate = result[0];
        });
    },
    getCourseNotes() {
      this.$gqlClient
        .query({
          query: this.$gql(getCourseNotes),
          fetchPolicy: 'network-only',
          variables: { course_id: this.$route.params.id, user_id: this.currentUser.username },
        })
        .then((response) => {
          const result = JSON.parse(response.data.getCourseNotes);
          this.notes = result;
        });
    },
    getCourseClasses() {
      this.$gqlClient
        .query({
          query: this.$gql(getCourseClasses),
          fetchPolicy: 'network-only',
          variables: { course_id: this.$route.params.id, user_id: this.currentUser.username },
        })
        .then((response) => {
          const result = JSON.parse(response.data.getCourseClasses);
          this.classes = result;
        });
    },
    changeVideo(video) {
      this.videoUrl = `${this.$cloudfrontUrl}public/${video}`;
      document.querySelector('video').load();
    },
  },
  computed: {
    ...mapGetters('auth', ['currentUser']),
  },
  created() {
    this.getCourseSteps();
    this.getCourseRate();
    this.getCourseNotes();
    this.getCourseClasses();
  },
};
</script>

<style lang="scss" scoped>
#tabs-items {
  width: 100%;
  margin-bottom: 16px;
}
</style>
