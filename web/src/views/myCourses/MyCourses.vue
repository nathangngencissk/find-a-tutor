<template>
  <v-container>
    <v-row>
      <v-col cols="3" lg="3" md="6">
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
      <v-col cols="9" lg="9" md="6">
        <v-row justify="start">
          <v-col cols="12" lg="4" md="12" v-for="course in courses" :key="course.id">
            <CourseCardFull
              :courseName="course.name"
              :courseImage="course.image"
              :courseRating="course.rating"
              :courseReviews="course.reviews"
              :courseCategory="course.category"
              :courseDescription="course.description"
              :courseId="course.id"
              courseLanguage="pt-br"
              :courseCost="course.value"
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
  name: 'MyCourses',

  title: 'Meus Cursos | Find a Tutor',

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
    courses: [
      {
        id: 1,
        name: 'Programação C#',
        description:
          'Lorem ipsum dolor sit amet consectetur, adipisicing elit. Quibusdam autem, nulla ut pariatur atque, voluptates amet accusamus temporibus totam dignissimos eius quasi ips a veritatis repudiandae eaque, eum fuga facere rerum.',
        value: '150',
        rating: 4.5,
        reviews: 413,
        image:
          'https://images.unsplash.com/photo-1571171637578-41bc2dd41cd2?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80',
      },
      {
        id: 1,
        name: 'Programação Básica',
        description:
          'Lorem ipsum dolor sit amet consectetur, adipisicing elit. Quibusdam autem, nulla ut pariatur atque, voluptates amet accusamus temporibus totam dignissimos eius quasi ips a veritatis repudiandae eaque, eum fuga facere rerum.',
        value: '120',
        rating: 4.6,
        reviews: 22,
        image:
          'https://images.unsplash.com/photo-1542831371-29b0f74f9713?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1050&q=80',
      },
      {
        id: 1,
        name: 'Redes de computadores',
        description:
          'Lorem ipsum dolor sit amet consectetur, adipisicing elit. Quibusdam autem, nulla ut pariatur atque, voluptates amet accusamus temporibus totam dignissimos eius quasi ips a veritatis repudiandae eaque, eum fuga facere rerum.',
        value: '200',
        rating: 4.8,
        reviews: 111,
        image:
          'https://images.unsplash.com/photo-1597733336794-12d05021d510?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=967&q=80',
      },
      {
        id: 1,
        name: 'Matemática financeira',
        description:
          'Lorem ipsum dolor sit amet consectetur, adipisicing elit. Quibusdam autem, nulla ut pariatur atque, voluptates amet accusamus temporibus totam dignissimos eius quasi ips a veritatis repudiandae eaque, eum fuga facere rerum.',
        value: '180',
        rating: 4.4,
        reviews: 98,
        image:
          'https://images.unsplash.com/photo-1511377107391-116a9d5d20b5?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80',
      },
      {
        id: 1,
        name: 'Arduino do básico ao avançado',
        description:
          'Lorem ipsum dolor sit amet consectetur, adipisicing elit. Quibusdam autem, nulla ut pariatur atque, voluptates amet accusamus temporibus totam dignissimos eius quasi ips a veritatis repudiandae eaque, eum fuga facere rerum.',
        value: '250',
        rating: 4.9,
        reviews: 42,
        image:
          'https://images.unsplash.com/photo-1557855506-3619a44bab73?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=701&q=80',
      },
    ],
  }),

  methods: {},
};
</script>
