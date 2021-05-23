<template>
  <v-row dense>
    <v-col v-for="card in cards" :key="card.title" :cols="card.flex">
      <v-card class="mx-auto" max-width="344">
        <v-img src="https://cdn.vuetifyjs.com/images/cards/sunshine.jpg" height="200px"></v-img>

        <v-card-title> {{ card.title }} </v-card-title>
      </v-card>
    </v-col>
  </v-row>
</template>

<script>
export default {
  data: () => ({
    cards: [
      { title: 'Fotografia', src: 'https://cdn.vuetifyjs.com/images/cards/house.jpg', flex: 3 },
      {
        title: 'Culinária',
        src: 'https://cdn.vuetifyjs.com/images/cards/road.jpg',
        flex: 3,
      },
      { title: 'Tecnologia', src: 'https://cdn.vuetifyjs.com/images/cards/plane.jpg', flex: 3 },
      { title: 'Matemática', src: 'https://cdn.vuetifyjs.com/images/cards/plane.jpg', flex: 3 },
      { title: 'Inglês', src: 'https://cdn.vuetifyjs.com/images/cards/plane.jpg', flex: 3 },
      { title: 'Fisolofia', src: 'https://cdn.vuetifyjs.com/images/cards/plane.jpg', flex: 3 },
      { title: 'Economia', src: 'https://cdn.vuetifyjs.com/images/cards/plane.jpg', flex: 3 },
      {
        title: 'Finanças Pessoais',
        src: 'https://cdn.vuetifyjs.com/images/cards/plane.jpg',
        flex: 3,
      },
    ],
  }),
};
</script>
