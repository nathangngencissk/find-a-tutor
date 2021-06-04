<template>
  <v-container>
    <v-alert v-if="verification" border="top" color="green lighten-2" dark dismissible>
      Um código de verificação foi enviado ao seu email.
    </v-alert>
    <v-subheader> Email </v-subheader>
    <v-sheet elevation="1">
      <v-container>
        <validation-observer ref="observer" v-slot="{ invalid }">
          <form @submit.prevent="submit" class="mx-4">
            <validation-provider
              v-slot="{ errors }"
              name="email"
              rules="required|email"
              ref="email"
            >
              <v-text-field
                v-model="email"
                :error-messages="errors"
                label="E-mail"
                required
              ></v-text-field>
            </validation-provider>
            <validation-provider
              v-slot="{ errors }"
              name="confirmEmail"
              rules="required|email|confirmEmail:@email"
            >
              <v-text-field
                v-model="confirmEmail"
                :error-messages="errors"
                label="Confirme o E-mail"
                required
              ></v-text-field>
            </validation-provider>
            <v-text-field
              v-if="verification"
              v-model="verificationCode"
              label="Código de Verificação"
              required
            ></v-text-field>

            <v-btn
              color="success"
              class="mr-4"
              @click="updateUserPersonalInformation"
              :disabled="invalid"
              v-if="confirm"
            >
              Confirmar
            </v-btn>
            <v-btn v-else color="success" class="mr-4" @click="confirm" :disabled="invalid">
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
import { required, digits, email, max, regex } from 'vee-validate/dist/rules';
import { extend, ValidationObserver, ValidationProvider, setInteractionMode } from 'vee-validate';
import Snackbar from '@/components/Snackbar.vue';

setInteractionMode('eager');

extend('digits', {
  ...digits,
  message: '{_field_} needs to be {length} digits. ({_value_})',
});

extend('required', {
  ...required,
  message: '{_field_} can not be empty',
});

extend('max', {
  ...max,
  message: '{_field_} may not be greater than {length} characters',
});

extend('regex', {
  ...regex,
  message: '{_field_} {_value_} does not match {regex}',
});

extend('email', {
  ...email,
  message: 'Email tem que ser válido',
});

extend('confirmEmail', {
  params: ['target'],
  validate(value, { target }) {
    return value === target;
  },
  message: 'Emails não são iguais',
});

export default {
  name: 'Email',
  title: 'Minha Conta | Find a Tutor',
  components: {
    ValidationProvider,
    ValidationObserver,
    Snackbar,
  },
  data: () => ({
    email: '',
    confirmEmail: '',
    verification: false,
    verificationCode: '',
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
      this.email = '';
      this.confirmEmail = '';
      this.$refs.observer.reset();
    },
    async confirm() {
      await this.$store.dispatch('profile/updateProfileEmail', {
        email: this.email,
      });
    },
    async updateUserPersonalInformation() {
      await this.$store.dispatch('profile/confirmUpdateProfileEmail', {
        verificationCode: this.verificationCode,
      });
      this.verification = !this.verification;
    },
  },
};
</script>
