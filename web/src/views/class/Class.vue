<template>
  <v-container>
    <h1>{{ cl.name }}</h1>
    <v-row class="mt-4">
      <v-col cols="3">
        <v-card class="mb-4 mr-2" max-width="400" height="100%">
          <v-img class="white--text align-end" height="200px" :src="cl.image" />

          <v-list dense>
            <v-list-item v-for="item in items" :key="item.title">
              <v-list-item-icon>
                <v-icon>{{ item.icon }}</v-icon>
              </v-list-item-icon>

              <v-list-item-content>
                <v-btn depressed :to="{ name: item.url }" v-if="item.title == 'Aula'"
                  ><v-chip color="error" class="mr-2" label
                    ><v-icon left> fas fa-satellite-dish </v-icon>{{ item.title }}</v-chip
                  ></v-btn
                >
                <v-btn depressed :to="{ name: item.url }" block v-else>{{ item.title }}</v-btn>
              </v-list-item-content>
            </v-list-item>
          </v-list>
          <v-divider></v-divider>

          <v-card-text class="text--primary">
            <v-row justify="center">
              <div class="my-6">
                de <b>{{ cl.start }}</b> até <b>{{ cl.end }}</b>
              </div>
            </v-row>
          </v-card-text>

          <v-card-actions>
            <v-row justify="center" align="center">
              <v-col cols="8" class="d-flex flex-column">
                <v-btn color="primary" outlined class="mb-4" to="/course/1"> Acessar Curso </v-btn>
                <v-btn color="error" text> Cancelar Matricula </v-btn>
              </v-col>
            </v-row>
          </v-card-actions>
        </v-card>
      </v-col>
      <v-col cols="9">
        <v-sheet height="100%" width="100%" elevation="1">
          <router-view></router-view>
        </v-sheet>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
export default {
  name: 'Class',
  title: 'Turma Programação C# | Find a Tutor',
  data: () => ({
    items: [
      { title: 'Aula', icon: 'far fa-play-circle', url: 'ClassLecture' },
      { title: 'Postagens', icon: 'fas fa-chalkboard', url: 'ClassPosts' },
      { title: 'Calendário', icon: 'far fa-calendar-alt', url: 'ClassCalendar' },
    ],
    cl: {
      id: 1,
      name: 'Programação C#',
      image: 'https://miro.medium.com/max/1000/1*c34daw_rg89UAh4uFCZ96w.jpeg',
      category: 'Tecnologia',
      description:
        'Lorem ipsum dolor sit amet consectetur adipisicing elit. At libero commodi, voluptates voluptas autem maiores quasi rem sapiente ut optio corporis ullam reiciendis, sequi veniam mollitia! Amet tempore saepe eaque!',
      start: '2021-07-21',
      end: '2021-10-22',
    },
  }),
};
</script>
