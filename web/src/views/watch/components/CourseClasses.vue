<template>
  <v-container>
    <v-item-group>
      <v-container>
        <v-row>
          <v-col v-for="cl in classes" :key="cl.id" cols="12" md="4">
            <v-item>
              <v-card class="d-flex align-center" height="200" @click="enroll($event, cl)">
                <v-card-subtitle>
                  <ul>
                    <li><b>Inicio:</b> {{ cl.start_date }}</li>
                    <li><b>Término:</b> {{ cl.end_date }}</li>
                    <li><b>Frequência:</b> {{ cronToDatetime(cl) }}</li>
                  </ul>
                  <h3 class="mt-4 enrolled" v-if="cl.enrolled">MATRICULADO</h3>
                </v-card-subtitle>
              </v-card>
            </v-item>
          </v-col>
        </v-row>
      </v-container>
    </v-item-group>
    <v-bottom-sheet v-model="sheet">
      <v-sheet class="text-center" height="200px">
        <v-btn class="mt-6" color="success" @click="confirmEnroll($event, enrolling)">
          confirmar
        </v-btn>
        <v-btn class="mt-6" text color="red" @click="sheet = !sheet"> fechar </v-btn>
        <div class="py-3">Deseja se matricular na turma {{ sheetText }}</div>
      </v-sheet>
    </v-bottom-sheet>
  </v-container>
</template>

<script>
import { mapGetters } from 'vuex';
import { enrollCourseClass } from '@/graphql/queries';

export default {
  name: 'CourseClasses',
  props: ['classes', 'courseId'],
  data: () => ({
    sheet: false,
    sheetText: '',
    enrolled: null,
    enrolling: null,
  }),
  methods: {
    enroll(event, cl) {
      this.sheetText = `${this.cronToDatetime(cl)} de ${cl.start_date} até ${cl.end_date}`;
      this.sheet = !this.sheet;
      this.enrolling = cl;
    },
    confirmEnroll(event, cl) {
      this.sheet = !this.sheet;
      this.enrollCourseClass(cl);
      this.enrolled = cl.id;
    },
    cronToDatetime(cl) {
      const startDate = new Date(Date.parse(cl.start_date));
      const options = {
        currentDate: startDate,
        endDate: this.addDays(startDate, 7),
        iterator: true,
      };
      const optionsFormatDate = { weekday: 'long', hour: '2-digit', minute: '2-digit' };
      const interval = this.$parser.parseExpression(cl.schedule, options);
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
    addDays(date, days) {
      const result = new Date(date);
      result.setDate(result.getDate() + days);
      return result;
    },
    enrollCourseClass(cl) {
      this.$gqlClient
        .query({
          query: this.$gql(enrollCourseClass),
          variables: {
            course_class_id: cl.id,
            user_id: this.currentUser.username,
            created_at: this.$getFormattedDate(),
            updated_at: this.$getFormattedDate(),
          },
        })
        .then((response) => {
          const result = JSON.parse(response.data.enrollCourseClass);
          this.courseSteps = result;
        });
    },
  },
  computed: {
    ...mapGetters('auth', ['currentUser']),
  },
};
</script>

<style lang="scss" scoped>
.enrolled {
  color: #4caf50;
  transform: rotate(-5deg);
  right: 2rem;
  bottom: 2rem;
  position: absolute;
}
</style>
