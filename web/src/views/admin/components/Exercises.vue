<template>
  <v-container>
    <v-data-table
      :headers="headers"
      :items="exercises"
      hide-default-footer
      item-key="name"
      class="elevation-1"
      :items-per-page="itemsPerPage"
      :search="search"
    >
      <template v-slot:top>
        <v-toolbar flat>
          <v-toolbar-title>Exercícios</v-toolbar-title>
          <v-divider class="mx-4" inset vertical></v-divider>
          <v-text-field v-model="search" label="Filtrar" class="mx-4"></v-text-field>
        </v-toolbar>
      </template>
      <template v-slot:item.selectExercise="{ item }">
        <v-btn color="primary" text @click="selectExercise($event, item)">Ver Mais</v-btn>
      </template>
    </v-data-table>
    <v-overlay :value="loading">
      <v-progress-circular indeterminate size="64"></v-progress-circular>
    </v-overlay>
    <v-dialog v-model="dialog" scrollable max-width="600px">
      <v-card>
        <v-card-title>{{ selectedExercise.title }}</v-card-title>
        <v-divider></v-divider>
        <v-card-subtitle class="pb-0 my-2">
          <b class="mr-1">Criador: </b> {{ selectedExercise.creator_id }}
          <p class="my-2"><b class="mr-1">Descrição: </b> {{ selectedExercise.description }}</p>
        </v-card-subtitle>
        <v-divider></v-divider>

        <v-card-text class="text--primary">
          <v-divider></v-divider>
          <div v-for="exercise in selectedExercise.exercises" :key="exercise.id">
            <b class="mr-1 d-block">Pergunta: </b>
            <v-subheader class="subtitle-2 my-3">{{ exercise.description }}</v-subheader>
            <v-radio-group v-model="radioGroup" :value="rightOptionId">
              <v-radio
                v-for="option in exercise.options"
                :key="option.id"
                :label="option.description"
                :value="option.id"
                disabled
              ></v-radio>
            </v-radio-group>
            <b class="mr-1 d-block">Justificativa: </b>
            <v-subheader class="subtitle-2 my-3">{{ exercise.justification }}</v-subheader>
            <v-divider></v-divider>
          </div>
        </v-card-text>
        <v-divider></v-divider>
        <v-card-actions>
          <v-btn
            class="white--text mr-4"
            color="success"
            @click="changeExerciseStatus($event, selectedExercise, 'APROVADO')"
          >
            Aprovar
          </v-btn>
          <v-btn
            class="white--text mr-4"
            color="error"
            @click="changeExerciseStatus($event, selectedExercise, 'NEGADO')"
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
import { getExercisesForApproval, changeExerciseStatus } from '@/graphql/queries';

export default {
  title: 'Exercícios | Find a Tutor',
  data() {
    return {
      loading: true,
      search: '',
      exercises: [],
      dialog: false,
      selectedExercise: {},
      radioGroup: null,
      itemsPerPage: -1,
    };
  },
  computed: {
    rightOptionId() {
      return this.selectedExercise.right_option_id;
    },
    headers() {
      return [
        {
          text: 'Usuário',
          align: 'start',
          value: 'creator_id',
        },
        { text: 'Lista', value: 'title', align: 'center' },
        { text: 'Descrição', value: 'description', align: 'center' },
        { text: 'Data', value: 'created_at', align: 'center' },
        { text: 'Status', value: 'status', align: 'center' },
        { text: 'Ver Mais', value: 'selectExercise', sortable: false, align: 'center' },
      ];
    },
  },
  methods: {
    selectExercise(event, exercise) {
      this.selectedExercise = exercise;
      this.dialog = true;
    },
    getExercisesForApproval() {
      this.$gqlClient
        .query({
          query: this.$gql(getExercisesForApproval),
          fetchPolicy: 'network-only',
        })
        .then((response) => {
          const result = JSON.parse(response.data.getExercisesForApproval);
          this.exercises = result;
          this.loading = false;
        });
    },
    changeExerciseStatus(event, exercise, status) {
      this.loading = true;
      this.$gqlClient
        .query({
          query: this.$gql(changeExerciseStatus),
          fetchPolicy: 'network-only',
          variables: {
            id: exercise.id,
            status,
            updated_at: this.$getFormattedDate(),
          },
        })
        // eslint-disable-next-line no-unused-vars
        .then((response) => {
          this.loading = false;
          this.dialog = false;
          this.getExercisesForApproval();
        });
    },
  },
  created() {
    this.getExercisesForApproval();
  },
};
</script>
