<template>
  <v-container>
    <v-form class="mx-2">
      <v-text-field
        label="Título da nota"
        :value="editingTitle"
        v-model="editingTitle"
      ></v-text-field>
      <v-textarea
        solo
        name="input-7-4"
        label="Corpo da nota"
        :value="editing"
        v-model="editing"
      ></v-textarea>
      <v-btn class="mb-4" color="success" @click="addNote">Adicionar</v-btn>
    </v-form>
    <v-card v-for="note in notes" :key="note.id" class="my-2">
      <v-toolbar color="transparent" dark>
        <v-text-field
          label="Título da nota"
          v-if="note.id == editingId"
          :value="editingTitle"
          v-model="editingTitle"
        ></v-text-field>
        <v-toolbar-title v-else v-bind:class="{ 'note-title': !darkTheme }">{{
          note.title
        }}</v-toolbar-title>

        <v-spacer></v-spacer>

        <v-btn icon v-if="note.id == editingId">
          <v-icon color="success" @click="save($event, note)">fas fa-check</v-icon>
        </v-btn>
        <v-btn icon v-else>
          <v-icon color="secondary" @click="edit($event, note)">fas fa-edit</v-icon>
        </v-btn>
        <v-btn icon>
          <v-icon color="error" @click="remove($event, note)">fas fa-trash-alt</v-icon>
        </v-btn>
      </v-toolbar>
      <v-card-subtitle class="card-body">
        <v-textarea
          solo
          name="input-7-4"
          label="Corpo da nota"
          v-if="note.id == editingId"
          :value="editing"
          v-model="editing"
        ></v-textarea>
        <p v-else>
          {{ note.body }}
        </p>
      </v-card-subtitle>
    </v-card>
  </v-container>
</template>

<script>
export default {
  name: 'CourseNotes',
  props: ['courseId'],
  data: () => ({
    title: '',
    body: '',
    editingId: null,
    editingTitle: '',
    editing: '',
    notes: [
      {
        id: 3,
        title: 'Titulo Nota 3',
        body: 'Corpo Nota 3',
        courseId: '1',
      },
      {
        id: 4,
        title: 'Titulo Nota 4',
        body: 'Corpo Nota 4',
        courseId: '1',
      },
      {
        id: 5,
        title: 'Titulo Nota 5',
        body: 'Corpo Nota 5',
        courseId: '1',
      },
    ],
  }),
  methods: {
    clear() {
      this.editingId = null;
      this.editingTitle = '';
      this.editing = '';
    },
    edit(event, note) {
      this.editingId = note.id;
      this.editingTitle = note.title;
      this.editing = note.body;
    },
    save(event, note) {
      const updatedNote = {
        id: note.id,
        title: this.editingTitle,
        body: this.editing,
        courseId: note.courseId,
      };
      const index = this.notes.indexOf(note);
      this.remove({}, note);
      this.notes.splice(index, 0, updatedNote);
      this.clear();
    },
    remove(event, note) {
      const index = this.notes.indexOf(note);
      if (index > -1) {
        this.notes.splice(index, 1);
      }
    },
    addNote() {
      const newNote = {
        id: 6,
        title: this.editingTitle,
        body: this.editing,
        courseId: this.courseId,
      };
      this.notes.unshift(newNote);
      this.clear();
    },
  },
  computed: {
    darkTheme() {
      return this.$vuetify.theme.dark;
    },
  },
};
</script>

<style lang="scss" scoped>
.card-body {
  background-color: #f7f3eb;
  p {
    color: #313639;
  }
}

.note-title {
  color: #313639;
}
</style>
