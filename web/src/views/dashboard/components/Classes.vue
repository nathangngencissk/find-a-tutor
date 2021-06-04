<template>
  <v-container>
    <v-data-table
      :headers="headers"
      :items="classes"
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
          <v-toolbar-title>Turmas</v-toolbar-title>
          <v-divider class="mx-4" inset vertical></v-divider>
          <v-text-field v-model="search" label="Filtrar" class="mx-4"></v-text-field>
          <v-btn
            color="success"
            dark
            class="mb-2"
            :to="{ name: 'DashboardEditClass', params: { class: newClass } }"
          >
            Adicionar
          </v-btn>
        </v-toolbar>
      </template>
      <template v-slot:item.edit="{ item }">
        <v-btn color="primary" text :to="{ name: 'DashboardEditClass', params: { class: item } }"
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
      newClass: {
        id: 0,
        name: '',
        course: '',
        description: '',
        image: '',
        start: '',
        end: '',
        access: '',
      },
      classes: [
        {
          id: 1,
          name: 'Programação C# Turma de Julho',
          course: 'Programação C#',
          description:
            'Lorem ipsum dolor, sit amet consectetur adipisicing elit. Temporibus maxime incidunt non neque molestias eligendi? Qui pariatur recusandae et, sit cupiditate iste explicabo consequuntur architecto exercitationem, odit veritatis odio placeat.',
          access: '',
          image: '',
          start: '2021-07-21',
          end: '2021-10-22',
        },
        {
          id: 2,
          name: 'Redes de Computadores Turma de Julho',
          course: 'Redes de Computadores',
          description:
            'Lorem ipsum dolor, sit amet consectetur adipisicing elit. Temporibus maxime incidunt non neque molestias eligendi? Qui pariatur recusandae et, sit cupiditate iste explicabo consequuntur architecto exercitationem, odit veritatis odio placeat.',
          access: '',
          image: '',
          start: '2021-07-23',
          end: '2021-10-25',
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
          text: 'Curso',
          value: 'course',
        },
        { text: 'Começa em', value: 'start', align: 'center' },
        { text: 'Termina em', value: 'end', align: 'center' },
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
