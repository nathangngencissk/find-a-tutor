<template>
  <v-container>
    <v-subheader> Calendário semanal </v-subheader>
    <v-row>
      <v-col>
        <v-sheet height="400">
          <v-calendar
            ref="calendar"
            :now="today"
            :value="today"
            :events="events"
            color="primary"
            type="week"
          ></v-calendar>
        </v-sheet>
      </v-col>
    </v-row>
    <v-subheader> Turmas </v-subheader>
    <v-row justify="start">
      <v-col xl="3" lg="4" md="4" sm="6" xs="12" v-for="cl in ongoingClasses" :key="cl.id">
        <CourseClassCard :courseClass="cl" />
      </v-col>
    </v-row>
    <v-subheader> Histórico </v-subheader>
    <v-expansion-panels popout>
      <v-expansion-panel v-for="cl in history" :key="cl.id">
        <v-expansion-panel-header>
          {{ cl.name }}
          <div class="text-center">
            <v-chip color="success" class="mr-2" label v-if="cl.status == 'COMPLETED'"
              ><v-icon left> far fa-calendar-check </v-icon> Concluido
            </v-chip>
            <v-chip color="error" class="mr-2" label v-else
              ><v-icon left> far fa-calendar-times </v-icon> Abandonada
            </v-chip>
            <v-chip :color="cl.status == 'COMPLETED' ? 'success' : 'error'" label>
              {{ cl.start_date }} - {{ cl.end_date }}
            </v-chip>
          </div></v-expansion-panel-header
        >
        <v-expansion-panel-content>
          <v-subheader> {{ cl.name }} </v-subheader>
          <p>
            {{ cl.description }}
          </p>
          <v-btn color="primary" depressed text :to="'/class/' + cl.id + '/lecture'"
            >Ver Turma</v-btn
          >
        </v-expansion-panel-content>
      </v-expansion-panel>
    </v-expansion-panels>
  </v-container>
</template>

<script>
import CourseClassCard from '@/components/CourseClassCard.vue';
import { mapGetters } from 'vuex';
import { myCourseClasses } from '@/graphql/queries';

export default {
  name: 'Classes',
  title: 'Minhas turmas | Find a Tutor',
  components: { CourseClassCard },
  data: () => ({
    today: new Date().toISOString().slice(0, 10),
    ongoingClasses: [],
    history: [],
    events: [],
    classes: [],
  }),
  mounted() {
    this.$refs.calendar.scrollToTime('19:00');
  },
  computed: {
    ...mapGetters('auth', ['currentUser']),
  },
  methods: {
    myCourseClasses() {
      this.$gqlClient
        .query({
          query: this.$gql(myCourseClasses),
          fetchPolicy: 'network-only',
          variables: { id: this.currentUser.username },
        })
        .then((response) => {
          const result = JSON.parse(response.data.myCourseClasses);
          this.ongoingClasses = result.ongoing_classes;
          this.history = result.history;
          const events = [];
          result.current_week_classes.forEach((element) => {
            events.push({
              name: element.class_name,
              start: element.class_start,
              end: element.class_end,
            });
          });
          this.events = events;
        });
    },
  },
  created() {
    this.myCourseClasses();
  },
};
</script>

<style scoped>
.my-event {
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  border-radius: 2px;
  background-color: #1867c0;
  color: #ffffff;
  border: 1px solid #1867c0;
  font-size: 12px;
  padding: 3px;
  cursor: pointer;
  margin-bottom: 1px;
  left: 4px;
  margin-right: 8px;
  position: relative;
}

.my-event.with-time {
  position: absolute;
  right: 4px;
  margin-right: 0px;
}
</style>
