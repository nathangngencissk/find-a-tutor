<template>
  <v-app-bar app absolute prominent>
    <v-container>
      <v-row align="center" justify="space-between">
        <v-col xl="1" lg="2" md="2" sm="6" xs="6">
          <v-img
            :aspect-ratio="16 / 9"
            max-height="200"
            max-width="200"
            min-width="100"
            min-height="100"
            src="@/assets/main-logo-dark.png"
            @click="pushHome"
            id="main_logo"
            v-if="darkModeOn"
          ></v-img>
          <v-img
            :aspect-ratio="16 / 9"
            max-height="200"
            max-width="200"
            min-width="100"
            min-height="100"
            src="@/assets/main-logo.png"
            @click="pushHome"
            id="main_logo"
            v-else
          ></v-img>
        </v-col>
        <v-col cols="7" xl="7" lg="8" md="8" class="d-none d-md-flex d-lg-flex d-xl-flex">
          <v-container>
            <v-row align="end" justify="end">
              <v-col cols="12">
                <v-text-field
                  label="Pesquisar"
                  append-icon="fas fa-search"
                  v-model="search"
                  @click:append="pushSearch"
                  filled
                ></v-text-field>
              </v-col>
            </v-row>
          </v-container>
        </v-col>

        <v-col cols="3" xl="3" class="d-none d-xl-flex">
          <v-row align="center" justify="space-around">
            <v-btn color="primaryText" plain to="/dashboard" v-if="platformTutor">
              <span>Painel</span>
            </v-btn>

            <v-btn color="primaryText" plain to="/courses" v-else>
              <span>Meus Cursos</span>
            </v-btn>

            <v-btn color="primaryText" plain to="/foruns">
              <span>Fóruns</span>
            </v-btn>

            <v-btn color="primaryText" plain to="/notes" v-if="platformTutor">
              <span>Minhas Anotações</span>
            </v-btn>

            <v-btn color="primaryText" plain to="/exercises" v-else>
              <span>Exercícios</span>
            </v-btn>
          </v-row>
        </v-col>
        <v-col xl="1" lg="2" md="2" sm="6" xs="6" align-self="center">
          <v-menu offset-y left nudge-bottom="10" v-if="isAuthenticated">
            <template v-slot:activator="{ on, attrs }">
              <v-badge
                color="primary"
                icon="fas fa-chalkboard-teacher"
                overlap
                bordered
                v-if="platformTutor"
              >
                <v-avatar v-bind="attrs" v-on="on">
                  <img :src="profilePicture" alt="Foto de perfil" />
                </v-avatar>
              </v-badge>
              <v-badge color="transparent" overlap v-else>
                <v-avatar v-bind="attrs" v-on="on">
                  <img :src="profilePicture" alt="Foto de perfil" />
                </v-avatar>
              </v-badge>
            </template>
            <v-list>
              <v-list-item two-line>
                <v-list-item-avatar>
                  <img :src="profilePicture" />
                </v-list-item-avatar>

                <v-list-item-content>
                  <v-list-item-title
                    >{{ currentUserName }} {{ currentUserFamilyName }}</v-list-item-title
                  >
                  <v-list-item-subtitle v-if="platformTutor">Tutor</v-list-item-subtitle>
                  <v-list-item-subtitle v-else>Estudante</v-list-item-subtitle>
                </v-list-item-content>
              </v-list-item>
              <v-divider></v-divider>
              <v-list dense>
                <v-list-item v-if="platformTutor">
                  <v-list-item-icon>
                    <v-icon>fas fa-pencil-ruler</v-icon>
                  </v-list-item-icon>

                  <v-list-item-content>
                    <v-btn depressed small to="/dashboard">Painel</v-btn>
                  </v-list-item-content>
                </v-list-item>

                <v-list-item>
                  <v-list-item-icon>
                    <v-badge
                      v-if="parseInt(shoppingCartItemsNumber) > 0"
                      color="primary"
                      :content="shoppingCartItemsNumber"
                    >
                      <v-icon>fas fa-shopping-cart</v-icon>
                    </v-badge>
                    <v-icon v-else>fas fa-shopping-cart</v-icon>
                  </v-list-item-icon>

                  <v-list-item-content>
                    <v-btn depressed small to="/cart">Meu Carrinho</v-btn>
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
                    <v-btn depressed small :to="item.url">{{ item.title }}</v-btn>
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
                <v-list-item v-if="currentUserProvider == 'custom'">
                  <v-list-item-icon>
                    <v-icon>fas fa-user</v-icon>
                  </v-list-item-icon>

                  <v-list-item-content>
                    <v-btn depressed small to="/account/personal">Minha Conta</v-btn>
                  </v-list-item-content>
                </v-list-item>
                <v-list-item v-if="platformTutor">
                  <v-list-item-icon>
                    <v-icon>fas fa-graduation-cap</v-icon>
                  </v-list-item-icon>

                  <v-list-item-content>
                    <v-btn depressed small @click="changeToStudent">Estudar</v-btn>
                  </v-list-item-content>
                </v-list-item>
                <v-list-item v-else>
                  <v-list-item-icon>
                    <v-icon>fas fa-chalkboard-teacher</v-icon>
                  </v-list-item-icon>

                  <v-list-item-content>
                    <v-btn depressed small @click="changeToTutor">Ensinar</v-btn>
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
      <v-snackbar v-model="snackbar" timeout="2000">
        {{ text }}

        <template v-slot:action="{ attrs }">
          <v-btn color="primary" text v-bind="attrs" @click="snackbar = false"> Fechar </v-btn>
        </template>
      </v-snackbar>
    </v-container>
  </v-app-bar>
</template>

<script>
import { mapGetters } from 'vuex';

export default {
  name: 'Header',
  data: () => ({
    snackbar: false,
    items: [
      { title: 'Pesquisar', icon: 'fas fa-search', url: '/search' },
      { title: 'Meus Cursos', icon: 'fas fa-book', url: '/courses' },
      { title: 'Minhas Turmas', icon: 'fas fa-users', url: '/classes' },
      { title: 'Trilhas de Aprendizagem', icon: 'fas fa-hiking', url: '/paths' },
      { title: 'Exercícios', icon: 'fas fa-dumbbell', url: '/exercises' },
      { title: 'Fóruns', icon: 'fas fa-comments', url: '/foruns' },
      { title: 'Minhas Anotações', icon: 'fas fa-book-open', url: '/notes' },
    ],
    search: '',
  }),
  computed: {
    ...mapGetters('auth', ['currentUser', 'isAuthenticated']),
    ...mapGetters('profile', ['profilePicture']),
    ...mapGetters('common', ['student']),
    ...mapGetters('shopping', ['shoppingCartItemsNumber']),
    darkModeOn() {
      return this.$vuetify.theme.dark;
    },
    currentUserName() {
      return this.currentUser.attributes.name;
    },
    currentUserFamilyName() {
      return this.currentUser.attributes.family_name;
    },
    currentUserProvider() {
      if (this.currentUser.username.includes('Facebook')) {
        return 'fb';
      }
      if (this.currentUser.username.includes('Google')) {
        return 'ga';
      }
      return 'custom';
    },
    platformTutor() {
      return !this.student;
    },
    text() {
      return `Plataforma alterada para ${this.platformTutor ? 'Tutor' : 'Estudante'}`;
    },
  },
  methods: {
    logout() {
      this.$store.dispatch('auth/logout');
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
      localStorage.setItem('dark_theme', this.$vuetify.theme.dark.toString());
    },
    changeToTutor() {
      this.$store.dispatch('common/changeToTutor');
      this.snackbar = true;
    },
    changeToStudent() {
      this.$store.dispatch('common/changeToStudent');
      this.snackbar = true;
    },
    pushSearch() {
      this.$router.push({ path: '/search', query: { search: this.search } });
    },
    async getProfilePicture() {
      await this.$store.dispatch('profile/getProfilePicture');
    },
  },
  async created() {
    this.getProfilePicture();
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

.Tutor-avatar {
  border: 3px solid #1e88e5;
}
</style>
