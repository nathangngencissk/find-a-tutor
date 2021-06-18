<template>
  <v-container>
    <v-container>
      <v-row>
        <v-col xl="6" cols="12">
          <h2>Nome</h2>
          <v-text-field label="Nome" :value="cl.name"></v-text-field>
        </v-col>
        <v-col xl="6" cols="12">
          <h2>Curso</h2>
          <v-select :items="items" label="Curso" :value="cl.course"></v-select>
        </v-col>
      </v-row>

      <v-row>
        <v-col xl="6" cols="12">
          <h2>Descrição</h2>
          <textarea :value="cl.description" auto-grow @input="update($event)"></textarea>
        </v-col>
        <v-col xl="6" cols="12">
          <h2>Preview</h2>
          <div v-html="compiledMarkdown"></div>
        </v-col>
      </v-row>
      <v-row>
        <v-col xl="6" cols="12">
          <h2>Como acessar</h2>
          <textarea :value="cl.access" auto-grow @input="updateAccess($event)"></textarea>
        </v-col>
        <v-col xl="6" cols="12">
          <h2>Preview</h2>
          <div v-html="compiledMarkdownAccess"></div>
        </v-col>
      </v-row>
      <v-row justify="center">
        <v-col xl="6" cols="12">
          <h2 class="mb-2">Datas de início e fim</h2>
          <v-row justify="center">
            <v-col cols="12">
              <v-dialog
                ref="dialog"
                v-model="modal"
                :return-value.sync="dateStart"
                persistent
                width="290px"
              >
                <template v-slot:activator="{ on, attrs }">
                  <v-text-field
                    v-model="dateStart"
                    label="Início"
                    prepend-icon="mdi-calendar"
                    readonly
                    v-bind="attrs"
                    v-on="on"
                  ></v-text-field>
                </template>
                <v-date-picker v-model="dateStart" scrollable locale="pt-br">
                  <v-spacer></v-spacer>
                  <v-btn text color="primary" @click="modal = false"> Cancelar </v-btn>
                  <v-btn text color="primary" @click="$refs.dialog.save(dateStart)"> OK </v-btn>
                </v-date-picker>
              </v-dialog>
            </v-col>
            <v-col cols="12">
              <v-dialog
                ref="dialog"
                v-model="modal"
                :return-value.sync="dateEnd"
                persistent
                width="290px"
              >
                <template v-slot:activator="{ on, attrs }">
                  <v-text-field
                    v-model="dateEnd"
                    label="Fim"
                    prepend-icon="mdi-calendar"
                    readonly
                    v-bind="attrs"
                    v-on="on"
                  ></v-text-field>
                </template>
                <v-date-picker v-model="dateEnd" scrollable locale="pt-br">
                  <v-spacer></v-spacer>
                  <v-btn text color="primary" @click="modal = false"> Cancelar </v-btn>
                  <v-btn text color="primary" @click="$refs.dialog.save(dateEnd)"> OK </v-btn>
                </v-date-picker>
              </v-dialog>
            </v-col>
          </v-row>
          <h2 class="mb-2">Horários</h2>
          <v-col cols="12">
            <v-select
              v-model="days"
              :items="daysOfTheWeek"
              :menu-props="{ maxHeight: '400' }"
              label="Dias"
              multiple
              hint="Escolha os dias da sua aula"
              persistent-hint
            ></v-select>
          </v-col>
          <v-col cols="12">
            <div>
              <v-row justify="space-around" align="center">
                <v-col style="width: 300px; flex: 0 1 auto">
                  <h2>Começo:</h2>
                  <v-time-picker v-model="start" :max="end"></v-time-picker>
                </v-col>
                <v-col style="width: 300px; flex: 0 1 auto">
                  <h2>Término:</h2>
                  <v-time-picker v-model="end" :min="start"></v-time-picker>
                </v-col>
              </v-row>
            </div>
          </v-col>
        </v-col>
      </v-row>
      <v-row justify="center">
        <v-col xl="6" cols="12">
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
    </v-container>
    <v-row justify="center">
      <v-col cols="10">
        <h2 class="mb-2">Postagens</h2>
        <v-data-table
          :headers="headers"
          :items="posts"
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
              <v-toolbar-title>Postagens</v-toolbar-title>
              <v-divider class="mx-4" inset vertical></v-divider>
              <v-text-field v-model="search" label="Filtrar" class="mx-4"></v-text-field>
              <v-btn color="success" dark class="mb-2" @click="addPost"> Adicionar </v-btn>
            </v-toolbar>
          </template>
          <template v-slot:item.edit="{ item }">
            <v-btn color="primary" text @click="editPost($event, item)">Editar</v-btn>
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
    <v-overlay :z-index="zIndex" :value="overlay" :dark="$vuetify.theme.dark">
      <v-card class="pa-4" min-width="600px">
        <v-form>
          <v-text-field label="Título" :value="title"></v-text-field>
          <v-textarea outlined name="input-7-4" label="Corpo" :value="body"></v-textarea>
        </v-form>
        <v-btn class="mr-4" color="success" @click="overlay = false"> Salvar </v-btn>
        <v-btn color="error" outlined @click="overlay = false"> Fechar </v-btn>
      </v-card>
    </v-overlay>
  </v-container>
</template>

<script>
export default {
  name: 'DashboardEditCourse',
  data: () => ({
    daysOfTheWeek: [
      'Segunda-feira',
      'Terça-feira',
      'Quarta-feira',
      'Quinta-feira',
      'Sexta-feira',
      'Sábado',
      'Domingo',
    ],
    days: [],
    dateStart: new Date().toISOString().substr(0, 10),
    dateEnd: new Date().toISOString().substr(0, 10),
    menu: false,
    modal: false,
    items: [
      'Programação C#',
      'Redes de Computadores',
      'Programação para jogos',
      'Programação para inciantes',
      'Orientação a objetos em C#',
      'Como ficar rico com C#',
      'Arduino do iniciante ao avançado',
      'Programação C++',
    ],
    input: '# hello',
    page: 1,
    pageCount: 0,
    itemsPerPage: 10,
    search: '',
    isDragging: false,
    overlay: false,
    zIndex: 2,
    title: '',
    body: '',
    posts: [
      {
        id: 1,
        title: 'Postagem 1',
        body: 'Postagem 1',
      },
      {
        id: 2,
        title: 'Postagem 2',
        body: 'Postagem 2',
      },
      {
        id: 3,
        title: 'Postagem 3',
        body: 'Postagem 3',
      },
      {
        id: 4,
        title: 'Postagem 4',
        body: 'Postagem 4',
      },
      {
        id: 5,
        title: 'Postagem 5',
        body: 'Postagem 5',
      },
    ],
  }),
  computed: {
    cl() {
      return this.$route.params.class;
    },
    compiledMarkdown() {
      return this.$marked(this.$route.params.class.description, { sanitize: true });
    },
    compiledMarkdownAccess() {
      return this.$marked(this.$route.params.class.access, { sanitize: true });
    },
    dateRangeText() {
      return this.dates.join(' ~ ');
    },
    headers() {
      return [
        {
          text: 'Título',
          align: 'start',
          value: 'title',
        },
        {
          text: 'Corpo',
          value: 'body',
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
      this.cl.description = event.target.value;
    },
    updateAccess(event) {
      this.cl.access = event.target.value;
    },
    onMove({ relatedContext, draggedContext }) {
      const relatedElement = relatedContext.element;
      const draggedElement = draggedContext.element;
      return (!relatedElement || !relatedElement.fixed) && !draggedElement.fixed;
    },
    editPost(event, post) {
      this.title = post.title;
      this.body = post.body;
      this.overlay = true;
    },
    addPost() {
      this.title = '';
      this.body = '';
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
