<template>
  <v-container>
    <v-row justify="center">
      <v-col cols="10">
        <v-data-table
          :headers="headers"
          :items="exercisesLists"
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
              <v-toolbar-title>Listas de exercícios</v-toolbar-title>
              <v-divider class="mx-4" inset vertical></v-divider>
              <v-text-field v-model="search" label="Filtrar" class="mx-4"></v-text-field>
              <v-btn
                color="success"
                dark
                class="mb-2"
                :to="{ name: 'DashboardEditExercise', params: { exerciseList: newExerciseList } }"
              >
                Adicionar
              </v-btn>
            </v-toolbar>
          </template>
          <template v-slot:item.edit="{ item }">
            <v-btn
              color="primary"
              text
              :to="{ name: 'DashboardEditExercise', params: { exerciseList: item } }"
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
      newExerciseList: {
        id: 0,
        name: '',
        description: '',
        tags: [],
        exercises: [
          {
            id: 1,
            question: '',
            status: 'EM AVALIAÇÃO',
            rightOptions: [],
            options: [
              {
                id: 1,
                text: '',
              },
              {
                id: 2,
                text: '',
              },
              {
                id: 3,
                text: '',
              },
              {
                id: 4,
                text: '',
              },
              {
                id: 5,
                text: '',
              },
            ],
          },
        ],
      },
      exercisesLists: [
        {
          id: 1,
          name: 'Programação básica para jogos',
          description:
            'Lorem ipsum dolor sit amet consectetur adipisicing elit. Quisquam quia vitae voluptatum sequi. Iste eos, sapiente tempora voluptatem excepturi dignissimos accusamus officia esse neque expedita soluta iusto quaerat dolores veritatis?',
          tags: ['Programação', 'Jogos'],
          status: 'APROVADO',
          exercises: [
            {
              id: 1,
              question:
                'Lorem ipsum dolor sit amet consectetur adipisicing elit. Quisquam quia vitae voluptatum sequi. Iste eos, sapiente tempora voluptatem excepturi dignissimos accusamus officia esse neque expedita soluta iusto quaerat dolores veritatis?',
              rightOptions: [2],
              options: [
                {
                  id: 1,
                  text: 'Opção 1',
                },
                {
                  id: 2,
                  text: 'Opção 2',
                },
                {
                  id: 3,
                  text: 'Opção 3',
                },
                {
                  id: 4,
                  text: 'Opção 4',
                },
                {
                  id: 5,
                  text: 'Opção 5',
                },
              ],
            },
            {
              id: 2,
              question:
                '12 ipsum dolor sit amet consectetur adipisicing elit. Quisquam quia vitae voluptatum sequi. Iste eos, sapiente tempora voluptatem excepturi dignissimos accusamus officia esse neque expedita soluta iusto quaerat dolores veritatis?',
              rightOptions: [2],
              options: [
                {
                  id: 1,
                  text: 'Opção 1',
                },
                {
                  id: 2,
                  text: 'Opção 2',
                },
                {
                  id: 3,
                  text: 'Opção 3',
                },
                {
                  id: 4,
                  text: 'Opção 4',
                },
                {
                  id: 5,
                  text: 'Opção 5',
                },
              ],
            },
            {
              id: 3,
              question:
                '213 ipsum dolor sit amet consectetur adipisicing elit. Quisquam quia vitae voluptatum sequi. Iste eos, sapiente tempora voluptatem excepturi dignissimos accusamus officia esse neque expedita soluta iusto quaerat dolores veritatis?',
              rightOptions: [2],
              options: [
                {
                  id: 1,
                  text: 'Opção 1',
                },
                {
                  id: 2,
                  text: 'Opção 2',
                },
                {
                  id: 3,
                  text: 'Opção 3',
                },
                {
                  id: 4,
                  text: 'Opção 4',
                },
                {
                  id: 5,
                  text: 'Opção 5',
                },
              ],
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
        { text: 'Tags', value: 'tags', align: 'center' },
        { text: 'Status', value: 'status', align: 'center' },
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
