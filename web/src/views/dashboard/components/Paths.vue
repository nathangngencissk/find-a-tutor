<template>
  <v-container>
    <v-row justify="center">
      <v-col cols="10">
        <v-data-table
          :headers="headers"
          :items="paths"
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
              <v-toolbar-title>Trilhas de aprendizagem</v-toolbar-title>
              <v-divider class="mx-4" inset vertical></v-divider>
              <v-text-field v-model="search" label="Filtrar" class="mx-4"></v-text-field>
              <v-btn
                color="success"
                dark
                class="mb-2"
                :to="{ name: 'DashboardEditPath', params: { path: newPath } }"
              >
                Adicionar
              </v-btn>
            </v-toolbar>
          </template>
          <template v-slot:item.edit="{ item }">
            <v-btn color="primary" text :to="{ name: 'DashboardEditPath', params: { path: item } }"
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
      </v-col>
    </v-row>
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
      newPath: {
        id: 0,
        name: '',
        rating: 0,
        reviews: 0,
        description: '',
        sections: [],
      },
      paths: [
        {
          id: 1,
          name: 'Programação C#',
          rating: 4.5,
          reviews: 49,
          image: 'https://miro.medium.com/max/1000/1*c34daw_rg89UAh4uFCZ96w.jpeg',
          description:
            'Lorem ipsum, dolor sit amet consectetur adipisicing elit. Odit dolore eligendi magni, pariatur, earum repudiandae possimus quos expedita totam error nemo neque eum officiis dicta voluptatibus doloribus nihil et aperiam.',
          sections: [
            {
              id: 1,
              name: 'Lógica de programação',
              course: 1,
            },
            {
              id: 2,
              name: 'Condicionais',
              course: 1,
            },
            {
              id: 3,
              name: 'Loops',
              course: 1,
            },
            {
              id: 4,
              name: 'OOP',
              course: 1,
            },
          ],
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
        { text: 'description', value: 'description', align: 'center' },
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
