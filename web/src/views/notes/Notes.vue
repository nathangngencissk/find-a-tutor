<template>
  <v-container>
    <v-subheader>Fixados</v-subheader>
    <v-row>
      <v-col xl="2" lg="4" md="4" sm="6" xs="12" v-for="note in fixedNotes" :key="note.id">
        <v-badge bordered color="orange lighten-2" icon="fas fa-thumbtack" overlap>
          <v-card class="mx-auto" min-width="250">
            <v-card-title> {{ note.title }} </v-card-title>

            <v-card-subtitle>
              <p>{{ note.body }}</p>
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
            <p>{{ note.body }}</p>
          </v-card-subtitle>

          <v-card-actions>
            <v-btn color="orange lighten-2" text @click="fix($event, note)"
              ><v-icon class="mr-2">fas fa-thumbtack</v-icon> Fixar
            </v-btn>
            <v-btn color="primary" text @click="edit($event, note)">Editar </v-btn>
            <v-btn color="error" text> Apagar </v-btn>

            <v-spacer></v-spacer>
          </v-card-actions>
        </v-card>
      </v-col>
    </v-row>
    <v-overlay :z-index="zIndex" :value="overlay" :dark="$vuetify.theme.dark">
      <v-card class="pa-4" min-width="600px">
        <v-form>
          <v-text-field label="Título" :value="title"></v-text-field>
          <v-textarea outlined name="input-7-4" label="Anotação" :value="body"></v-textarea>
          <v-select :items="courses" label="Curso" dense outlined></v-select>
        </v-form>
        <v-btn class="white--text mr-4" color="success" @click="overlay = false"> Salvar </v-btn>
        <v-btn class="white--text" color="error" @click="overlay = false"> Fechar </v-btn>
      </v-card>
    </v-overlay>
  </v-container>
</template>

<script>
export default {
  name: 'Notes',
  title: 'Minhas Anotações | Find a Tutor',
  data: () => ({
    overlay: false,
    zIndex: 0,
    title: '',
    body: '',
    courseId: '',
    courses: ['Programação C#'],
    fixedNotes: [
      {
        id: 1,
        title: 'Titulo Nota 1',
        body: 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Laboriosam beatae amet nesciunt natus sit quaerat, odit vero ipsam rem quas delectus, quasi ea! Adipisci nobis hic ullam sapiente iure earum!',
        courseId: 4,
      },
      {
        id: 2,
        title: 'Titulo Nota 2',
        body: 'Corpo Nota 2',
        courseId: null,
      },
    ],
    notes: [
      {
        id: 3,
        title: 'Titulo Nota 3',
        body: 'Corpo Nota 3',
        courseId: null,
      },
      {
        id: 4,
        title: 'Titulo Nota 4',
        body: 'Corpo Nota 4',
        courseId: null,
      },
      {
        id: 5,
        title: 'Titulo Nota 5',
        body: 'Corpo Nota 5',
        courseId: null,
      },
    ],
  }),
  methods: {
    edit(event, note) {
      this.title = note.title;
      this.body = note.body;
      this.courseId = note.courseId;
      this.overlay = true;
    },
    fix(event, note) {
      const index = this.notes.indexOf(note);
      if (index > -1) {
        this.notes.splice(index, 1);
      }
      this.fixedNotes.push(note);
    },
    unfix(event, note) {
      const index = this.fixedNotes.indexOf(note);
      if (index > -1) {
        this.fixedNotes.splice(index, 1);
      }
      this.notes.push(note);
    },
  },
};
</script>
