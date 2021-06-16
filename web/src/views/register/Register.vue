<template>
  <v-container>
    <v-alert v-if="verification" border="top" color="green lighten-2" dark dismissible>
      Um código de verificação foi enviado ao seu email.
    </v-alert>
    <v-row justify="space-around">
      <v-col cols="12" xl="6" lg="6">
        <v-sheet elevation="12" class="my-8 mx-auto py-8 px-8">
          <v-form ref="form" v-model="valid" lazy-validation @submit.prevent="login">
            <v-text-field
              v-model="email"
              :rules="emailRules"
              label="E-mail"
              required
            ></v-text-field>
            <v-text-field v-model="name" :rules="nameRules" label="Nome" required></v-text-field>
            <v-text-field v-model="family_name" label="Sobrenome" required></v-text-field>
            <v-text-field
              v-model="password"
              label="Senha"
              required
              :rules="passwordRules"
              :append-icon="show ? 'mdi-eye' : 'mdi-eye-off'"
              :type="show ? 'text' : 'password'"
              @click:append="show = !show"
            ></v-text-field>
            <v-text-field
              v-if="verification"
              v-model="verificationCode"
              label="Código de Verificação"
              required
            ></v-text-field>
          </v-form>

          <v-btn v-if="verification" color="success" @click="confirm">Registrar</v-btn>
          <v-btn v-else color="primary" @click="signup">Registrar</v-btn>
        </v-sheet>
      </v-col>
    </v-row>
    <Snackbar :text="this.signupError" timeout="10000" :show="showSignupError" />
    <Snackbar :text="this.confirmError" timeout="5000" :show="showConfirmError" />
  </v-container>
</template>

<script>
import Snackbar from '@/components/Snackbar.vue';

export default {
  name: 'Register',
  title: 'Registrar | Find A Tutor',
  components: { Snackbar },
  data() {
    return {
      overlay: false,
      email: '',
      password: '',
      name: '',
      family_name: '',
      valid: true,
      show: false,
      verificationCode: '',
      nameRules: [
        (v) => !!v || 'Nome é necessário',
        (v) => (v && v.length <= 20) || 'Nome deve ter no máximo 20 caracteres',
      ],
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
  methods: {
    async signup() {
      this.overlay = !this.overlay;
      await this.$store.dispatch('auth/signup', {
        email: this.$data.email,
        password: this.$data.password,
        name: this.$data.name,
        family_name: this.$data.family_name,
      });
      this.overlay = !this.overlay;
    },
    async confirm() {
      this.overlay = !this.overlay;
      await this.$store.dispatch('auth/confirm', {
        username: this.$data.email,
        code: this.$data.verificationCode,
      });
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
  },
  computed: {
    verification() {
      return this.$store.getters['auth/verification'];
    },
    signupError() {
      return this.$store.getters['auth/signupError'];
    },
    confirmError() {
      return this.$store.getters['auth/confirmError'];
    },
    showSignupError() {
      return !!this.$store.getters['auth/signupError'];
    },
    showConfirmError() {
      return !!this.$store.getters['auth/confirmError'];
    },
  },
};
</script>
