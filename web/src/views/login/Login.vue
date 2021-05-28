<template>
  <v-container>
    <v-row justify="space-around">
      <v-col cols="12" md="4">
        <v-sheet elevation="12" class="my-8 mx-auto py-8 px-8">
          <v-form ref="form" v-model="valid" lazy-validation @submit.prevent="login">
            <v-text-field v-model="email" label="Email" :rules="emailRules" required></v-text-field>
            <v-text-field
              v-model="password"
              label="Senha"
              required
              :append-icon="show ? 'mdi-eye' : 'mdi-eye-off'"
              :type="show ? 'text' : 'password'"
              :rules="passwordRules"
              @click:append="show = !show"
            ></v-text-field>
          </v-form>
          <v-row>
            <v-col cols="12" class="d-flex justify-center">
              <v-btn :disabled="!valid" color="success" class="mr-4" @click="login"> Entrar </v-btn>
            </v-col>
          </v-row>
          <v-row>
            <v-col cols="12" class="d-flex justify-center">
              <v-btn color="primary" to="/register">Registrar</v-btn>
            </v-col>
          </v-row>
          <v-row>
            <v-col cols="12" class="d-flex justify-center">
              <v-btn class="blue--text" color="white" outlined depressed tex @click="loginGoogle"
                ><v-icon class="my-2 mr-2">fab fa-google</v-icon> Google</v-btn
              >
            </v-col>
          </v-row>
          <v-row>
            <v-col cols="12" class="d-flex justify-center">
              <v-btn class="white--text" color="#4867aa" depressed @click="loginFacebook"
                ><v-icon class="my-2 mr-2">fab fa-facebook</v-icon> Facebook</v-btn
              >
            </v-col>
          </v-row>
        </v-sheet>
        <v-overlay :value="overlay">
          <v-progress-circular indeterminate size="64"></v-progress-circular>
        </v-overlay>
      </v-col>
    </v-row>
    <Snackbar :text="this.loginError" timeout="5000" :show="this.showError" />
  </v-container>
</template>

<script>
import { Auth } from 'aws-amplify';
import Snackbar from '@/components/Snackbar.vue';

export default {
  name: 'Login',
  title: 'Login | Find A Tutor',
  data() {
    return {
      overlay: false,
      email: '',
      password: '',
      valid: true,
      name: '',
      show: false,
      emailRules: [
        (v) => !!v || 'E-mail é necessário',
        (v) => /.+@.+\..+/.test(v) || 'E-mail tem que ser válido',
      ],
      passwordRules: [
        (v) => !!v || 'Senha é necessária',
        (v) => (v && v.length >= 8) || 'Senha deve ter no mínimo 8 caracteres',
      ],
    };
  },
  computed: {
    loginError() {
      return this.$store.getters['auth/loginError'];
    },
    showError() {
      return !!this.$store.getters['auth/loginError'];
    },
  },
  components: { Snackbar },
  methods: {
    async login() {
      this.validate();
      if (this.email && this.password) {
        this.overlay = !this.overlay;
        await this.$store.dispatch('auth/login', {
          email: this.$data.email,
          password: this.$data.password,
        });
        this.overlay = !this.overlay;
      }
    },
    validate() {
      this.$refs.form.validate();
    },
    reset() {
      this.$refs.form.reset();
    },
    resetValidation() {
      this.$refs.form.resetValidation();
    },
    loginGoogle() {
      Auth.federatedSignIn({ provider: 'Google' });
    },
    loginFacebook() {
      Auth.federatedSignIn({ provider: 'Facebook' });
    },
  },
};
</script>
