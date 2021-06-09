<template>
  <v-container>
    <v-row align="center">
      <v-col cols="6">
        <h2>Nome</h2>
        <v-text-field label="Nome" :value="exerciseList.name" class="mt-3"></v-text-field>
      </v-col>
      <v-col cols="6">
        <h2>Tags</h2>
        <v-select
          v-model="selectedTags"
          :items="tags"
          attach
          chips
          label="Tags"
          multiple
        ></v-select>
      </v-col>
    </v-row>
    <v-row>
      <v-col cols="6">
        <h2>Descrição</h2>
        <textarea :value="exerciseList.description" auto-grow @input="update($event)"></textarea>
      </v-col>
      <v-col cols="6">
        <h2>Preview</h2>
        <div v-html="compiledMarkdown"></div>
      </v-col>
    </v-row>
    <v-row>
      <v-row justify="space-between" align="center" class="my-1">
        <h2>Questões</h2>
        <v-btn color="success" dark class="mb-2" @click="addExercise"> Adicionar </v-btn>
      </v-row>

      <v-list>
        <draggable v-model="exerciseList.exercises">
          <transition-group>
            <v-list-item v-for="(exercise, i) in exerciseList.exercises" :key="exercise.id">
              <v-list-item-content class="question my-1">
                <v-row justify="center" align="center">
                  <v-col cols="1"
                    ><b>{{ i + 1 }}</b></v-col
                  >
                  <v-col cols="8">
                    {{ exercise.question }}
                  </v-col>
                  <v-col cols="1">
                    <v-btn color="primary" text @click="editExercise($event, exercise)"
                      >Editar</v-btn
                    >
                  </v-col>
                  <v-col cols="1">
                    <v-btn color="error" text @click="remove($event, item)">Remover</v-btn>
                  </v-col>
                </v-row>
              </v-list-item-content>
            </v-list-item>
          </transition-group>
        </draggable>
      </v-list>
      <v-btn class="mr-4 mt-4" color="success" @click="snackbar = true"> Salvar </v-btn>
      <v-snackbar v-model="snackbar">
        {{ text }}

        <template v-slot:action="{ attrs }">
          <v-btn color="primary" text v-bind="attrs" @click="snackbar = false"> Close </v-btn>
        </template>
      </v-snackbar>
    </v-row>
    <v-overlay :z-index="zIndex" :value="overlay" :dark="$vuetify.theme.dark">
      <v-card class="pa-4" min-width="600px">
        <v-form>
          <v-text-field label="Questão" :value="question"></v-text-field>
          <v-subheader>Marque as alternativas corretas</v-subheader>
          <v-checkbox
            v-model="rightOptions"
            class="shrink mr-2 mt-0"
            v-for="option in options"
            :key="option.id"
            :value="option.id"
          >
            <template v-slot:label>
              <v-text-field
                label="Alternativa"
                placeholder="Alternativa"
                :value="option.text"
              ></v-text-field>
            </template>
          </v-checkbox>
          <v-textarea
            outlined
            name="input-7-4"
            label="Explicação da resposta"
            v-model="responseExplanation"
          ></v-textarea>
        </v-form>
        <v-btn class="mr-4" color="success" @click="overlay = false"> Salvar </v-btn>
        <v-btn color="error" outlined @click="overlay = false"> Fechar </v-btn>
      </v-card>
    </v-overlay>
  </v-container>
</template>

<script>
import draggable from 'vuedraggable';

export default {
  name: 'DashboardEditExercise',
  components: { draggable },
  data: () => ({
    tags: ['Programação', 'Música', 'Matemática', 'Desenho', 'Tecnologia', 'Jogos'],
    selectedTags: [],
    input: '# hello',
    page: 1,
    pageCount: 0,
    itemsPerPage: 10,
    search: '',
    isDragging: false,
    overlay: false,
    zIndex: 2,
    question: '',
    responseExplanation: '',
    options: [],
    selectedOptions: [],
    rightOptions: [],
    text: 'Salvo com sucesso',
    snackbar: false,
  }),
  computed: {
    exerciseList() {
      return this.$route.params.exerciseList;
    },
    compiledMarkdown() {
      return this.$marked(this.$route.params.exerciseList.description, { sanitize: true });
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
          text: '#',
          align: 'start',
          sortable: false,
          value: 'order',
        },
        {
          text: 'Nome',
          align: 'start',
          value: 'name',
        },
        {
          text: 'Descrição',
          value: 'descrição',
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
      this.question = exercise.question;
      this.options = exercise.options;
      this.rightOptions = exercise.rightOptions;
      this.overlay = true;
    },
    addExercise() {
      this.question = '';
      this.rightOptions = [];
      this.options = [
        {
          id: 1,
          text: '',
        },
        {
          id: 2,
          text: '',
        },
        {
          id: 3,
          text: '',
        },
        {
          id: 4,
          text: '',
        },
        {
          id: 5,
          text: '',
        },
      ];
      this.overlay = true;
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
