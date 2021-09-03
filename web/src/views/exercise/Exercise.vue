<template>
  <v-container>
    <v-row>
      <v-col xl="6" cols="12">
        <v-skeleton-loader
          v-bind="attrs"
          type="article, actions"
          v-if="loading"
        ></v-skeleton-loader>
        <v-sheet
          elevation="1"
          class="pa-4 mb-2"
          v-for="exercise in exercises"
          :key="exercise.id"
          v-else
        >
          <v-row justify="space-between" align="center">
            <v-col cols="10">
              <p>
                {{ exercise.description }}
              </p>
            </v-col>
            <v-col cols="2">
              <v-btn color="primary" depressed text @click="select($event, exercise)">Ver</v-btn>
              <v-icon left color="success" v-if="exercise.done"> fas fa-clipboard-check </v-icon>
            </v-col>
          </v-row>
        </v-sheet>
      </v-col>
      <v-divider vertical inset></v-divider>
      <v-col xl="6" cols="12" v-if="selectedExercise !== {}">
        <div class="ml-4">
          <v-subheader>
            {{ selectedExercise.description }}
          </v-subheader>
          <v-radio-group v-model="radioGroup">
            <v-radio
              v-for="option in selectedExercise.options"
              :key="option.id"
              :label="option.description"
              :value="option.id"
              v-on:change="show = false"
            ></v-radio>
          </v-radio-group>
          <v-btn color="success" depressed @click="answer" v-if="selectedExercise.id"
            >Responder</v-btn
          >
          <v-btn depressed @click="answer" disabled v-else>Responder</v-btn>
        </div>

        <v-divider class="my-4"></v-divider>
        <v-card class="mx-auto" v-if="show">
          <v-toolbar :color="rightChoice == radioGroup ? 'success' : 'error'" class="white--text">
            <v-toolbar-title>{{
              rightChoice == radioGroup ? 'Correta' : 'Incorreta'
            }}</v-toolbar-title>
          </v-toolbar>

          <v-container fluid>
            <v-subheader>Reposta correta</v-subheader>
            <h2>{{ rightChoiceDesc }}</h2>
            <v-subheader>Explicação</v-subheader>
            <p>
              {{ selectedExercise.justification }}
            </p>
          </v-container>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import { mapGetters } from 'vuex';
import { getExerciseList, answerExercise } from '@/graphql/queries';

export default {
  title: 'Exercícios | Find a Tutor',
  name: 'Exercise',
  data: () => ({
    loading: true,
    attrs: {
      class: 'mb-6',
      boilerplate: true,
      elevation: 2,
    },
    radioGroup: 1,
    show: false,
    rightChoice: 0,
    rightChoiceDesc: '',
    exercises: {},
    selectedExercise: {},
  }),
  methods: {
    answer() {
      this.show = true;
      this.answerExercise();
      this.selectedExercise.done = true;
    },
    select(event, exercise) {
      this.selectedExercise = exercise;
      this.rightChoice = exercise.right_option_id;
      this.selectedExercise.options.forEach((option) => {
        if (option.id === this.selectedExercise.right_option_id) {
          this.rightChoiceDesc = option.description;
        }
      });
      this.show = false;
    },
    getExerciseList() {
      this.$gqlClient
        .query({
          query: this.$gql(getExerciseList),
          fetchPolicy: 'network-only',
          variables: {
            id: this.$route.params.id,
            user_id: this.currentUser.username,
          },
        })
        .then((response) => {
          const result = JSON.parse(response.data.getExerciseList);
          this.exercises = result;
          this.loading = false;
        });
    },
    answerExercise() {
      this.$gqlClient.query({
        query: this.$gql(answerExercise),
        variables: {
          exercise_id: this.selectedExercise.id,
          user_id: this.currentUser.username,
        },
      });
    },
  },
  computed: {
    ...mapGetters('auth', ['currentUser']),
  },
  created() {
    this.getExerciseList();
  },
};
</script>
