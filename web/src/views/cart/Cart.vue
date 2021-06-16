<template>
  <v-container>
    <v-row justify="center">
      <v-col xl="6" lg="8" md="12" sm="12" xs="12" class="mt-4">
        <CourseCardShort
          courseName="Programação C#"
          courseImage="https://cdn.vuetifyjs.com/images/cards/docks.jpg"
          courseDescription="Lorem ipsum dolor sit amet, consectetur adipisicing elit. Repellat nemo inventore dolor fugiat exercitationem sint expedita facilis ea itaque, illum, doloremque praesentium autem similique quis placeat id maxime sunt nulla!"
          courseId="1"
        />
        <CourseCardShort
          courseName="Programação C#"
          courseImage="https://cdn.vuetifyjs.com/images/cards/docks.jpg"
          courseDescription="Lorem ipsum dolor sit amet, consectetur adipisicing elit. Repellat nemo inventore dolor fugiat exercitationem sint expedita facilis ea itaque, illum, doloremque praesentium autem similique quis placeat id maxime sunt nulla!"
          courseId="1"
        />
        <CourseCardShort
          courseName="Programação C#"
          courseImage="https://cdn.vuetifyjs.com/images/cards/docks.jpg"
          courseDescription="Lorem ipsum dolor sit amet, consectetur adipisicing elit. Repellat nemo inventore dolor fugiat exercitationem sint expedita facilis ea itaque, illum, doloremque praesentium autem similique quis placeat id maxime sunt nulla!"
          courseId="1"
        />
      </v-col>
      <v-col xl="3" lg="4" md="12" sm="12" xs="12">
        <v-card width="350">
          <v-subheader> Total:</v-subheader>
          <h1 class="ml-5">R$ 450,00</h1>
          <v-card-text class="text--primary">
            <div class="my-2">
              <v-btn x-large color="success" block> Finalizar </v-btn>
            </div>
          </v-card-text>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import CourseCardShort from '@/components/CourseCardShort.vue';

export default {
  name: 'Cart',

  title: 'Meu Carrinho | Find a Tutor',

  components: {
    CourseCardShort,
  },

  data: () => ({}),

  computed: {},

  methods: {},
};
</script>
