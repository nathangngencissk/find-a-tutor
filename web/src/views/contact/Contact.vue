<template>
  <v-container>
    <v-row justify="center">
      <v-col xl="1" lg="2" md="2" sm="4" xs="4">
        <h1>Contato</h1>
      </v-col>
    </v-row>
    <v-row justify="center">
      <v-col xl="1" lg="2" md="2" sm="4" xs="4">
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
      <v-col xl="6" lg="6" md="8" sm="12" xs="12">
        <v-sheet elevation="1" class="pa-6">
          <validation-observer ref="observer" v-slot="{ invalid }">
            <form @submit.prevent="submit">
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
              <v-btn color="success" type="submit" :disabled="invalid" @click="submit"
                >Enviar</v-btn
              >
            </form>
          </validation-observer>
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
import { mapGetters } from 'vuex';
import { contactEmail } from '@/graphql/queries';

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
  title: 'Contato | Find a Tutor',
  data: () => ({
    subject: '',
    body: '',
    email: '',
    snackbar: false,
    text: `Sua mensagem foi enviada com sucesso!`,
  }),
  computed: {
    ...mapGetters('auth', ['currentUser']),
  },
  methods: {
    submit() {
      this.$refs.observer.validate();
      this.contactEmail();
    },
    clear() {
      this.subject = '';
      this.body = '';
      this.email = '';
      this.$refs.observer.reset();
    },
    contactEmail() {
      this.$gqlClient
        .query({
          query: this.$gql(contactEmail),
          fetchPolicy: 'network-only',
          variables: {
            user_id: this.currentUser.username,
            email: this.email,
            subject: this.subject,
            text: this.body,
          },
        })
        // eslint-disable-next-line no-unused-vars
        .then((response) => {
          this.clear();
          this.snackbar = true;
        });
    },
  },
};
</script>
