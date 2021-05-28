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
    <Snackbar :text="this.updateSuccess" timeout="5000" :show="this.showSuccess" />
    <Snackbar :text="this.updateError" timeout="5000" :show="this.showError" />
  </v-container>
</template>

<script>
import { required, digits, max } from 'vee-validate/dist/rules';
import { extend, ValidationObserver, ValidationProvider, setInteractionMode } from 'vee-validate';
import Snackbar from '@/components/Snackbar.vue';

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
    Snackbar,
  },
  data: () => ({
    name: '',
    family_name: '',
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
      this.name = '';
      this.family_name = '';
      this.$refs.observer.reset();
    },
    async updateUserPersonalInformation() {
      this.overlay = !this.overlay;
      await this.$store.dispatch('profile/updateProfilePersonalInformation', {
        name: this.name,
        family_name: this.family_name,
      });
      this.overlay = !this.overlay;
      this.clear();
    },
  },
};
</script>
