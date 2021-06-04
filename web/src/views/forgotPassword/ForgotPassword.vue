<template>
  <v-container>
    <v-alert border="top" color="green lighten-2" v-if="forgotPasswordSubmitState" dark dismissible>
      Um código de verificação foi enviado ao seu email.
    </v-alert>
    <v-row justify="space-around">
      <v-col cols="12" md="4">
        <v-sheet elevation="12" class="my-8 mx-auto py-8 px-8">
          <validation-observer ref="observer">
            <v-form ref="form" lazy-validation @submit.prevent="submit">
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
                v-if="forgotPasswordSubmitState"
                v-slot="{ errors }"
                name="password"
                rules="required|min:8"
              >
                <v-text-field
                  v-model="password"
                  :error-messages="errors"
                  label="Senha nova"
                  required
                  :append-icon="show ? 'mdi-eye' : 'mdi-eye-off'"
                  :type="show ? 'text' : 'password'"
                  @click:append="show = !show"
                ></v-text-field>
              </validation-provider>
              <validation-provider
                v-if="forgotPasswordSubmitState"
                v-slot="{ errors }"
                name="passwordConfirm"
                rules="required|min:8|confirmPassword:@password"
              >
                <v-text-field
                  v-model="passwordConfirm"
                  :error-messages="errors"
                  label="Confirme a senha nova"
                  required
                  :append-icon="showPasswordConfirm ? 'mdi-eye' : 'mdi-eye-off'"
                  :type="showPasswordConfirm ? 'text' : 'password'"
                  @click:append="showPasswordConfirm = !showPasswordConfirm"
                ></v-text-field>
              </validation-provider>
              <v-text-field
                v-if="forgotPasswordSubmitState"
                v-model="verificationCode"
                label="Código de Verificação"
                required
              ></v-text-field>
            </v-form>
          </validation-observer>
          <v-btn
            color="success"
            v-if="forgotPasswordSubmitState"
            class="mr-4"
            @click="forgotPasswordSubmit"
            >Salvar</v-btn
          >
          <v-btn color="success" v-else class="mr-4" @click="forgotPassword">Enviar código</v-btn>
          <v-btn color="error" v-if="forgotPasswordSubmitState" outlined @click="clear">
            Limpar
          </v-btn>
        </v-sheet>
      </v-col>
    </v-row>
    <v-overlay :value="overlay">
      <v-progress-circular indeterminate size="64"></v-progress-circular>
    </v-overlay>
  </v-container>
</template>

<script>
import { required, min, email } from 'vee-validate/dist/rules';
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

extend('email', {
  ...email,
  message: 'Email tem que ser válido',
});

extend('confirmPassword', {
  params: ['target'],
  validate(value, { target }) {
    return value === target;
  },
  message: 'Senhas não são iguais',
});

export default {
  name: 'ForgotPassword',
  title: 'Esqueci minha senha | Find A Tutor',
  components: { ValidationObserver, ValidationProvider },
  data() {
    return {
      overlay: false,
      email: '',
      password: '',
      passwordConfirm: '',
      verificationCode: '',
      show: false,
      showPasswordConfirm: false,
    };
  },
  methods: {
    submit() {
      this.$refs.observer.validate();
    },
    clear() {
      this.password = '';
      this.passwordConfirm = '';
      this.$refs.observer.reset();
    },
    async forgotPassword() {
      await this.$store.dispatch('auth/forgotPassword', {
        username: this.email,
      });
    },
    async forgotPasswordSubmit() {
      this.overlay = !this.overlay;
      await this.$store.dispatch('auth/forgotPasswordSubmit', {
        username: this.email,
        code: this.verificationCode,
        new_password: this.password,
      });
      this.overlay = !this.overlay;
      this.clear();
    },
  },
  computed: {
    forgotPasswordSubmitState() {
      return this.$store.getters['auth/forgotPasswordSubmit'];
    },
  },
};
</script>
