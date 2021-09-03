<template>
  <v-container>
    <v-row align="center">
      <v-col xl="6" cols="12">
        <h2>Nome</h2>
        <v-text-field label="Nome" v-model="exerciseList.title" class="mt-3"></v-text-field>
      </v-col>
      <v-col xl="6" cols="12">
        <h2>Tags</h2>
        <v-combobox
          v-model="selectedTags"
          :items="tags"
          :search-input.sync="search"
          hide-selected
          multiple
          small-chips
        >
          <template v-slot:no-data>
            <v-list-item>
              <v-list-item-content>
                <v-list-item-title>
                  Nenhum resultado para "<strong>{{ search }}</strong
                  >". Aperte <kbd>enter</kbd> para adicionar de qualquer maneira.
                </v-list-item-title>
              </v-list-item-content>
            </v-list-item>
          </template>
        </v-combobox>
      </v-col>
    </v-row>
    <v-row>
      <v-col xl="6" cols="12">
        <h2>Descrição</h2>
        <textarea v-model="exerciseList.description" auto-grow @input="update($event)"></textarea>
      </v-col>
      <v-col xl="6" cols="12">
        <h2>Preview</h2>
        <div v-html="compiledMarkdown"></div>
      </v-col>
    </v-row>
    <v-row justify="center">
      <v-col cols="10">
        <h2 class="mb-2">Exercicios</h2>
        <v-data-table
          :headers="headers"
          :items="exerciseList.exercises"
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
              <v-toolbar-title>Exercicios</v-toolbar-title>
              <v-divider class="mx-4" inset vertical></v-divider>
              <v-btn color="success" dark class="mb-2" @click="addExercise" text outlined>
                Novo Exercício
              </v-btn>
            </v-toolbar>
          </template>
          <template v-slot:item.edit="{ item }">
            <v-btn color="primary" text @click="editExercise($event, item)">Editar</v-btn>
          </template>
          <template v-slot:item.remove="{ item }">
            <v-btn color="error" text @click="deleteExercise($event, item)">Remover</v-btn>
          </template>
        </v-data-table>
      </v-col>
      <v-overlay :value="loading">
        <v-progress-circular indeterminate size="64"></v-progress-circular>
      </v-overlay>
    </v-row>
    <v-row justify="center">
      <v-btn class="mr-4" color="success" x-large @click="save"> Salvar </v-btn>
    </v-row>
    <v-snackbar v-model="snackbar">
      {{ text }}

      <template v-slot:action="{ attrs }">
        <v-btn color="primary" text v-bind="attrs" @click="snackbar = false"> Close </v-btn>
      </template>
    </v-snackbar>
    <v-overlay :z-index="zIndex" :value="overlay" :dark="$vuetify.theme.dark" scrollable>
      <v-card class="pa-4" min-width="600px">
        <v-form>
          <v-text-field label="Questão" v-model="editingExercise.description"></v-text-field>
          <v-subheader>Marque a alternativa correta</v-subheader>
          <v-radio-group v-model="editingExercise.right_option_id">
            <v-radio v-for="option in editingExercise.options" :key="option.id" :value="option.id">
              <template v-slot:label>
                <v-text-field
                  label="Alternativa"
                  placeholder="Alternativa"
                  v-model="option.description"
                ></v-text-field>
              </template>
            </v-radio>
          </v-radio-group>
          <v-textarea
            outlineds
            name="input-7-4"
            label="Explicação da resposta"
            v-model="editingExercise.justification"
          ></v-textarea>
        </v-form>
        <v-btn class="mr-4" color="success" @click="saveExercise"> Salvar </v-btn>
        <v-btn color="error" outlined @click="overlay = false"> Fechar </v-btn>
      </v-card>
    </v-overlay>
  </v-container>
</template>

<script>
import DOMPurify from 'dompurify';
import { mapGetters } from 'vuex';
import {
  createExercises,
  updateExercises,
  deleteExercise,
  createExerciseList,
  updateExerciseList,
} from '@/graphql/queries';

export default {
  name: 'DashboardEditExercise',
  data: () => ({
    tags: ['Programação', 'Música', 'Matemática', 'Desenho', 'Tecnologia', 'Jogos'],
    input: '# hello',
    page: 1,
    pageCount: 0,
    itemsPerPage: 10,
    search: '',
    isDragging: false,
    overlay: false,
    zIndex: 2,
    question: '',
    options: [],
    selectedOption: {},
    rightOptions: [],
    text: 'Salvo com sucesso',
    snackbar: false,
    toCreateExercises: [],
    toUpdateExercises: [],
    toDeleteExercises: [],
    editingExercise: {},
    exerciseListId: null,
    loading: false,
    selectedTags: [],
  }),
  computed: {
    ...mapGetters('auth', ['currentUser']),
    exerciseList() {
      return this.$route.params.exerciseList;
    },
    compiledMarkdown() {
      return this.$marked(DOMPurify.sanitize(this.$route.params.exerciseList.description));
    },
    headers() {
      return [
        {
          text: '',
          align: 'start',
          sortable: false,
          value: 'drag',
        },
        {
          text: 'Descrição',
          value: 'description',
        },
        { text: 'Editar', value: 'edit', sortable: false, align: 'center' },
        { text: 'Remover', value: 'remove', sortable: false, align: 'center' },
      ];
    },
    dragOptions() {
      return {
        animation: 0,
        group: 'description',
        ghostClass: 'ghost',
      };
    },
  },
  methods: {
    // eslint-disable-next-line func-names
    update(event) {
      this.exerciseList.description = event.target.value;
    },
    onMove({ relatedContext, draggedContext }) {
      const relatedElement = relatedContext.element;
      const draggedElement = draggedContext.element;
      return (!relatedElement || !relatedElement.fixed) && !draggedElement.fixed;
    },
    editExercise(event, exercise) {
      this.editingExercise = null;
      this.editingExercise = exercise;
      this.overlay = true;
    },
    addExercise() {
      this.editingExercise = {};
      this.editingExercise.id = null;
      this.editingExercise.exercise_list_id = null;
      this.editingExercise.description = '';
      this.editingExercise.justification = '';
      this.editingExercise.right_option_id = '';
      this.editingExercise.created_at = this.$getFormattedDate();
      this.editingExercise.updated_at = this.$getFormattedDate();
      this.editingExercise.options = [
        {
          id: null,
          exercise_id: null,
          description: '',
          created_at: this.$getFormattedDate(),
          updated_at: this.$getFormattedDate(),
        },
        {
          id: null,
          exercise_id: null,
          description: '',
          created_at: this.$getFormattedDate(),
          updated_at: this.$getFormattedDate(),
        },
        {
          id: null,
          exercise_id: null,
          description: '',
          created_at: this.$getFormattedDate(),
          updated_at: this.$getFormattedDate(),
        },
        {
          id: null,
          exercise_id: null,
          description: '',
          created_at: this.$getFormattedDate(),
          updated_at: this.$getFormattedDate(),
        },
        {
          id: null,
          exercise_id: null,
          description: '',
          created_at: this.$getFormattedDate(),
          updated_at: this.$getFormattedDate(),
        },
      ];
      this.overlay = true;
    },
    save() {
      if (Number.isInteger(this.exerciseList.id)) {
        this.updateExerciseList(this.exerciseList);
      } else {
        this.createExerciseList(this.exerciseList);
      }
    },
    saveExercises() {
      if (this.toCreateExercises.length > 0) {
        this.toCreateExercises.forEach((ex) => {
          // eslint-disable-next-line no-param-reassign
          ex.exercise_list_id = this.exerciseListId;
        });
        this.createExercises(JSON.stringify(this.toCreateExercises));
      }
      if (this.toUpdateExercises.length > 0) {
        this.toUpdateExercises.forEach((ex) => {
          // eslint-disable-next-line no-param-reassign
          ex.exercise_list_id = this.exerciseListId;
        });
        this.updateExercises(JSON.stringify(this.toUpdateExercises));
      }
      if (this.toDeleteExercises.length > 0) {
        this.deleteExercises(JSON.stringify(this.toDeleteExercises));
      }
    },
    saveExercise() {
      if (this.editingExercise.id == null) {
        this.toCreateExercises.push(this.editingExercise);
        this.exerciseList.exercises.push(this.editingExercise);
      } else {
        this.toUpdateExercises.push(this.editingExercise);
      }
      this.overlay = false;
    },
    createExercises(exercises) {
      this.$gqlClient.query({
        query: this.$gql(createExercises),
        fetchPolicy: 'network-only',
        variables: {
          exercises,
        },
      });
    },
    updateExercises(exercises) {
      this.$gqlClient.query({
        query: this.$gql(updateExercises),
        fetchPolicy: 'network-only',
        variables: {
          exercises,
        },
      });
    },
    deleteExercise(event, exercise) {
      this.loading = true;
      this.$gqlClient
        .query({
          query: this.$gql(deleteExercise),
          fetchPolicy: 'network-only',
          variables: {
            id: exercise.id,
          },
        })
        // eslint-disable-next-line no-unused-vars
        .then((response) => {
          this.exerciseList.exercises.forEach((ex) => {
            // eslint-disable-next-line eqeqeq
            if (ex.id == exercise.id) {
              // eslint-disable-next-line no-param-reassign
              const index = this.exerciseList.exercises.indexOf(ex);
              if (index > -1) {
                this.exerciseList.exercises.splice(index, 1);
              }
            }
          });
          this.loading = false;
        });
    },
    createExerciseList() {
      this.loading = true;
      this.$gqlClient
        .query({
          query: this.$gql(createExerciseList),
          fetchPolicy: 'network-only',
          variables: {
            title: this.exerciseList.title,
            description: this.exerciseList.description,
            status: 'EM AVALIAÇÃO',
            tags: this.selectedTags.join(','),
            creator_id: this.currentUser.username,
          },
        })
        .then((response) => {
          const result = JSON.parse(response.data.createExerciseList);
          this.exerciseListId = result.id;
          this.saveExercises();
          this.loading = false;
        });
    },
    updateExerciseList() {
      this.loading = true;
      this.$gqlClient
        .query({
          query: this.$gql(updateExerciseList),
          fetchPolicy: 'network-only',
          variables: {
            title: this.exerciseList.title,
            description: this.exerciseList.description,
            status: 'EM AVALIAÇÃO',
            tags: this.selectedTags.join(','),
            creator_id: this.currentUser.username,
            id: this.exerciseList.id,
            created_at: this.exerciseList.created_at,
          },
        })
        .then((response) => {
          const result = JSON.parse(response.data.updateExerciseList);
          this.exerciseListId = result.id;
          this.saveExercises();
          this.loading = false;
        });
    },
  },
  watch: {
    isDragging(newValue) {
      if (newValue) {
        this.delayedDragging = true;
        return;
      }
      this.$nextTick(() => {
        this.delayedDragging = false;
      });
    },
  },
  created() {
    if (this.$route.params.exerciseList.tags !== []) {
      this.selectedTags = this.$route.params.exerciseList.tags.split(',');
    } else {
      this.selectedTags = [];
    }
  },
};
</script>

<style lang="scss" scoped>
textarea {
  border: none;
  border-right: 1px solid #ccc;
  resize: none;
  outline: none;
  background-color: #f6f6f6;
  font-size: 14px;
  font-family: 'Monaco', courier, monospace;
  padding: 20px;
  width: 100%;
  min-height: 300px;
}

.page--table {
  .page {
    &__table {
      margin-top: 20px;
    }
    &__grab-icon {
      cursor: move;
    }
  }
}

.flip-list-move {
  transition: transform 1s;
}

.ghost {
  opacity: 0.2;
}

.question {
  border: 1px black solid;
  font-weight: 300;
  line-height: 1.4;
  font-size: 1.1rem;
}
</style>
