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
                  @keydown.enter="pushSearch"
                  filled
                  v-if="isAuthenticated"
                ></v-text-field>
              </v-col>
            </v-row>
          </v-container>
        </v-col>

        <v-col cols="3" xl="3" class="d-none d-xl-flex">
          <v-row align="center" justify="space-around">
            <v-btn
              color="primaryText"
              plain
              :to="{ name: 'DashboardMain' }"
              v-if="platformTutor && isAuthenticated"
            >
              <span>Painel</span>
            </v-btn>

            <v-btn color="primaryText" plain to="/courses" v-if="!platformTutor && isAuthenticated">
              <span>Meus Cursos</span>
            </v-btn>

            <v-btn color="primaryText" plain to="/foruns" v-if="isAuthenticated">
              <span>Fóruns</span>
            </v-btn>

            <v-btn color="primaryText" plain to="/notes" v-if="platformTutor && isAuthenticated">
              <span>Minhas Anotações</span>
            </v-btn>

            <v-btn
              color="primaryText"
              plain
              to="/exercises"
              v-if="!platformTutor && isAuthenticated"
            >
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
            <v-list dense>
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
                <v-list-item v-if="isAdmin">
                  <v-list-item-content>
                    <v-btn depressed title text class="btn-contexto" :to="{ name: 'AdminMain' }">
                      <v-icon class="mr-2">fas fa-user-cog</v-icon> Admin</v-btn
                    >
                  </v-list-item-content>
                </v-list-item>

                <v-list-item v-if="platformTutor">
                  <v-list-item-content>
                    <v-btn
                      depressed
                      title
                      text
                      class="btn-contexto"
                      :to="{ name: 'DashboardMain' }"
                    >
                      <v-icon class="mr-2">fas fa-pencil-ruler</v-icon> Painel</v-btn
                    >
                  </v-list-item-content>
                </v-list-item>

                <v-list-item>
                  <v-list-item-content class="content-carrinho">
                    <v-btn depressed title text class="btn-contexto" to="/cart">
                      <v-badge
                        v-if="parseInt(shoppingCartItemsNumber) > 0"
                        color="primary"
                        :content="shoppingCartItemsNumber"
                      >
                        <v-icon class="mr-2">fas fa-shopping-cart</v-icon>
                      </v-badge>
                      <v-icon class="mr-2" v-else>fas fa-shopping-cart</v-icon> Meu Carrinho</v-btn
                    >
                  </v-list-item-content>
                </v-list-item>
              </v-list>
              <v-divider></v-divider>
              <v-list>
                <v-list-item v-for="item in items" :key="item.title">
                  <v-list-item-content>
                    <v-btn depressed title text class="btn-contexto" :to="item.url">
                      <v-icon class="mr-2">{{ item.icon }}</v-icon> {{ item.title }}</v-btn
                    >
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
                  <v-list-item-content>
                    <v-btn depressed title text class="btn-contexto" to="/account/personal">
                      <v-icon class="mr-2">fas fa-user</v-icon> Minha Conta</v-btn
                    >
                  </v-list-item-content>
                </v-list-item>
                <v-list-item v-if="platformTutor">
                  <v-list-item-content>
                    <v-btn depressed title text class="btn-contexto" @click="changeToStudent">
                      <v-icon class="mr-2">fas fa-graduation-cap</v-icon> Estudar</v-btn
                    >
                  </v-list-item-content>
                </v-list-item>
                <v-list-item v-else>
                  <v-list-item-content>
                    <v-btn depressed title text class="btn-contexto" @click="changeToTutor">
                      <v-icon class="mr-2">fas fa-chalkboard-teacher</v-icon> Ensinar</v-btn
                    >
                  </v-list-item-content>
                </v-list-item>
              </v-list>
              <v-divider></v-divider>
              <v-list-item @click="logout" class="mx-auto">
                <v-list-item-content>
                  <v-btn depressed title text class="btn-contexto">
                    <v-icon class="mr-2">fas fa-sign-out-alt</v-icon> Sair</v-btn
                  >
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
    isAdmin() {
      return parseInt(this.currentUser.attributes['custom:admin'], 10) === 1;
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
    async changeToTutor() {
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

.btn-contexto {
  justify-content: initial;
  padding: 2px;
}

.btn-contexto:hover {
  border-bottom: 3px solid #2196f3;
}

.content-carrinho {
  padding-top: 12px !important;
}
</style>
