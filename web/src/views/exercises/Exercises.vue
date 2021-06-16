<template>
  <v-container>
    <v-row justify="center">
      <v-col xl="6" cols="12">
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
        <v-expansion-panels popout>
          <v-expansion-panel v-for="(item, i) in 15" :key="i">
            <v-expansion-panel-header
              >Programação básica para jogos
              <div class="text-center" v-if="i == 0">
                <v-chip color="secondary" class="mr-2" label
                  ><v-icon left> fas fa-clipboard </v-icon> Em andamento
                </v-chip>
                <v-chip color="secondary" label> 4/10 </v-chip>
              </div>
              <div class="text-center" v-if="i == 1">
                <v-chip color="success" class="mr-2" label
                  ><v-icon left> fas fa-clipboard-check </v-icon> Feita
                </v-chip>
                <v-chip color="success" label> 12/12 </v-chip>
              </div>
            </v-expansion-panel-header>
            <v-expansion-panel-content>
              <p>
                Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor
                incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud
                exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
              </p>
              <v-row>
                <v-subheader> Tags </v-subheader>
                <v-chip-group>
                  <v-chip v-for="tag in tags" :key="tag">
                    {{ tag }}
                  </v-chip>
                </v-chip-group>
              </v-row>
              <v-row>
                <v-btn color="primary" depressed text to="/exercise/1">Ver Lista</v-btn>
              </v-row>
            </v-expansion-panel-content>
          </v-expansion-panel>
        </v-expansion-panels>
      </v-col>
    </v-row>
    <div class="text-center my-10">
      <v-pagination v-model="page" length="4" circle></v-pagination>
    </div>
  </v-container>
</template>

<script>
export default {
  name: 'Exercises',

  title: 'Exercícios | Find a Tutor',

  data: () => ({
    page: 1,
    keywords: ['Programação', 'Python', 'Jogos', 'Música'],
    tags: ['Programação', 'Jogos'],
    selectedKeywords: [],
    search: null,
  }),
};
</script>
