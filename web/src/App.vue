<template>
  <v-app>
    <Header />
    <v-main>
      <v-container fluid>
        <router-view />
      </v-container>
    </v-main>
    <Footer />
  </v-app>
</template>

<script>
import Header from '@/components/Header.vue';
import Footer from '@/components/Footer.vue';

export default {
  name: 'App',
  components: {
    Header,
    Footer,
  },
  computed: {
    user() {
      return this.$store.getters.currentUser;
    },
  },
  async created() {
    await this.$store.dispatch('fetchUser');
  },
  methods: {
    async logout() {
      await this.$store.dispatch('logout');
    },
  },
};
</script>
