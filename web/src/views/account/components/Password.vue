<template>
  <v-container>
    <v-subheader> Email </v-subheader>
    <v-sheet elevation="1">
      <v-container>
        <validation-observer ref="observer" v-slot="{ invalid }">
          <form @submit.prevent="submit" class="mx-4">
            <validation-provider v-slot="{ errors }" name="oldPassword" rules="required">
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
            <validation-provider v-slot="{ errors }" name="newPassword" rules="required|min:8">
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
              rules="required|min:8|confirmPassword:@newPassword"
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
    <Snackbar :text="this.updateSuccess" timeout="5000" :show="this.showSuccess" />
    <Snackbar :text="this.updateError" timeout="5000" :show="this.showError" />
    <v-overlay :value="overlay">
      <v-progress-circular indeterminate size="64"></v-progress-circular>
    </v-overlay>
  </v-container>
</template>

<script>
import { required, min } from 'vee-validate/dist/rules';
import { extend, ValidationObserver, ValidationProvider, setInteractionMode } from 'vee-validate';
import Snackbar from '@/components/Snackbar.vue';

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
    Snackbar,
  },
  data: () => ({
    oldPassword: '',
    newPassword: '',
    confirmNewPassword: '',
    showOld: false,
    showNew: false,
    showNewConfirm: false,
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
      this.clear();
    },
  },
};
</script>
