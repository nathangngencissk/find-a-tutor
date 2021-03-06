<template>
  <v-container>
    <v-subheader> Senha </v-subheader>
    <v-sheet elevation="1">
      <v-container>
        <validation-observer ref="observer" v-slot="{ invalid }">
          <form @submit.prevent="submit" class="mx-4">
            <validation-provider v-slot="{ errors }" name="senha antiga" rules="required">
              <v-text-field
                v-model="oldPassword"
                :error-messages="errors"
                label="Senha atual"
                required
                :append-icon="showOld ? 'mdi-eye' : 'mdi-eye-off'"
                :type="showOld ? 'text' : 'password'"
                @click:append="showOld = !showOld"
              ></v-text-field>
            </validation-provider>
            <validation-provider v-slot="{ errors }" name="nova senha" rules="required|min:8">
              <v-text-field
                v-model="newPassword"
                :error-messages="errors"
                label="Senha nova"
                required
                :append-icon="showNew ? 'mdi-eye' : 'mdi-eye-off'"
                :type="showNew ? 'text' : 'password'"
                @click:append="showNew = !showNew"
              ></v-text-field>
            </validation-provider>
            <validation-provider
              v-slot="{ errors }"
              name="confirmNewPassword"
              rules="required|min:8|confirmPassword:@nova senha"
            >
              <v-text-field
                v-model="confirmNewPassword"
                :error-messages="errors"
                label="Confirme a senha nova"
                required
                :append-icon="showNewConfirm ? 'mdi-eye' : 'mdi-eye-off'"
                :type="showNewConfirm ? 'text' : 'password'"
                @click:append="showNewConfirm = !showNewConfirm"
              ></v-text-field>
            </validation-provider>
            <v-btn color="success" class="mr-4" @click="updateUserPassword" :disabled="invalid">
              Salvar
            </v-btn>
            <v-btn color="error" outlined @click="clear"> Limpar </v-btn>
          </form>
        </validation-observer>
      </v-container>
    </v-sheet>
    <v-snackbar v-model="snackbar" timeout="5000">
      {{ text }}

      <template v-slot:action="{ attrs }">
        <v-btn color="blue" text v-bind="attrs" @click="snackbar = false"> Fechar </v-btn>
      </template>
    </v-snackbar>
    <v-overlay :value="overlay">
      <v-progress-circular indeterminate size="64"></v-progress-circular>
    </v-overlay>
  </v-container>
</template>

<script>
import { required, min } from 'vee-validate/dist/rules';
import { extend, ValidationObserver, ValidationProvider, setInteractionMode } from 'vee-validate';

setInteractionMode('eager');

extend('required', {
  ...required,
  message: '{_field_} can not be empty',
});

extend('min', {
  ...min,
  message: '{_field_} precisa ter no mínimo {length} caracteres',
});

extend('confirmPassword', {
  params: ['target'],
  validate(value, { target }) {
    return value === target;
  },
  message: 'Senhas não são iguais',
});

export default {
  name: 'Password',
  title: 'Minha Conta | Find a Tutor',
  components: {
    ValidationProvider,
    ValidationObserver,
  },
  data: () => ({
    oldPassword: '',
    newPassword: '',
    confirmNewPassword: '',
    showOld: false,
    showNew: false,
    showNewConfirm: false,
    snackbar: false,
    text: 'Sua senha foi alterada com sucesso!',
    overlay: false,
  }),
  computed: {
    updateSuccess() {
      return this.$store.getters['profile/updateSuccess'];
    },
    showSuccess() {
      return !!this.$store.getters['profile/updateSuccess'];
    },
    updateError() {
      return this.$store.getters['profile/updateError'];
    },
    showError() {
      return !!this.$store.getters['profile/updateError'];
    },
  },
  methods: {
    submit() {
      this.$refs.observer.validate();
    },
    clear() {
      this.oldPassword = '';
      this.newPassword = '';
      this.confirmNewPassword = '';
      this.$refs.observer.reset();
    },
    async updateUserPassword() {
      this.overlay = !this.overlay;
      await this.$store.dispatch('profile/updateProfilePassword', {
        oldPassword: this.oldPassword,
        newPassword: this.newPassword,
      });
      this.overlay = !this.overlay;
      this.snackbar = true;
      this.clear();
    },
  },
};
</script>
