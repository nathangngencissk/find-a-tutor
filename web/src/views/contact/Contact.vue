<template>
  <v-container>
    <v-row justify="center">
      <v-col cols="1" xl="1" lg="2" md="2" sm="4">
        <h1>Contato</h1>
      </v-col>
    </v-row>
    <v-row justify="center">
      <v-col cols="1" xl="1" lg="2" md="2" sm="4">
        <v-img
          :aspect-ratio="16 / 9"
          max-height="200"
          max-width="200"
          min-width="120"
          min-height="100"
          src="@/assets/main-logo.png"
          id="main_logo"
        ></v-img>
      </v-col>
    </v-row>
    <v-row justify="center">
      <v-col cols="6">
        <v-sheet elevation="1" class="pa-6">
          <validation-observer ref="observer" v-slot="{ invalid }">
            <form>
              <h2>Email</h2>
              <validation-provider v-slot="{ errors }" name="email" rules="required|email">
                <v-text-field
                  v-model="email"
                  :error-messages="errors"
                  label="E-mail"
                  required
                ></v-text-field>
              </validation-provider>
              <h2>Assunto</h2>
              <v-text-field label="Assunto" placeholder="Assunto" v-model="subject"></v-text-field>
              <h2>Mensagem</h2>
              <v-textarea outlined name="input-7-4" label="Mensagem" v-model="body"></v-textarea>
            </form>
          </validation-observer>
          <v-btn color="success" @click="clear">Enviar</v-btn>
        </v-sheet>
      </v-col>
    </v-row>
    <v-snackbar v-model="snackbar">
      {{ text }}

      <template v-slot:action="{ attrs }">
        <v-btn color="primary" text v-bind="attrs" @click="snackbar = false"> Fechar </v-btn>
      </template>
    </v-snackbar>
  </v-container>
</template>

<script>
import { required, email } from 'vee-validate/dist/rules';
import { extend, ValidationObserver, ValidationProvider, setInteractionMode } from 'vee-validate';

setInteractionMode('eager');

extend('required', {
  ...required,
  message: '{_field_} não pod estar vazio',
});

extend('email', {
  ...email,
  message: 'Email deve ser válido',
});

export default {
  components: {
    ValidationProvider,
    ValidationObserver,
  },
  data: () => ({
    subject: '',
    body: '',
    email: '',
    snackbar: false,
    text: `Sua mensagem foi enviada com sucesso!`,
  }),

  methods: {
    submit() {
      this.$refs.observer.validate();
    },
    clear() {
      this.subject = '';
      this.body = '';
      this.email = '';
      this.$refs.observer.reset();
      this.snackbar = true;
    },
  },
};
</script>
