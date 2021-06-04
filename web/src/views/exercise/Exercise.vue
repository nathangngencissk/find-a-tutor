<template>
  <v-container>
    <v-row>
      <v-col cols="6">
        <v-sheet elevation="1" class="pa-4 mb-2" v-for="(item, i) in 10" :key="i">
          <v-row justify="space-between" align="center">
            <v-col cols="10">
              <p>
                Lorem ipsum dolor sit, amet consectetur adipisicing elit. Unde rem molestias
                architecto amet sequi, exercitationem cupiditate neque alias, sit vitae voluptatum
                id ex ab, natus nesciunt eaque cum? Quas, repudiandae?
              </p>
            </v-col>
            <v-col cols="2">
              <v-btn color="primary" depressed text @click="show = false">Ver</v-btn>
              <v-icon left color="success" v-if="i < 4"> fas fa-clipboard-check </v-icon>
            </v-col>
          </v-row>
        </v-sheet>
      </v-col>
      <v-divider vertical inset></v-divider>
      <v-col cols="6">
        <div class="ml-4">
          <v-subheader>
            Lorem ipsum dolor sit amet consectetur adipisicing elit. Natus accusamus beatae saepe
            laudantium, corrupti eum tenetur fugiat, ipsum illo soluta dolores iste nam suscipit
            tempore exercitationem laborum officiis, ea sunt?
          </v-subheader>
          <v-radio-group v-model="radioGroup">
            <v-radio v-for="n in 5" :key="n" :label="`Opção ${n}`" :value="n"></v-radio>
          </v-radio-group>
          <v-btn color="success" depressed @click="show = !show">Responder</v-btn>
          <v-btn color="primary" class="ml-2" depressed outlined @click="show = false"
            >Próxima</v-btn
          >
        </div>

        <v-divider class="my-4"></v-divider>
        <v-card class="mx-auto" v-if="show">
          <v-toolbar :color="rightChoice === radioGroup ? 'success' : 'error'" class="white--text">
            <v-toolbar-title>{{
              rightChoice === radioGroup ? 'Correta' : 'Incorreta'
            }}</v-toolbar-title>
          </v-toolbar>

          <v-container fluid>
            <v-subheader>Reposta correta</v-subheader>
            <h2>B</h2>
            <v-subheader>Explicação</v-subheader>
            <p>
              Lorem ipsum dolor sit amet consectetur adipisicing elit. Totam debitis architecto
              assumenda minima. Magni natus blanditiis facere alias, veritatis recusandae sint
              perspiciatis quo sunt, est ratione, voluptatum obcaecati beatae nulla!
            </p>
          </v-container>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
export default {
  title: 'Programação básica para jogos',
  name: 'Exercise',
  data() {
    return {
      radioGroup: 1,
      show: false,
      rightChoice: 2,
    };
  },
};
</script>
