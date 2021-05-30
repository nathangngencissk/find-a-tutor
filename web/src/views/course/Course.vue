<template>
  <v-container>
    <v-row justify="center">
      <v-col cols="6" xl="6" lg="12" md="12" sm="12" class="mt-4">
        <h2 class="mb-6">{{ courseName }}</h2>
        <h3 class="mb-2">Descrição</h3>
        <v-sheet elevation="1" class="pa-6">
          <vue-markdown>{{ courseDescription }}</vue-markdown>
        </v-sheet>
        <h3 class="mt-4">Turmas disponíveis em breve</h3>
        <v-subheader> 20/07 </v-subheader>
        <v-chip-group column>
          <v-chip v-for="c in classes" :key="c">
            {{ c }}
          </v-chip>
        </v-chip-group>
        <v-subheader> 14/08 </v-subheader>
        <v-chip-group column>
          <v-chip v-for="c in classes" :key="c">
            {{ c }}
          </v-chip>
        </v-chip-group>
        <h3 class="mt-4">Requisitos</h3>
        <ul>
          <li>Lógica de programação</li>
          <li>Entendimento de conceitos de orientaçõa a objetos</li>
        </ul>
        <h3 class="my-4">Conteúdos</h3>
        <v-expansion-panels popout>
          <v-expansion-panel v-for="(item, i) in 11" :key="i">
            <v-expansion-panel-header> Aula {{ i }} </v-expansion-panel-header>
            <v-expansion-panel-content>
              <p>
                Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor
                incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud
                exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
              </p>
            </v-expansion-panel-content>
          </v-expansion-panel>
        </v-expansion-panels>
        <h3 class="my-4">Tutor</h3>
        <v-card>
          <v-row justify="center" align="center">
            <v-col cols="3">
              <v-avatar width="150" height="150">
                <img
                  src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTohhzqvuj_Z-Erq0V3pDbboZq1Xvy5zYS4UA&usqp=CAU"
                  alt="Gustavo"
                />
              </v-avatar>
            </v-col>
            <v-col cols="8">
              <h4 class="mb-4">Gustavo Gambit</h4>
              <ul>
                <li>Número de cursos na plataforma: 8</li>
                <li>Média de avaliações: 4.7</li>
                <li>Membro desde Maio/2021</li>
              </ul>
            </v-col>
          </v-row>
        </v-card>
        <h3 class="mt-8">Avaliações</h3>
        <v-row justify="center" align="center">
          <v-col cols="5">
            <v-rating
              v-model="courseRatingFloat"
              background-color="indigo lighten-3"
              color="indigo"
              half-increments
              size="40"
            ></v-rating>
          </v-col>
          <v-col cols="1">
            <span id="course-rating-average-subtitle" class="indigo--text">4.5</span>
          </v-col>
        </v-row>
        <v-row justify="center" align="center">
          <v-col cols="2">
            <v-rating
              value="5"
              background-color="indigo lighten-3"
              color="indigo"
              half-increments
              size="10"
            ></v-rating>
          </v-col>
          <v-col cols="10">
            <v-progress-linear value="70"></v-progress-linear>
          </v-col>
        </v-row>
        <v-row justify="center" align="center">
          <v-col cols="2">
            <v-rating
              value="4"
              background-color="indigo lighten-3"
              color="indigo"
              half-increments
              size="10"
            ></v-rating>
          </v-col>
          <v-col cols="10">
            <v-progress-linear value="20"></v-progress-linear>
          </v-col>
        </v-row>
        <v-row justify="center" align="center">
          <v-col cols="2">
            <v-rating
              value="3"
              background-color="indigo lighten-3"
              color="indigo"
              half-increments
              size="10"
            ></v-rating>
          </v-col>
          <v-col cols="10">
            <v-progress-linear value="6"></v-progress-linear>
          </v-col>
        </v-row>
        <v-row justify="center" align="center">
          <v-col cols="2">
            <v-rating
              value="2"
              background-color="indigo lighten-3"
              color="indigo"
              half-increments
              size="10"
            ></v-rating>
          </v-col>
          <v-col cols="10">
            <v-progress-linear value="3"></v-progress-linear>
          </v-col>
        </v-row>
        <v-row justify="center" align="center">
          <v-col cols="2">
            <v-rating
              value="1"
              background-color="indigo lighten-3"
              color="indigo"
              half-increments
              size="10"
            ></v-rating>
          </v-col>
          <v-col cols="10">
            <v-progress-linear value="1"></v-progress-linear>
          </v-col>
        </v-row>
        <h3 class="mt-8">Comentários</h3>
        <v-row justify="center" align="center" class="mt-1">
          <v-col cols="2">
            <v-avatar width="75" height="75" class="ml-4" color="red">
              <span class="white--text headline">CJ</span>
            </v-avatar>
            <v-subheader class="mx-auto">Carlos Jonas</v-subheader>
          </v-col>
          <v-col cols="8">
            <p class="headline">
              <v-rating
                value="4.5"
                color="yellow darken-3"
                background-color="grey darken-1"
                empty-icon="$ratingFull"
                half-increments
                hover
                size="10"
              ></v-rating>
            </p>
            <p class="body-2">
              Lorem ipsum dolor sit amet consectetur adipisicing elit. Fuga enim animi quaerat iusto
              ad repudiandae iure in adipisci dignissimos cum facere suscipit velit, quis
              reprehenderit rem voluptas ipsam cumque ipsum.
            </p>
          </v-col>
        </v-row>
        <v-divider></v-divider>
        <v-row justify="center" align="center" class="mt-1">
          <v-col cols="2">
            <v-avatar width="75" height="75" class="ml-4">
              <img src="https://cdn.vuetifyjs.com/images/john.jpg" alt="John" />
            </v-avatar>
            <v-subheader class="mx-auto">João Flores</v-subheader>
          </v-col>
          <v-col cols="8">
            <p class="headline">
              <v-rating
                value="5"
                color="yellow darken-3"
                background-color="grey darken-1"
                empty-icon="$ratingFull"
                half-increments
                hover
                size="10"
              ></v-rating>
            </p>
            <p class="body-2">
              Lorem ipsum dolor sit amet consectetur adipisicing elit. Fuga enim animi quaerat iusto
              ad repudiandae iure in adipisci dignissimos cum facere suscipit velit, quis
              reprehenderit rem voluptas ipsam cumque ipsum.
            </p>
          </v-col>
        </v-row>
        <div class="my-2">
          <v-btn large color="primary" outlined block> Ver mais comentários </v-btn>
        </div>
      </v-col>
      <v-col cols="3" lg="3" md="6" sm="12">
        <v-card width="400">
          <v-img height="200px" :src="courseImage" />

          <v-card-text class="text--primary">
            <h1>R${{ courseCost }},00</h1>
            <div class="my-6">
              <v-btn x-large color="success" block> Adicionar ao Carrinho </v-btn>
            </div>
            <v-row align="center" class="mx-0 my-2">
              <v-rating
                :value="courseRatingFloat"
                color="amber"
                dense
                half-increments
                readonly
                size="14"
              ></v-rating>

              <div class="grey--text ml-2 mr-4">{{ courseRating }} ({{ courseReviews }})</div>
            </v-row>
            <div>
              {{ courseShortDescription }}
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
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import VueMarkdown from '@adapttive/vue-markdown';

export default {
  name: 'Course',

  title: 'Programação C# | Find a Tutor',

  components: {
    VueMarkdown,
  },

  data: () => ({
    classes: [
      'Segunda-feira 5:30PM',
      'Segunda-feira 7:30PM',
      'Quinta-feira 8:00PM',
      'Domingo 9:00PM',
    ],
    courseName: 'Programação C#',
    courseImage: 'https://cdn.vuetifyjs.com/images/cards/docks.jpg',
    courseRating: '4.5',
    courseReviews: '413',
    courseCategory: 'Tecnologia',
    courseShortDescription:
      'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Repellat nemo inventore dolor fugiat exercitationem sint expedita facilis ea itaque, illum, doloremque praesentium autem similique quis placeat id maxime sunt nulla! ',
    courseDescription: `# h1 Heading 8-)
<h2> h2 Heading by HTML</h2>
## h2 Heading
### h3 Heading

## Horizontal Rules

___

---

***

## Typographic replacements

Enable typographer option to see result.

(c) (C) (r) (R) (tm) (TM) (p) (P) +-

test.. test... test..... test?..... test!....

!!!!!! ???? ,,  -- ---

"Smartypants, double quotes" and 'single quotes'


## Emphasis

**This is bold text**

__This is bold text__

*This is italic text*

_This is italic text_

~~Strikethrough~~


## Blockquotes


> Blockquotes can also be nested...
>> ...by using additional greater-than signs right next to each other...
> > > ...or with spaces between arrows.`,
    courseId: '1',
    courseLanguage: 'pt-br',
    courseCost: '150',
  }),

  computed: {
    flagLanguage() {
      return `@/assets/flags/${this.courseLanguage}.png`;
    },
    courseRatingFloat() {
      return parseFloat(this.courseRating);
    },
  },

  methods: {},
};
</script>

<style lang="scss" scoped>
#course-rating-average-subtitle {
  font-size: 3rem;
}
</style>
