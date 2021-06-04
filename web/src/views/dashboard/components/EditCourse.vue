<template>
  <v-container>
    <v-container>
      <v-row>
        <v-col cols="6">
          <h2>Nome</h2>
          <v-text-field label="Nome" :value="course.name"></v-text-field>
        </v-col>
        <v-col cols="3">
          <h2>Categoria</h2>
          <v-select :items="items" label="Categoria" :value="course.category"></v-select>
        </v-col>
        <v-col cols="3">
          <h2>Valor (R$)</h2>
          <v-text-field label="Valor" :value="course.value"></v-text-field>
        </v-col>
      </v-row>
      <v-row>
        <v-col cols="6">
          <h2>Descrição</h2>
          <textarea :value="course.description" auto-grow @input="update($event)"></textarea>
        </v-col>
        <v-col cols="6">
          <h2>Preview</h2>
          <div v-html="compiledMarkdown"></div>
        </v-col>
      </v-row>
    </v-container>
    <v-row justify="center">
      <v-col cols="6">
        <h2 class="mb-2">Imagem de capa</h2>
        <v-hover>
          <template v-slot:default="{ hover }">
            <v-img
              src="https://miro.medium.com/max/1000/1*c34daw_rg89UAh4uFCZ96w.jpeg"
              height="300"
              width="600"
              cover
            >
              <v-fade-transition>
                <v-overlay v-if="hover" absolute color="rgba(0, 0, 0, 0.87)">
                  <v-btn color="primary">Alterar</v-btn>
                </v-overlay>
              </v-fade-transition>
            </v-img>
          </template>
        </v-hover>
      </v-col>
    </v-row>
    <v-row justify="center">
      <v-col cols="12">
        <h2 class="mb-2">Aulas</h2>
        <v-data-table
          :headers="headers"
          :items="lectures"
          :page.sync="page"
          :items-per-page="itemsPerPage"
          @page-count="pageCount = $event"
          hide-default-footer
          item-key="name"
          class="elevation-1 page__table"
          :search="search"
        >
          <template v-slot:top>
            <v-toolbar flat>
              <v-toolbar-title>Aulas</v-toolbar-title>
              <v-divider class="mx-4" inset vertical></v-divider>
              <v-text-field v-model="search" label="Filtrar" class="mx-4"></v-text-field>
              <v-btn color="success" dark class="mb-2" @click="addLecture"> Adicionar </v-btn>
            </v-toolbar>
          </template>
          <template v-slot:body="props">
            <draggable
              ghost-class="ghost"
              v-bind="dragOptions"
              :move="onMove"
              @start="isDragging = true"
              @end="isDragging = false"
              :list="props.items"
              tag="tbody"
            >
              <tr v-for="(lecture, index) in props.items" :key="index">
                <td>
                  <v-icon small class="page__grab-icon"> mdi-arrow-all </v-icon>
                </td>
                <td>
                  <b>{{ index + 1 }}</b>
                </td>
                <td>{{ lecture.name }}</td>
                <td>{{ lecture.description }}</td>
                <td>
                  <v-btn color="primary" @click="editLecture($event, lecture)" text>Editar</v-btn>
                </td>
                <td><v-btn color="error" text>Remover</v-btn></td>
              </tr>
            </draggable>
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
    <v-overlay :z-index="zIndex" :value="overlay" :dark="$vuetify.theme.dark">
      <v-card class="pa-4" min-width="600px">
        <v-form>
          <v-text-field label="Nome" :value="name"></v-text-field>
          <v-textarea outlined name="input-7-4" label="Descrição" :value="description"></v-textarea>
          <v-row justify="start" align="center" class="mb-4">
            <v-col cols="12">
              <span><v-icon left> fas fa-file-video </v-icon> {{ video }}</span>
              <v-btn text color="primary">Carregar Vídeo</v-btn>
            </v-col>
          </v-row>
        </v-form>
        <v-btn class="mr-4" color="success" @click="overlay = false"> Salvar </v-btn>
        <v-btn color="error" outlined @click="overlay = false"> Fechar </v-btn>
      </v-card>
    </v-overlay>
  </v-container>
</template>

<script>
import draggable from 'vuedraggable';

export default {
  name: 'DashboardEditCourse',
  components: { draggable },
  data: () => ({
    items: ['Tecnologia', 'Música', 'Matemática', 'Desenho'],
    input: '# hello',
    page: 1,
    pageCount: 0,
    itemsPerPage: 10,
    search: '',
    isDragging: false,
    overlay: false,
    zIndex: 0,
    name: '',
    description: '',
    video: '',
    lectures: [
      {
        id: 1,
        name: 'Programação C#',
        description:
          'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nulla, eos numquam, odio nesciunt fugit minus pariatur voluptas quasi mollitia dolorum, exercitationem libero sunt voluptatum! Maxime a voluptatum quibusdam illum aliquid.',
        video: 'programacao-c-sharp.mp4',
      },
      {
        id: 2,
        name: 'Redes de Computadores',
        description:
          'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nulla, eos numquam, odio nesciunt fugit minus pariatur voluptas quasi mollitia dolorum, exercitationem libero sunt voluptatum! Maxime a voluptatum quibusdam illum aliquid.',
        video: 'programacao-c-sharp.mp4',
      },
      {
        id: 3,
        name: 'Programação para jogos',
        description:
          'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nulla, eos numquam, odio nesciunt fugit minus pariatur voluptas quasi mollitia dolorum, exercitationem libero sunt voluptatum! Maxime a voluptatum quibusdam illum aliquid.',
        video: 'programacao-c-sharp.mp4',
      },
      {
        id: 4,
        name: 'Programação para inciantes',
        description:
          'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nulla, eos numquam, odio nesciunt fugit minus pariatur voluptas quasi mollitia dolorum, exercitationem libero sunt voluptatum! Maxime a voluptatum quibusdam illum aliquid.',
        video: 'programacao-c-sharp.mp4',
      },
      {
        id: 5,
        name: 'Orientação a objetos em C#',
        description:
          'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nulla, eos numquam, odio nesciunt fugit minus pariatur voluptas quasi mollitia dolorum, exercitationem libero sunt voluptatum! Maxime a voluptatum quibusdam illum aliquid.',
        video: 'programacao-c-sharp.mp4',
      },
      {
        id: 6,
        name: 'Como ficar rico com C#',
        description:
          'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nulla, eos numquam, odio nesciunt fugit minus pariatur voluptas quasi mollitia dolorum, exercitationem libero sunt voluptatum! Maxime a voluptatum quibusdam illum aliquid.',
        video: 'programacao-c-sharp.mp4',
      },
      {
        id: 7,
        name: 'Arduino do iniciante ao avançado',
        description:
          'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nulla, eos numquam, odio nesciunt fugit minus pariatur voluptas quasi mollitia dolorum, exercitationem libero sunt voluptatum! Maxime a voluptatum quibusdam illum aliquid.',
        video: 'programacao-c-sharp.mp4',
      },
      {
        id: 8,
        name: 'Programação C++',
        description:
          'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nulla, eos numquam, odio nesciunt fugit minus pariatur voluptas quasi mollitia dolorum, exercitationem libero sunt voluptatum! Maxime a voluptatum quibusdam illum aliquid.',
        video: 'programacao-c-sharp.mp4',
      },
    ],
  }),
  computed: {
    course() {
      return this.$route.params.course;
    },
    compiledMarkdown() {
      return this.$marked(this.$route.params.course.description, { sanitize: true });
    },
    headers() {
      return [
        {
          text: '',
          align: 'start',
          sortable: false,
          value: 'drag',
        },
        {
          text: '#',
          align: 'start',
          sortable: false,
          value: 'order',
        },
        {
          text: 'Nome',
          align: 'start',
          value: 'name',
        },
        {
          text: 'Descrição',
          value: 'descrição',
        },
        { text: 'Editar', value: 'edit', sortable: false, align: 'center' },
        { text: 'Remover', value: 'remove', sortable: false, align: 'center' },
      ];
    },
    dragOptions() {
      return {
        animation: 0,
        group: 'description',
        ghostClass: 'ghost',
      };
    },
  },
  methods: {
    // eslint-disable-next-line func-names
    update(event) {
      this.course.description = event.target.value;
    },
    onMove({ relatedContext, draggedContext }) {
      const relatedElement = relatedContext.element;
      const draggedElement = draggedContext.element;
      return (!relatedElement || !relatedElement.fixed) && !draggedElement.fixed;
    },
    editLecture(event, lecture) {
      this.name = lecture.name;
      this.description = lecture.description;
      this.video = lecture.video;
      this.overlay = true;
    },
    addLecture() {
      this.name = '';
      this.description = '';
      this.video = '';
      this.overlay = true;
    },
  },
  watch: {
    isDragging(newValue) {
      if (newValue) {
        this.delayedDragging = true;
        return;
      }
      this.$nextTick(() => {
        this.delayedDragging = false;
      });
    },
  },
};
</script>

<style lang="scss" scoped>
textarea {
  border: none;
  border-right: 1px solid #ccc;
  resize: none;
  outline: none;
  background-color: #f6f6f6;
  font-size: 14px;
  font-family: 'Monaco', courier, monospace;
  padding: 20px;
  width: 100%;
  min-height: 300px;
}

.page--table {
  .page {
    &__table {
      margin-top: 20px;
    }
    &__grab-icon {
      cursor: move;
    }
  }
}

.flip-list-move {
  transition: transform 1s;
}

.ghost {
  opacity: 0.2;
}
</style>
