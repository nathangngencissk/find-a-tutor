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
      { title: 'Photography', src: 'https://cdn.vuetifyjs.com/images/cards/house.jpg', flex: 3 },
      {
        title: 'Photography2',
        src: 'https://cdn.vuetifyjs.com/images/cards/road.jpg',
        flex: 3,
      },
      { title: 'Photography3', src: 'https://cdn.vuetifyjs.com/images/cards/plane.jpg', flex: 3 },
      { title: 'Photography4', src: 'https://cdn.vuetifyjs.com/images/cards/plane.jpg', flex: 3 },
      { title: 'Photography5', src: 'https://cdn.vuetifyjs.com/images/cards/plane.jpg', flex: 3 },
      { title: 'Photography6', src: 'https://cdn.vuetifyjs.com/images/cards/plane.jpg', flex: 3 },
      { title: 'Photography7', src: 'https://cdn.vuetifyjs.com/images/cards/plane.jpg', flex: 3 },
      { title: 'Photography8', src: 'https://cdn.vuetifyjs.com/images/cards/plane.jpg', flex: 3 },
    ],
  }),
};
</script>
