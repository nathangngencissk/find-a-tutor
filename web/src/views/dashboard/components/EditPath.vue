<template>
  <v-container>
    <v-row justify="center">
      <v-col xl="6" cols="12">
        <h2>Nome</h2>
        <v-text-field label="Nome" :value="path.name"></v-text-field>
      </v-col>
    </v-row>
    <v-row justify="center">
      <v-col xl="6" cols="12">
        <h2>Descrição</h2>
        <v-textarea
          class="mt-2"
          outlined
          name="input-7-4"
          label="Descrição"
          :value="path.description"
        ></v-textarea>
      </v-col>
    </v-row>
    <v-row justify="center">
      <v-col xl="6" cols="12">
        <h2 class="mb-2">Imagem de capa</h2>
        <v-hover>
          <template v-slot:default="{ hover }">
            <v-img :src="path.image" height="300" width="600" cover>
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
    <v-row justify="center" v-for="section in path.sections" :key="section.id">
      <v-col xl="6" cols="12">
        <v-row>
          <v-col cols="10">
            <v-text-field
              label="Nome da seção"
              placeholder="Nome da seção"
              :value="section.name"
            ></v-text-field>
          </v-col>
          <v-col cols="2">
            <v-btn class="mx-2" fab dark small color="error">
              <v-icon dark> mdi-minus </v-icon>
            </v-btn>
          </v-col>
        </v-row>

        <h3 class="mb-2">Curso: Programação C#</h3>
        <v-hover>
          <template v-slot:default="{ hover }">
            <v-img
              src="https://images.unsplash.com/photo-1571171637578-41bc2dd41cd2?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80"
              height="300"
              width="600"
              cover
            >
              <v-fade-transition>
                <v-overlay v-if="hover" absolute color="rgba(0, 0, 0, 0.87)">
                  <v-btn color="primary" @click="change">Alterar</v-btn>
                </v-overlay>
              </v-fade-transition>
            </v-img>
          </template>
        </v-hover>
      </v-col>
    </v-row>
    <v-row justify="center">
      <v-col cols="2">
        <v-btn color="primary" @click="addSection">Adicionar Seção</v-btn>
      </v-col>
    </v-row>
    <v-row justify="center" class="mt-4 ml-14">
      <v-col cols="2">
        <v-btn color="success">Salvar</v-btn>
      </v-col>
    </v-row>
    <v-overlay :z-index="zIndex" :value="overlay" :dark="$vuetify.theme.dark">
      <v-card class="pa-4" width="600px">
        <v-form>
          <v-text-field label="Buscar" :value="title"></v-text-field>
          <v-btn color="success" depressed>Buscar</v-btn>
          <v-row>
            <v-col xl="4" lg="6" cols="12">
              <v-subheader>Programação C#</v-subheader>
              <v-img
                src="https://images.unsplash.com/photo-1571171637578-41bc2dd41cd2?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80"
                cover
              >
              </v-img>
            </v-col>
            <v-col xl="4" lg="6" cols="12">
              <v-subheader>Programação C#</v-subheader>
              <v-img
                src="https://images.unsplash.com/photo-1571171637578-41bc2dd41cd2?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80"
                cover
              >
              </v-img>
            </v-col>
            <v-col xl="4" lg="6" cols="12">
              <v-subheader>Programação C#</v-subheader>
              <v-img
                src="https://images.unsplash.com/photo-1571171637578-41bc2dd41cd2?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80"
                cover
              >
              </v-img>
            </v-col>
          </v-row>
        </v-form>
        <v-row class="my-4 mx-1">
          <v-btn class="white--text mr-4" color="success" @click="overlay = false"> Salvar </v-btn>
          <v-btn class="white--text" color="error" outlined @click="overlay = false">
            Fechar
          </v-btn>
        </v-row>
      </v-card>
    </v-overlay>
  </v-container>
</template>

<script>
export default {
  name: 'DashboardEditPath',
  data: () => ({
    menu: false,
    modal: false,
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
  }),
  computed: {
    path() {
      return this.$route.params.path;
    },
  },
  methods: {
    addSection() {
      this.path.sections.push({
        id: 0,
        name: '',
      });
    },
    change() {
      this.overlay = true;
    },
  },
  watch: {},
};
</script>
