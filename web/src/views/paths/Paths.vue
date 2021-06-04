<template>
  <v-container>
    <v-row>
      <v-col cols="3" lg="3" md="6">
        <v-sheet elevation="1" width="100%" class="mb-4">
          <v-subheader color="primary">Salvos</v-subheader>
          <v-list-item v-for="bookmark in bookmarks" :key="bookmark.name">
            <v-list-item-content>
              <v-list-item-title
                ><v-icon @click="removeBookmark($event, bookmark)" class="mr-2"
                  >fas fa-bookmark </v-icon
                ><v-btn :to="bookmark.path"> {{ bookmark.name }}</v-btn></v-list-item-title
              >
            </v-list-item-content>
          </v-list-item>
        </v-sheet>
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
            <v-subheader color="primary">Ordenar por</v-subheader>
            <v-radio-group v-model="orderBy">
              <v-radio label="Avaliação" value="ratings"></v-radio>
              <v-radio label="Quantidade de avaliações" value="reviews"></v-radio>
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
          </v-container>
        </v-sheet>
      </v-col>
      <v-col cols="9" lg="9" md="6">
        <v-row justify="space-around">
          <v-col cols="12" lg="4" md="12" v-for="n in 9" :key="n">
            <PathCard
              pathName="Programação C#"
              pathImage="https://miro.medium.com/max/1000/1*c34daw_rg89UAh4uFCZ96w.jpeg"
              pathRating="4.5"
              pathReviews="413"
              pathDescription="Lorem ipsum dolor sit amet, consectetur adipisicing elit. Repellat nemo inventore dolor fugiat exercitationem sint expedita facilis ea itaque, illum, doloremque praesentium autem similique quis placeat id maxime sunt nulla!"
              pathId="1"
            />
          </v-col>
        </v-row>
      </v-col>
    </v-row>
    <div class="text-center my-10">
      <v-pagination v-model="page" length="4" circle></v-pagination>
    </div>
  </v-container>
</template>

<script>
import PathCard from '@/components/PathCard.vue';

export default {
  name: 'Paths',

  title: 'Trilhas | Find a Tutor',

  components: {
    PathCard,
  },

  data: () => ({
    bookmarks: [
      {
        name: 'Programação de Zero a Hero',
        path: '/path',
      },
    ],
    page: 1,
    keywords: ['Programação', 'Python', 'Jogos', 'Música'],
    selectedKeywords: [],
    search: null,
    ratings: ['1', '', '2', '', '3', '', '4', '', '5'],
    orderBy: ['ratings'],
    price: [],
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

  methods: {
    removeBookmark(event, item) {
      const index = this.bookmarks.indexOf(item);
      if (index > -1) {
        this.bookmarks.splice(index, 1);
      }
    },
  },
};
</script>
