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
      <v-col xl="3" lg="4" md="4" sm="6" xs="12" v-for="cl in classes" :key="cl.id">
        <CourseClassCard :courseClass="cl" />
      </v-col>
    </v-row>
    <v-subheader> Histórico </v-subheader>
    <v-expansion-panels popout>
      <v-expansion-panel v-for="(item, i) in 5" :key="i">
        <v-expansion-panel-header>
          Turma {{ i }}
          <div class="text-center">
            <v-chip color="success" class="mr-2" label v-if="i < 4"
              ><v-icon left> far fa-calendar-check </v-icon> Concluido
            </v-chip>
            <v-chip color="error" class="mr-2" label v-else
              ><v-icon left> far fa-calendar-times </v-icon> Abandonada
            </v-chip>
            <v-chip color="success" label v-if="i == 0"> 11/11/2020 - 12/02/2021 </v-chip>
            <v-chip color="success" label v-if="i == 1"> 10/01-2021 - 07/04/2021 </v-chip>
            <v-chip color="success" label v-if="i == 2"> 20/04/2021 - 22/06/2021 </v-chip>
            <v-chip color="success" label v-if="i == 3"> 23/01/2021 - 23/06/2021 </v-chip>
            <v-chip color="error" label v-if="i == 4"> 24/02/2021 - 12/03/2021 </v-chip>
          </div></v-expansion-panel-header
        >
        <v-expansion-panel-content>
          <v-subheader> Curso </v-subheader>
          <p>
            Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor
            incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud
            exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
          </p>
          <v-btn color="primary" depressed text v-if="i != 4">Ver Turma</v-btn>
        </v-expansion-panel-content>
      </v-expansion-panel>
    </v-expansion-panels>
  </v-container>
</template>

<script>
import CourseClassCard from '@/components/CourseClassCard.vue';

export default {
  name: 'Classes',
  title: 'Minhas turmas | Find a Tutor',
  components: { CourseClassCard },
  data: () => ({
    today: '2019-01-08',
    events: [
      {
        name: 'Programação C#',
        start: '2019-01-07 19:00:00',
        end: '2019-01-07 21:00:00',
      },
      {
        name: 'Redes de Computadores',
        start: '2019-01-09 19:00:00',
        end: '2019-01-09 22:30:00',
      },
    ],
    classes: [
      {
        id: 1,
        name: 'Programação C#',
        image: 'https://miro.medium.com/max/1000/1*c34daw_rg89UAh4uFCZ96w.jpeg',
        category: 'Tecnologia',
        description:
          'Lorem ipsum dolor sit amet consectetur adipisicing elit. At libero commodi, voluptates voluptas autem maiores quasi rem sapiente ut optio corporis ullam reiciendis, sequi veniam mollitia! Amet tempore saepe eaque!',
        start: '2021-07-21',
        end: '2021-10-22',
      },
      {
        id: 2,
        name: 'Redes de Computadores',
        image:
          'https://previews.123rf.com/images/nirots/nirots1202/nirots120200078/12476827-social-network-laptop-communication-the-computer-networks.jpg',
        category: 'Tecnologia',
        description:
          'Lorem ipsum dolor sit amet consectetur adipisicing elit. At libero commodi, voluptates voluptas autem maiores quasi rem sapiente ut optio corporis ullam reiciendis, sequi veniam mollitia! Amet tempore saepe eaque!',
        start: '2021-08-14',
        end: '2021-11-17',
      },
    ],
  }),
  mounted() {
    this.$refs.calendar.scrollToTime('19:00');
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
