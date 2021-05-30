<template>
  <v-container>
    <v-row justify="center">
      <v-col cols="6" xl="6" lg="12" md="12" sm="12" class="mt-4">
        <h2 class="mb-6">{{ courseName }}</h2>
        <h3 class="mb-2">Descrição</h3>
        <v-sheet elevation="1" class="pa-6">
          <vue-markdown>{{ courseDescription }}</vue-markdown>
        </v-sheet>
        <h3 class="mt-4">Requisitos</h3>
        <ul>
          <li>Lógica de programação</li>
          <li>Entendimento de conceitos de orientaçõa a objetos</li>
        </ul>
        <h3 class="mt-4">Conteúdos</h3>
        <h3 class="mt-4">Instrutor</h3>
        <h3 class="mt-4">Avaliações</h3>
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
                :value="courseRatingInteger"
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

  title: 'Meu Carrinho | Find a Tutor',

  components: {
    VueMarkdown,
  },

  data: () => ({
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
    courseRatingInteger() {
      return parseFloat(this.courseRating);
    },
  },

  methods: {},
};
</script>
