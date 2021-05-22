<template>
  <v-row justify="space-around">
    <v-col cols="12" md="4">
      <v-sheet elevation="12" class="my-8 mx-auto py-8 px-8">
        <v-form ref="form" v-model="valid" lazy-validation @submit.prevent="login">
          <v-text-field v-model="email" label="Username" required></v-text-field>
          <v-text-field
            v-model="password"
            label="Password"
            required
            :append-icon="show ? 'mdi-eye' : 'mdi-eye-off'"
            :type="show ? 'text' : 'password'"
            @click:append="show = !show"
          ></v-text-field>
        </v-form>

        <v-btn :disabled="!valid" color="success" class="mr-4" @click="login"> Login </v-btn>
      </v-sheet>
    </v-col>
  </v-row>
</template>

<script>
export default {
  name: 'Login',
  data() {
    return {
      email: '',
      password: '',
      valid: true,
      name: '',
      show: false,
      nameRules: [
        (v) => !!v || 'Name is required',
        (v) => (v && v.length <= 10) || 'Name must be less than 10 characters',
      ],
      emailRules: [
        (v) => !!v || 'E-mail is required',
        (v) => /.+@.+\..+/.test(v) || 'E-mail must be valid',
      ],
    };
  },
  methods: {
    async login() {
      await this.$store.dispatch('login', {
        email: this.$data.email,
        password: this.$data.password,
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
};
</script>
