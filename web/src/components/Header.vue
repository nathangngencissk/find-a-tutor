<template>
  <v-app-bar app absolute prominent>
    <v-container>
      <v-row align="center" justify="space-between">
        <v-col cols="1" xl="1" lg="2" md="2" sm="6" xs="6">
          <v-img
            :aspect-ratio="16 / 9"
            max-height="200"
            max-width="200"
            min-width="100"
            min-height="100"
            src="@/assets/main-logo.png"
            @click="pushHome"
            id="main_logo"
          ></v-img>
        </v-col>
        <v-col cols="7" xl="7" lg="8" md="8" class="d-none d-md-flex d-lg-flex d-xl-flex">
          <v-form>
            <v-container>
              <v-row align="end" justify="end">
                <v-col cols="12">
                  <v-text-field label="Pesquisar" filled></v-text-field>
                </v-col>
              </v-row>
            </v-container>
          </v-form>
        </v-col>

        <v-col cols="3" xl="3" class="d-none d-xl-flex">
          <v-row align="center" justify="space-around">
            <v-btn color="primaryText" plain>
              <span>Meus Cursos</span>
            </v-btn>

            <v-btn color="primaryText" plain>
              <span>Discussões</span>
            </v-btn>

            <v-btn color="primaryText" plain>
              <span>Exercícios</span>
            </v-btn>
          </v-row>
        </v-col>
        <v-col cols="1" xl="1" lg="2" md="2" sm="6" xs="6" align-self="center">
          <v-menu offset-y left nudge-bottom="10" v-if="isAuthenticated">
            <template v-slot:activator="{ on, attrs }">
              <v-avatar v-bind="attrs" v-on="on">
                <img src="https://cdn.vuetifyjs.com/images/john.jpg" alt="João" />
              </v-avatar>
            </template>
            <v-list>
              <v-list-item two-line>
                <v-list-item-avatar>
                  <img src="https://cdn.vuetifyjs.com/images/john.jpg" />
                </v-list-item-avatar>

                <v-list-item-content>
                  <v-list-item-title>João Silva</v-list-item-title>
                  <v-list-item-subtitle>Estudante</v-list-item-subtitle>
                </v-list-item-content>
              </v-list-item>
              <v-divider></v-divider>
              <v-list dense>
                <v-list-item>
                  <v-list-item-icon>
                    <v-icon>fas fa-shopping-cart</v-icon>
                  </v-list-item-icon>

                  <v-list-item-content>
                    <v-btn depressed small to="/about">Meu Carrinho</v-btn>
                  </v-list-item-content>
                </v-list-item>
              </v-list>
              <v-divider></v-divider>
              <v-list dense>
                <v-list-item v-for="item in items" :key="item.title">
                  <v-list-item-icon>
                    <v-icon>{{ item.icon }}</v-icon>
                  </v-list-item-icon>

                  <v-list-item-content>
                    <v-btn depressed small to="/about">{{ item.title }}</v-btn>
                  </v-list-item-content>
                </v-list-item>
              </v-list>
              <v-divider></v-divider>
              <v-list-item>
                <v-list-item-content id="dark_mode_toggler">
                  <v-switch
                    v-model="darkModeOn"
                    @click="toggleDarkMode"
                    label="Modo Escuro"
                    class="mx-auto"
                  ></v-switch>
                </v-list-item-content>
              </v-list-item>
              <v-divider></v-divider>
              <v-list dense>
                <v-list-item>
                  <v-list-item-icon>
                    <v-icon>fas fa-user</v-icon>
                  </v-list-item-icon>

                  <v-list-item-content>
                    <v-btn depressed small to="/about">Minha Conta</v-btn>
                  </v-list-item-content>
                </v-list-item>
                <v-list-item>
                  <v-list-item-icon>
                    <v-icon>fas fa-chalkboard-teacher</v-icon>
                  </v-list-item-icon>

                  <v-list-item-content>
                    <v-btn depressed small to="/about">Ensinar</v-btn>
                  </v-list-item-content>
                </v-list-item>
              </v-list>
              <v-divider></v-divider>
              <v-list-item @click="logout" class="mx-auto">
                <v-list-item-icon>
                  <v-icon>fas fa-sign-out-alt</v-icon>
                </v-list-item-icon>

                <v-list-item-content>
                  <v-list-item-title>Deslogar</v-list-item-title>
                </v-list-item-content>
              </v-list-item>
            </v-list>
            <v-divider></v-divider>
          </v-menu>
          <v-btn rounded color="primary" dark v-else @click="pushLogin">Entrar</v-btn>
        </v-col>
      </v-row>
    </v-container>
  </v-app-bar>
</template>

<script>
import { mapGetters } from 'vuex';

export default {
  name: 'Header',
  data: () => ({
    items: [
      { title: 'Meus Cursos', icon: 'fas fa-book' },
      { title: 'Discussões', icon: 'fas fa-comments' },
      { title: 'Exercícios', icon: 'fas fa-dumbbell' },
      { title: 'Trilhas de Aprendizagem', icon: 'fas fa-hiking' },
      { title: 'Minhas Anotações', icon: 'fas fa-book-open' },
    ],
  }),
  computed: {
    ...mapGetters(['currentUser', 'isAuthenticated']),
    darkModeOn() {
      return this.$vuetify.theme.dark;
    },
  },
  methods: {
    logout() {
      this.$store.dispatch('logout');
    },
    pushHome() {
      this.$router.push({ name: 'Home' }).catch((error) => {
        if (error.name !== 'NavigationDuplicated') {
          throw error;
        }
      });
    },
    pushLogin() {
      this.$router.push({ name: 'Login' }).catch((error) => {
        if (error.name !== 'NavigationDuplicated') {
          throw error;
        }
      });
    },
    toggleDarkMode() {
      this.$vuetify.theme.dark = !this.$vuetify.theme.dark;
    },
  },
};
</script>

<style scoped lang="scss">
#main_logo {
  cursor: pointer;
}

.v-form {
  width: 100%;
}

.v-avatar {
  right: 0;
}

#dark_mode_toggler {
  overflow: visible;
  margin-right: 24px;
}
</style>
