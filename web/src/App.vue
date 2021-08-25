<template>
  <v-app>
    <Header />
    <v-main id="main-body">
      <router-view />
    </v-main>
    <Footer />
  </v-app>
</template>

<script>
import Header from '@/components/Header.vue';
import Footer from '@/components/Footer.vue';
import { getUserCourses } from '@/graphql/queries';
import { mapGetters } from 'vuex';

export default {
  name: 'App',
  components: {
    Header,
    Footer,
  },
  computed: {
    ...mapGetters('auth', ['currentUser', 'isAuthenticated']),
    user() {
      return this.$store.getters['auth/fetchUser'];
    },
  },
  async created() {
    await this.$store.dispatch('auth/fetchUser');
    this.getUserCourses();
  },
  methods: {
    async logout() {
      await this.$store.dispatch('auth/logout');
    },
    getUserCourses() {
      this.$gqlClient
        .query({
          query: this.$gql(getUserCourses),
          variables: { user_id: this.currentUser.username },
        })
        .then(async (response) => {
          const result = JSON.parse(response.data.getUserCourses);
          await this.$store.dispatch('course/updateUserCourses', { courses: result });
        });
    },
  },
  async mounted() {
    const theme = localStorage.getItem('dark_theme');
    if (theme) {
      if (theme === 'true') {
        this.$vuetify.theme.dark = true;
      } else {
        this.$vuetify.theme.dark = false;
      }
    }
    const student = localStorage.getItem('student');
    if (student) {
      if (student === 'false') {
        await this.$store.dispatch('common/changeToTutor');
      } else {
        await this.$store.dispatch('common/changeToStudent');
      }
    } else {
      localStorage.student = 'true';
      await this.$store.dispatch('common/changeToStudent');
    }
  },
};
</script>
