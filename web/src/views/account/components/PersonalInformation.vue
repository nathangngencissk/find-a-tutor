<template>
  <v-container>
    <v-subheader> Informações Pessoais </v-subheader>
    <v-sheet elevation="1">
      <v-container>
        <validation-observer ref="observer" v-slot="{ invalid }">
          <form @submit.prevent="submit" class="mx-4">
            <validation-provider v-slot="{ errors }" name="Nome" rules="required|max:15">
              <v-text-field
                v-model="name"
                :counter="15"
                :error-messages="errors"
                label="Nome"
                required
              ></v-text-field>
            </validation-provider>
            <validation-provider v-slot="{ errors }" name="Sobrenome" rules="required|max:15">
              <v-text-field
                v-model="family_name"
                :counter="15"
                :error-messages="errors"
                label="Sobrenome"
                required
              ></v-text-field>
            </validation-provider>

            <v-btn
              color="success"
              class="mr-4"
              @click="updateUserPersonalInformation"
              :disabled="invalid"
            >
              Salvar
            </v-btn>
            <v-btn color="error" outlined @click="clear"> Limpar </v-btn>
          </form>
        </validation-observer>
      </v-container>
    </v-sheet>
    <v-snackbar v-model="show" timeout="5000">
      {{ text }}

      <template v-slot:action="{ attrs }">
        <v-btn color="blue" text v-bind="attrs" @click="show = false"> Fechar </v-btn>
      </template>
    </v-snackbar>
    <v-overlay :value="loading">
      <v-progress-circular indeterminate size="64"></v-progress-circular>
    </v-overlay>
  </v-container>
</template>

<script>
import { required, digits, max } from 'vee-validate/dist/rules';
import { extend, ValidationObserver, ValidationProvider, setInteractionMode } from 'vee-validate';

setInteractionMode('eager');

extend('digits', {
  ...digits,
  message: '{_field_} precisa ter {length} caracteres. ({_value_})',
});

extend('required', {
  ...required,
  message: '{_field_} não pode ficar vazio',
});

extend('max', {
  ...max,
  message: '{_field_} não pode ter mais que {length} caracteres',
});

export default {
  name: 'PersonalInformation',
  title: 'Minha Conta | Find a Tutor',
  components: {
    ValidationProvider,
    ValidationObserver,
  },
  data: () => ({
    name: '',
    family_name: '',
    show: false,
    loading: false,
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
    text() {
      return this.showSuccess ? this.updateSuccess : this.updateError;
    },
  },
  methods: {
    submit() {
      this.$refs.observer.validate();
    },
    clear() {
      this.name = '';
      this.family_name = '';
      this.$refs.observer.reset();
    },
    async updateUserPersonalInformation() {
      this.loading = !this.loading;
      await this.$store.dispatch('profile/updateProfilePersonalInformation', {
        name: this.name,
        family_name: this.family_name,
      });
      this.loading = !this.loading;
      this.show = true;
      this.clear();
    },
  },
};
</script>
