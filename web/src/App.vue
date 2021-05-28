<template>
  <v-app>
    <Header />
    <v-main>
      <router-view />
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
      return this.$store.getters['auth/fetchUser'];
    },
  },
  async created() {
    await this.$store.dispatch('auth/fetchUser');
  },
  methods: {
    async logout() {
      await this.$store.dispatch('auth/logout');
    },
  },
  mounted() {
    const theme = localStorage.getItem('dark_theme');
    if (theme) {
      if (theme === 'true') {
        this.$vuetify.theme.dark = true;
      } else {
        this.$vuetify.theme.dark = false;
      }
    }
  },
};
</script>
