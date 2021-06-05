<template>
  <v-container>
    <v-data-table
      :headers="headers"
      :items="courses"
      :page.sync="page"
      :items-per-page="itemsPerPage"
      @page-count="pageCount = $event"
      hide-default-footer
      item-key="name"
      class="elevation-1"
      :search="search"
    >
      <template v-slot:top>
        <v-toolbar flat>
          <v-toolbar-title>Cursos</v-toolbar-title>
          <v-divider class="mx-4" inset vertical></v-divider>
          <v-text-field v-model="search" label="Filtrar" class="mx-4"></v-text-field>
          <v-btn
            color="success"
            dark
            class="mb-2"
            :to="{ name: 'DashboardEditCourse', params: { course: newCourse } }"
          >
            Adicionar
          </v-btn>
        </v-toolbar>
      </template>
      <template v-slot:item.edit="{ item }">
        <v-btn color="primary" text :to="{ name: 'DashboardEditCourse', params: { course: item } }"
          >Editar</v-btn
        >
      </template>
      <template v-slot:item.remove="{ item }">
        <v-btn color="error" text @click="remove($event, item)">Remover</v-btn>
      </template>
    </v-data-table>
    <div class="text-center pt-2">
      <v-pagination v-model="page" :length="pageCount"></v-pagination>
      <v-text-field
        :value="itemsPerPage"
        label="Itens por página"
        type="number"
        min="-1"
        max="15"
        @input="itemsPerPage = parseInt($event, 10)"
      ></v-text-field>
    </div>
  </v-container>
</template>

<script>
export default {
  data() {
    return {
      page: 1,
      pageCount: 0,
      itemsPerPage: 10,
      search: '',
      newCourse: {
        id: 0,
        name: '',
        category: '',
        value: 0,
        description: '',
      },
      courses: [
        {
          id: 1,
          name: 'Programação C#',
          category: 'Tecnologia',
          value: 150,
          description:
            'Lorem ipsum dolor, sit amet consectetur adipisicing elit. Temporibus maxime incidunt non neque molestias eligendi? Qui pariatur recusandae et, sit cupiditate iste explicabo consequuntur architecto exercitationem, odit veritatis odio placeat.',
        },
        {
          id: 2,
          name: 'Redes de Computadores',
          category: 'Tecnologia',
          value: 200,
          description:
            'Lorem ipsum dolor, sit amet consectetur adipisicing elit. Temporibus maxime incidunt non neque molestias eligendi? Qui pariatur recusandae et, sit cupiditate iste explicabo consequuntur architecto exercitationem, odit veritatis odio placeat.',
        },
        {
          id: 3,
          name: 'Programação para jogos',
          category: 'Tecnologia',
          value: 350,
          description:
            'Lorem ipsum dolor, sit amet consectetur adipisicing elit. Temporibus maxime incidunt non neque molestias eligendi? Qui pariatur recusandae et, sit cupiditate iste explicabo consequuntur architecto exercitationem, odit veritatis odio placeat.',
        },
        {
          id: 4,
          name: 'Programação para inciantes',
          category: 'Tecnologia',
          value: 100,
          description:
            'Lorem ipsum dolor, sit amet consectetur adipisicing elit. Temporibus maxime incidunt non neque molestias eligendi? Qui pariatur recusandae et, sit cupiditate iste explicabo consequuntur architecto exercitationem, odit veritatis odio placeat.',
        },
        {
          id: 5,
          name: 'Orientação a objetos em C#',
          category: 'Tecnologia',
          value: 80,
          description:
            'Lorem ipsum dolor, sit amet consectetur adipisicing elit. Temporibus maxime incidunt non neque molestias eligendi? Qui pariatur recusandae et, sit cupiditate iste explicabo consequuntur architecto exercitationem, odit veritatis odio placeat.',
        },
        {
          id: 6,
          name: 'Como ficar rico com C#',
          category: 'Tecnologia',
          value: 1000,
          description:
            'Lorem ipsum dolor, sit amet consectetur adipisicing elit. Temporibus maxime incidunt non neque molestias eligendi? Qui pariatur recusandae et, sit cupiditate iste explicabo consequuntur architecto exercitationem, odit veritatis odio placeat.',
        },
        {
          id: 7,
          name: 'Arduino do iniciante ao avançado',
          category: 'Tecnologia',
          value: 250,
          description:
            'Lorem ipsum dolor, sit amet consectetur adipisicing elit. Temporibus maxime incidunt non neque molestias eligendi? Qui pariatur recusandae et, sit cupiditate iste explicabo consequuntur architecto exercitationem, odit veritatis odio placeat.',
        },
        {
          id: 8,
          name: 'Programação C++',
          category: 'Tecnologia',
          value: 175,
          description:
            'Lorem ipsum dolor, sit amet consectetur adipisicing elit. Temporibus maxime incidunt non neque molestias eligendi? Qui pariatur recusandae et, sit cupiditate iste explicabo consequuntur architecto exercitationem, odit veritatis odio placeat.',
        },
      ],
    };
  },
  computed: {
    headers() {
      return [
        {
          text: 'Nome',
          align: 'start',
          value: 'name',
        },
        {
          text: 'Categoria',
          value: 'category',
        },
        { text: 'Valor (R$)', value: 'value', align: 'center' },
        { text: 'Editar', value: 'edit', sortable: false, align: 'center' },
        { text: 'Remover', value: 'remove', sortable: false, align: 'center' },
      ];
    },
  },
  methods: {
    edit(event, item) {
      console.log(event, item);
    },
    remove(event, item) {
      console.log(event, item);
    },
  },
};
</script>
