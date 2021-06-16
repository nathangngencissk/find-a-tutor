<template>
  <v-container>
    <v-subheader color="primary" class="mt-4 mb-2"
      >Resultados de busca para: {{ this.searchText }}</v-subheader
    >
    <v-row>
      <v-col xl="3" lg="4" cols="12">
        <v-sheet elevation="1" width="100%">
          <v-container>
            <v-subheader color="primary">Palavras-chave</v-subheader>
            <v-combobox
              v-model="selectedKeywords"
              :items="keywords"
              :search-input.sync="search"
              hide-selected
              multiple
              small-chips
              class="mx-2"
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
            <v-subheader color="primary">Categorias</v-subheader>
            <v-list>
              <v-list-group
                v-for="item in items"
                :key="item.title"
                v-model="item.active"
                :prepend-icon="item.action"
                no-action
              >
                <template v-slot:activator>
                  <v-list-item-content>
                    <v-list-item-title v-text="item.title"></v-list-item-title>
                  </v-list-item-content>
                </template>

                <v-list-item v-for="child in item.items" :key="child.title">
                  <v-list-item-content>
                    <v-list-item-title v-text="child.title"></v-list-item-title>
                  </v-list-item-content>
                </v-list-item>
              </v-list-group>
            </v-list>
            <v-divider></v-divider>
            <v-subheader color="primary">Ordenar por</v-subheader>
            <v-radio-group v-model="orderBy">
              <v-radio label="Avaliação" value="ratings"></v-radio>
              <v-radio label="Quantidade de avaliações" value="reviews"></v-radio>
              <v-radio label="Preço" value="price"></v-radio>
            </v-radio-group>
            <v-divider></v-divider>
            <v-subheader color="primary">Avaliação</v-subheader>
            <v-range-slider
              class="mx-5 my-5"
              step="0.5"
              max="5"
              min="1"
              :value="[1, 5]"
              :tick-labels="ratings"
            ></v-range-slider>
            <v-divider></v-divider>
            <v-subheader color="primary">Preço</v-subheader>
            <v-checkbox
              class="my-0"
              v-model="price"
              label="100-200"
              value="[100, 200]"
            ></v-checkbox>
            <v-checkbox class="my-0" v-model="price" label=">300" value="[300, 0]"></v-checkbox>
            <v-divider></v-divider>
            <v-subheader color="primary">Idioma</v-subheader>
            <v-checkbox
              class="my-0"
              v-model="language"
              label="Português"
              value="pt-br"
            ></v-checkbox>
            <v-checkbox class="my-0" v-model="language" label="Inglês" value="en"></v-checkbox>
          </v-container>
        </v-sheet>
      </v-col>
      <v-col xl="9" lg="8" cols="12">
        <v-row justify="space-around">
          <v-col xl="3" lg="6" md="6" cols="12" v-for="n in 9" :key="n">
            <CourseCardFull
              courseName="Programação C#"
              courseImage="https://cdn.vuetifyjs.com/images/cards/docks.jpg"
              courseRating="4.5"
              courseReviews="413"
              courseCategory="Tecnologia"
              courseDescription="Lorem ipsum dolor sit amet, consectetur adipisicing elit. Repellat nemo inventore dolor fugiat exercitationem sint expedita facilis ea itaque, illum, doloremque praesentium autem similique quis placeat id maxime sunt nulla!"
              courseId="2"
              courseLanguage="pt-br"
              courseCost="150"
            />
          </v-col>
        </v-row>
      </v-col>
    </v-row>
    <div class="text-center my-10">
      <v-pagination v-model="page" :length="4" circle></v-pagination>
    </div>
  </v-container>
</template>

<script>
import CourseCardFull from '@/components/CourseCardFull.vue';

export default {
  name: 'StudyingCourses',

  title: 'Busca | Find a Tutor',

  components: {
    CourseCardFull,
  },

  data: () => ({
    page: 1,
    keywords: ['Programação', 'Python', 'Jogos', 'Música'],
    selectedKeywords: [],
    search: null,
    ratings: ['1', '', '2', '', '3', '', '4', '', '5'],
    orderBy: ['ratings'],
    price: [],
    language: [],
    items: [
      {
        action: 'mdi-ticket',
        items: [{ title: 'List Item' }],
        title: 'Attractions',
      },
      {
        action: 'mdi-silverware-fork-knife',
        active: true,
        items: [{ title: 'Breakfast & brunch' }, { title: 'New American' }, { title: 'Sushi' }],
        title: 'Dining',
      },
      {
        action: 'mdi-school',
        items: [{ title: 'List Item' }],
        title: 'Education',
      },
      {
        action: 'mdi-run',
        items: [{ title: 'List Item' }],
        title: 'Family',
      },
      {
        action: 'mdi-bottle-tonic-plus',
        items: [{ title: 'List Item' }],
        title: 'Health',
      },
      {
        action: 'mdi-content-cut',
        items: [{ title: 'List Item' }],
        title: 'Office',
      },
      {
        action: 'mdi-tag',
        items: [{ title: 'List Item' }],
        title: 'Promotions',
      },
    ],
  }),

  props: ['searchText'],

  methods: {},
};
</script>
