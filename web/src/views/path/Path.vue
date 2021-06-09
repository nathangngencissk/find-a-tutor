<template>
  <v-container>
    <v-row justify="center">
      <v-col xl="6" lg="6" md="6" sm="12" xs="12">
        <v-stepper v-model="e6" vertical>
          <v-stepper-step :complete="e6 > 1" step="1" @click="e6 = 1" class="stepper-clickable">
            Lógica de programação
          </v-stepper-step>

          <v-stepper-content step="1">
            <CourseCardFull
              courseName="Programação C#"
              courseImage="https://cdn.vuetifyjs.com/images/cards/docks.jpg"
              courseRating="4.5"
              courseReviews="413"
              courseCategory="Tecnologia"
              courseDescription="Lorem ipsum dolor sit amet, consectetur adipisicing elit. Repellat nemo inventore dolor fugiat exercitationem sint expedita facilis ea itaque, illum, doloremque praesentium autem similique quis placeat id maxime sunt nulla!"
              courseId="1"
              courseLanguage="pt-br"
              courseCost="150"
            />
            <v-btn color="primary" @click="e6 = 2"> Continuar </v-btn>
            <v-btn text> Cancelar </v-btn>
          </v-stepper-content>

          <v-stepper-step :complete="e6 > 2" step="2" @click="e6 = 2" class="stepper-clickable">
            Condicionais
          </v-stepper-step>

          <v-stepper-content step="2" justify="center">
            <CourseCardFull
              courseName="Programação C#"
              courseImage="https://cdn.vuetifyjs.com/images/cards/docks.jpg"
              courseRating="4.5"
              courseReviews="413"
              courseCategory="Tecnologia"
              courseDescription="Lorem ipsum dolor sit amet, consectetur adipisicing elit. Repellat nemo inventore dolor fugiat exercitationem sint expedita facilis ea itaque, illum, doloremque praesentium autem similique quis placeat id maxime sunt nulla!"
              courseId="1"
              courseLanguage="pt-br"
              courseCost="150"
              class="mx-0"
            />
            <v-btn color="primary" @click="e6 = 3"> Continuar </v-btn>
            <v-btn text> Cancelar </v-btn>
          </v-stepper-content>

          <v-stepper-step :complete="e6 > 3" step="3" @click="e6 = 3" class="stepper-clickable">
            Loops
          </v-stepper-step>

          <v-stepper-content step="3">
            <CourseCardFull
              courseName="Programação C#"
              courseImage="https://cdn.vuetifyjs.com/images/cards/docks.jpg"
              courseRating="4.5"
              courseReviews="413"
              courseCategory="Tecnologia"
              courseDescription="Lorem ipsum dolor sit amet, consectetur adipisicing elit. Repellat nemo inventore dolor fugiat exercitationem sint expedita facilis ea itaque, illum, doloremque praesentium autem similique quis placeat id maxime sunt nulla!"
              courseId="1"
              courseLanguage="pt-br"
              courseCost="150"
            />
            <v-btn color="primary" @click="e6 = 4"> Continuar </v-btn>
            <v-btn text> Cancelar </v-btn>
          </v-stepper-content>

          <v-stepper-step step="4" @click="e6 = 4" class="stepper-clickable"> OOP </v-stepper-step>
          <v-stepper-content step="4">
            <CourseCardFull
              courseName="Programação C#"
              courseImage="https://cdn.vuetifyjs.com/images/cards/docks.jpg"
              courseRating="4.5"
              courseReviews="413"
              courseCategory="Tecnologia"
              courseDescription="Lorem ipsum dolor sit amet, consectetur adipisicing elit. Repellat nemo inventore dolor fugiat exercitationem sint expedita facilis ea itaque, illum, doloremque praesentium autem similique quis placeat id maxime sunt nulla!"
              courseId="1"
              courseLanguage="pt-br"
              courseCost="150"
            />
          </v-stepper-content>
        </v-stepper>
      </v-col>
      <v-col xl="6" lg="6" md="6" sm="12" xs="12">
        <v-card width="400">
          <v-img
            height="200px"
            src="https://miro.medium.com/max/1000/1*c34daw_rg89UAh4uFCZ96w.jpeg"
          >
          </v-img>

          <v-card-text class="text--primary">
            <v-row align="center" class="mx-0 my-2">
              <v-card-title> Programação de Zero a Hero </v-card-title>

              <v-rating
                v-model="pathRatingInteger"
                color="amber"
                dense
                half-increments
                readonly
                size="14"
              ></v-rating>

              <div class="grey--text ml-2 mr-4">{{ pathRating }} ({{ pathReviews }})</div>
              <v-btn class="my-4" color="primary" text @click="saved = !saved">
                <v-icon class="mr-2">{{ bookmarkIcon }} </v-icon> {{ bookmarkText }}
              </v-btn>
            </v-row>

            <div>
              {{ pathDescription }}
            </div>
            <v-avatar size="56" class="mt-10">
              <img
                alt="user"
                src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTohhzqvuj_Z-Erq0V3pDbboZq1Xvy5zYS4UA&usqp=CAU"
              />
            </v-avatar>
            <p class="my-2">Gustavo Gambit</p>
          </v-card-text>
        </v-card>
        <v-card width="400" class="mt-4">
          <v-card-text class="text--primary">
            <v-subheader>Deixe sua avaliação</v-subheader>
            <v-rating
              class="mb-4"
              v-model="rating"
              background-color="orange lighten-3"
              color="orange"
              half-increments
              large
            ></v-rating>
          </v-card-text>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import CourseCardFull from '@/components/CourseCardFull.vue';

export default {
  name: 'Path',

  title: 'Programação Zero to Hero | Find a Tutor',

  components: {
    CourseCardFull,
  },

  data: () => ({
    e6: 1,
    saved: false,
    pathRating: '4.5',
    pathReviews: '49',
    pathDescription:
      'Lorem ipsum, dolor sit amet consectetur adipisicing elit. Odit dolore eligendi magni, pariatur, earum repudiandae possimus quos expedita totam error nemo neque eum officiis dicta voluptatibus doloribus nihil et aperiam.',
  }),

  computed: {
    pathRatingInteger() {
      return parseFloat(this.pathRating);
    },
    bookmarkIcon() {
      if (this.saved) {
        return 'fas fa-bookmark';
      }
      return 'far fa-bookmark';
    },
    bookmarkText() {
      if (this.saved) {
        return 'Remover';
      }
      return 'Salvar';
    },
  },

  methods: {},
};
</script>

<style lang="css" scoped>
.stepper-clickable :hover {
  cursor: pointer;
}
</style>
