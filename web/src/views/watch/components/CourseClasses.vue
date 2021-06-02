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
                    <li><b>Inicio:</b> {{ cl.start }}</li>
                    <li><b>Término:</b> {{ cl.end }}</li>
                    <li><b>Frequência:</b> {{ cronToDatetime(cl) }}</li>
                  </ul>
                  <h3 class="mt-4 enrolled" v-if="enrolled == cl.id">MATRICULADO</h3>
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
export default {
  name: 'CourseClasses',
  props: ['courseId'],
  data: () => ({
    sheet: false,
    sheetText: '',
    enrolled: null,
    enrolling: null,
    classes: [
      {
        id: 1,
        courseId: '1',
        timeExpression: '0 14 * * 1',
        start: '2021-07-20',
        end: '2021-10-21',
      },
      {
        id: 2,
        courseId: '1',
        timeExpression: '0 19 * * 1',
        start: '2021-07-20',
        end: '2021-10-21',
      },
      {
        id: 3,
        courseId: '1',
        timeExpression: '0 19 * * 3',
        start: '2021-07-20',
        end: '2021-10-21',
      },
      {
        id: 4,
        courseId: '1',
        timeExpression: '0 14 * * 1',
        start: '2021-08-14',
        end: '2021-11-18',
      },
      {
        id: 5,
        courseId: '1',
        timeExpression: '0 19 * * 1',
        start: '2021-08-14',
        end: '2021-11-18',
      },
      {
        id: 6,
        courseId: '1',
        timeExpression: '0 19 * * 3,4',
        start: '2021-08-14',
        end: '2021-11-18',
      },
    ],
  }),
  methods: {
    enroll(event, cl) {
      this.sheetText = `${this.cronToDatetime(cl)} de ${cl.start} até ${cl.end}`;
      this.sheet = !this.sheet;
      this.enrolling = cl;
    },
    confirmEnroll(event, cl) {
      this.sheet = !this.sheet;
      this.enrolled = cl.id;
    },
    cronToDatetime(cl) {
      const startDate = new Date(Date.parse(cl.start));
      const options = {
        currentDate: startDate,
        endDate: this.addDays(startDate, 7),
        iterator: true,
      };
      const optionsFormatDate = { weekday: 'long', hour: '2-digit', minute: '2-digit' };
      const interval = this.$parser.parseExpression(cl.timeExpression, options);
      const frequency = [];
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
      console.log(uniqueFrequency);
      return uniqueFrequency.join('; ');
    },
    addDays(date, days) {
      const result = new Date(date);
      result.setDate(result.getDate() + days);
      return result;
    },
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
