<template>
  <v-footer color="primary" padless>
    <v-row justify="center" no-gutters>
      <v-btn
        v-for="link in links"
        :key="link.name"
        :to="link.path"
        color="white"
        text
        rounded
        class="my-2"
      >
        {{ link.name }}
      </v-btn>
      <v-col class="secondary py-4 text-center white--text" cols="12">
        {{ new Date().getFullYear() }} — <strong>Find a Tutor</strong>
      </v-col>
    </v-row>
  </v-footer>
</template>

<script>
export default {
  name: 'Footer',
  data: () => ({
    links: [
      {
        name: 'Home',
        path: '/',
      },
      {
        name: 'Sobre',
        path: '/about',
      },
      {
        name: 'Time',
        path: '/team',
      },
      {
        name: 'Contato',
        path: '/contact',
      },
    ],
  }),
};
</script>
