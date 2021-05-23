<template>
  <div>
    <v-alert v-if="verification" border="top" color="green lighten-2" dark dismissible>
      Um código de verificação foi enviado ao seu email.
    </v-alert>
    <v-row justify="space-around">
      <v-col cols="12" md="4">
        <v-sheet elevation="12" class="my-8 mx-auto py-8 px-8">
          <v-form ref="form" v-model="valid" lazy-validation @submit.prevent="login">
            <v-text-field v-model="username" label="Usuário" required></v-text-field>
            <v-text-field
              v-model="email"
              :rules="emailRules"
              label="E-mail"
              required
            ></v-text-field>
            <v-text-field
              v-model="password"
              label="Senha"
              required
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
  </div>
</template>

<script>
export default {
  name: 'Register',
  data() {
    return {
      overlay: false,
      email: '',
      password: '',
      valid: true,
      username: '',
      show: false,
      verificationCode: '',
      nameRules: [
        (v) => !!v || 'Username is required',
        (v) => (v && v.length <= 20) || 'Name must be less than 20 characters',
      ],
      emailRules: [
        (v) => !!v || 'E-mail is required',
        (v) => /.+@.+\..+/.test(v) || 'E-mail must be valid',
      ],
    };
  },
  methods: {
    async signup() {
      this.overlay = !this.overlay;
      await this.$store.dispatch('signup', {
        username: this.$data.username,
        email: this.$data.email,
        password: this.$data.password,
      });
      this.overlay = !this.overlay;
    },
    async confirm() {
      this.overlay = !this.overlay;
      await this.$store.dispatch('confirm', {
        username: this.$data.username,
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
      return this.$store.getters.verification;
    },
  },
};
</script>
