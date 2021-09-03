<template>
  <v-container>
    <v-row class="d-flex justify-space-between">
      <v-col xl="2" lg="4" md="4" sm="6" xs="12">
        <v-subheader>Fixados</v-subheader>
      </v-col>
      <v-col xl="2" lg="4" md="4" sm="6" xs="12">
        <v-btn color="success" @click="add">Nova anotação</v-btn>
      </v-col>
    </v-row>
    <v-row>
      <v-col xl="2" lg="4" md="4" sm="6" xs="12" v-for="note in fixedNotes" :key="note.id">
        <v-badge bordered color="orange lighten-2" icon="fas fa-thumbtack" overlap>
          <v-card class="mx-auto" min-width="200">
            <v-card-title> {{ note.title }} </v-card-title>

            <v-card-subtitle>
              <p>{{ note.content }}</p>
            </v-card-subtitle>

            <v-card-actions>
              <v-btn color="orange lighten-2" text @click="unfix($event, note)"
                ><v-icon class="mr-2">fas fa-thumbtack</v-icon> Tirar
              </v-btn>
              <v-btn color="primary" text @click="edit($event, note)">Editar </v-btn>
              <v-btn color="error" text> Apagar </v-btn>

              <v-spacer></v-spacer>
            </v-card-actions>
          </v-card>
        </v-badge>
      </v-col>
    </v-row>
    <v-subheader>Outros</v-subheader>
    <v-row>
      <v-col xl="2" lg="4" md="4" sm="6" xs="12" v-for="note in notes" :key="note.id">
        <v-card class="mx-auto" min-width="250">
          <v-card-title> {{ note.title }} </v-card-title>

          <v-card-subtitle>
            <p>{{ note.content }}</p>
          </v-card-subtitle>

          <v-card-actions>
            <v-btn color="orange lighten-2" text @click="fix($event, note)"
              ><v-icon class="mr-2">fas fa-thumbtack</v-icon> Fixar
            </v-btn>
            <v-btn color="primary" text @click="edit($event, note)">Editar </v-btn>
            <v-btn color="error" @click="remove($event, note, true)" text> Apagar </v-btn>

            <v-spacer></v-spacer>
          </v-card-actions>
        </v-card>
      </v-col>
    </v-row>
    <v-overlay :z-index="zIndex" :value="overlay" :dark="$vuetify.theme.dark">
      <v-card class="pa-4" min-width="600px">
        <v-form>
          <v-text-field label="Título" v-model="editingNote.title"></v-text-field>
          <v-textarea
            outlined
            name="input-7-4"
            label="Anotação"
            v-model="editingNote.content"
          ></v-textarea>
          <v-select
            :items="courses"
            item-text="name"
            item-value="id"
            v-model="editingNote.course_id"
            label="Curso"
            dense
            outlined
          ></v-select>
        </v-form>
        <v-btn class="white--text mr-4" color="success" @click="save"> Salvar </v-btn>
        <v-btn class="white--text" color="error" @click="overlay = false"> Fechar </v-btn>
      </v-card>
    </v-overlay>
    <v-overlay :value="loading">
      <v-progress-circular indeterminate size="64"></v-progress-circular>
    </v-overlay>
  </v-container>
</template>

<script>
import { mapGetters } from 'vuex';
import { myNotes, upsertNote, deleteNote, createNote, myCourses } from '@/graphql/queries';

export default {
  name: 'Notes',
  title: 'Minhas Anotações | Find a Tutor',
  data: () => ({
    overlay: false,
    zIndex: 2,
    courses: [],
    fixedNotes: [],
    editingNote: {},
    notes: [],
    loading: true,
  }),
  methods: {
    add() {
      const newNote = {
        content: '',
        course_id: null,
        created_at: this.$getFormattedDate(),
        fixed: false,
        id: 0,
        title: '',
        updated_at: this.$getFormattedDate(),
        user_id: this.currentUser.username,
      };
      this.editingNote = newNote;
      this.overlay = true;
    },
    edit(event, note) {
      this.editingNote = note;
      this.overlay = true;
    },
    fix(event, note) {
      // eslint-disable-next-line no-param-reassign
      note.fixed = true;
      const index = this.notes.indexOf(note);
      if (index > -1) {
        this.notes.splice(index, 1);
      }
      this.fixedNotes.push(note);
      this.upsertNote(note);
    },
    unfix(event, note) {
      // eslint-disable-next-line no-param-reassign
      note.fixed = false;
      const index = this.fixedNotes.indexOf(note);
      if (index > -1) {
        this.fixedNotes.splice(index, 1);
      }
      this.notes.push(note);
      this.upsertNote(note);
    },
    myNotes() {
      this.$gqlClient
        .query({
          query: this.$gql(myNotes),
          fetchPolicy: 'network-only',
          variables: { user_id: this.currentUser.username },
        })
        .then((response) => {
          const result = JSON.parse(response.data.myNotes);
          result.forEach((note) => {
            if (note.fixed === true) {
              this.fixedNotes.push(note);
            } else {
              this.notes.push(note);
            }
          });
          this.loading = false;
        });
    },
    myCourses() {
      this.$gqlClient
        .query({
          query: this.$gql(myCourses),
          fetchPolicy: 'network-only',
          variables: { id: this.currentUser.username },
        })
        .then((response) => {
          const courses = JSON.parse(response.data.myCourses);
          this.courses = courses;
          this.courses.push({
            name: 'Nenhum',
            id: null,
          });
        });
    },
    updateNote() {
      const updatedNote = {
        id: this.editingNote.id,
        title: this.editingNote.title,
        content: this.editingNote.content,
        course_id: this.editingNote.course_id,
        created_at: this.editingNote.created_at,
        updated_at: this.editingNote.updated_at,
        user_id: this.currentUser.username,
        fixed: this.editingNote.fixed,
      };
      this.upsertNote(updatedNote);
    },
    save() {
      if (this.editingNote.id === 0) {
        this.addNote();
      } else {
        this.updateNote();
      }
      this.overlay = false;
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
        title: this.editingNote.title,
        content: this.editingNote.content,
        fixed: false,
        user_id: this.currentUser.username,
        course_id: this.editingNote.course_id,
        created_at: this.$getFormattedDate(),
        updated_at: this.$getFormattedDate(),
      };
      this.createNote(newNote);
      this.overlay = false;
    },
    upsertNote(note) {
      this.$gqlClient.query({
        query: this.$gql(upsertNote),
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
    ...mapGetters('auth', ['currentUser']),
  },
  created() {
    this.myNotes();
    this.myCourses();
  },
};
</script>
