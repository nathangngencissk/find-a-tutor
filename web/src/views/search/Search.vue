<template>
  <v-container>
    <v-subheader color="primary" class="mt-4 mb-2"
      >Resultados de busca para: {{ this.searchText }}</v-subheader
    >
    <v-row>
      <v-col cols="3" md="6">
        <v-sheet elevation="1" width="100%">
          <v-container>
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
            <v-checkbox v-model="orderBy" label="John" value="John"></v-checkbox>
            <v-checkbox v-model="orderBy" label="Jacob" value="Jacob"></v-checkbox>
            <v-divider></v-divider>
            <v-subheader color="primary">Avaliação</v-subheader>
            <v-range-slider
              class="mx-5"
              step="0.5"
              max="5"
              min="1"
              :value="[1, 5]"
              :tick-labels="ratings"
            ></v-range-slider>
            <v-divider></v-divider>
            <v-subheader color="primary">Preço</v-subheader>
            <v-checkbox v-model="price" label="John" value="John"></v-checkbox>
            <v-checkbox v-model="price" label="Jacob" value="Jacob"></v-checkbox>
            <v-divider></v-divider>
            <v-subheader color="primary">Idioma</v-subheader>
            <v-checkbox v-model="language" label="John" value="John"></v-checkbox>
            <v-checkbox v-model="language" label="Jacob" value="Jacob"></v-checkbox>
          </v-container>
        </v-sheet>
      </v-col>
      <v-col cols="9" md="6">
        <v-row justify="space-around">
          <v-col cols="4" md="6" sm="12" v-for="n in 9" :key="n">
            <CourseCardFull
              courseName="Programação C#"
              courseImage="https://cdn.vuetifyjs.com/images/cards/docks.jpg"
              courseRating="4.5"
              courseReviews="413"
              :courseCategory="searchText"
              courseDescription="Lorem ipsum dolor sit amet, consectetur adipisicing elit. Repellat nemo inventore dolor fugiat exercitationem sint expedita facilis ea itaque, illum, doloremque praesentium autem similique quis placeat id maxime sunt nulla!"
              courseId="1"
              courseLanguage="pt-br"
              courseCost="150"
            />
          </v-col>
        </v-row>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import CourseCardFull from '@/components/CourseCardFull.vue';

export default {
  name: 'StudyingCourses',

  title: 'Search | Find a Tutor',

  components: {
    CourseCardFull,
  },

  data: () => ({
    ratings: ['1', '', '2', '', '3', '', '4', '', '5'],
    orderBy: ['John'],
    price: ['John'],
    language: ['John'],
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
