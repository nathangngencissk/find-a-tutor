<template>
  <v-app-bar app absolute prominent color="white">
    <v-container>
      <v-row align="center">
        <v-col cols="1">
          <v-app-bar-title class="text-no-wrap">Vuetify</v-app-bar-title>
        </v-col>
        <v-col cols="7">
          <v-form>
            <v-container>
              <v-row align="baseline">
                <v-col cols="12">
                  <v-text-field label="Search" filled></v-text-field>
                </v-col>
              </v-row>
            </v-container>
          </v-form>
        </v-col>

        <v-col cols="4">
          <v-btn color="blue darken-1" plain @click="logout">
            <v-icon left icon="mdi-handshake-outline"></v-icon>
            <span>John Leider</span>
          </v-btn>

          <v-btn color="blue darken-1" plain>
            <v-icon left icon="mdi-handshake-outline"></v-icon>
            <span>My Courses</span>
          </v-btn>

          <v-btn color="blue darken-1" plain>
            <v-icon left icon="mdi-handshake-outline"></v-icon>
            <span>Teach</span>
          </v-btn>
        </v-col>
      </v-row>
    </v-container>
  </v-app-bar>
</template>

<script>
import { mapGetters } from 'vuex';

export default {
  name: 'Header',
  computed: {
    ...mapGetters(['currentUser', 'isAuthenticated']),
  },
  methods: {
    logout() {
      this.$store.dispatch('logout');
    },
  },
};
</script>
