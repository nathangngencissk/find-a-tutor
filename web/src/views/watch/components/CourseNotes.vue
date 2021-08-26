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
      <v-toolbar color="transparent">
        <v-text-field
          label="Título da nota"
          v-if="note.id == editingId"
          :value="editingTitle"
          v-model="editingTitle"
          v-bind:class="{ 'note-title': !darkTheme }"
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
          <v-icon color="error" @click="remove($event, note, true)">fas fa-trash-alt</v-icon>
        </v-btn>
      </v-toolbar>
      <v-card-subtitle class="card-content">
        <v-textarea
          solo
          name="input-7-4"
          label="Corpo da nota"
          v-if="note.id == editingId"
          :value="editing"
          v-model="editing"
        ></v-textarea>
        <p v-else>
          {{ note.content }}
        </p>
      </v-card-subtitle>
    </v-card>
  </v-container>
</template>

<script>
import { upsertNote, deleteNote, createNote } from '@/graphql/queries';
import { mapGetters } from 'vuex';

export default {
  name: 'CourseNotes',
  props: ['notes', 'courseId'],
  data: () => ({
    title: '',
    content: '',
    editingId: null,
    editingTitle: '',
    editing: '',
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
      this.editing = note.content;
    },
    save(event, note) {
      const updatedNote = {
        id: note.id,
        title: this.editingTitle,
        content: this.editing,
        course_id: note.course_id,
        created_at: note.created_at,
        updated_at: this.$getFormattedDate(),
        user_id: this.currentUser.username,
        fixed: note.fixed,
      };
      const index = this.notes.indexOf(note);
      this.remove({}, note, false);
      this.notes.splice(index, 0, updatedNote);
      this.upsertNote(note);
      this.clear();
    },
    remove(event, note, dl) {
      const index = this.notes.indexOf(note);
      if (index > -1) {
        this.notes.splice(index, 1);
        if (dl) {
          this.dlNote(note);
        }
      }
    },
    addNote() {
      const newNote = {
        id: null,
        title: this.editingTitle,
        content: this.editing,
        fixed: false,
        user_id: this.currentUser.username,
        course_id: this.courseId,
        created_at: this.$getFormattedDate(),
        updated_at: this.$getFormattedDate(),
      };
      this.createNote(newNote);
      this.clear();
    },
    upsertNote(note) {
      this.$gqlClient.query({
        query: this.$gql(upsertNote),
        variables: {
          user_id: this.currentUser.username,
          course_id: note.course_id,
          id: note.id,
          title: note.title,
          content: note.content,
          fixed: note.fixed,
          created_at: note.created_at,
          updated_at: note.updated_at,
        },
      });
    },
    createNote(note) {
      this.$gqlClient
        .query({
          query: this.$gql(createNote),
          fetchPolicy: 'network-only',
          variables: {
            user_id: this.currentUser.username,
            course_id: note.course_id,
            id: note.id,
            title: note.title,
            content: note.content,
            fixed: note.fixed,
            created_at: note.created_at,
            updated_at: note.updated_at,
          },
        })
        .then((response) => {
          const result = JSON.parse(response.data.createNote);
          this.notes.unshift(result);
        });
    },
    dlNote(note) {
      this.$gqlClient.query({
        query: this.$gql(deleteNote),
        variables: {
          id: note.id,
        },
      });
    },
  },
  computed: {
    darkTheme() {
      return this.$vuetify.theme.dark;
    },
    ...mapGetters('auth', ['currentUser']),
  },
};
</script>

<style lang="scss" scoped>
.card-content {
  background-color: #f7f3eb;
  p {
    color: #313639;
  }
}

.note-title {
  color: #313639;
}
</style>
