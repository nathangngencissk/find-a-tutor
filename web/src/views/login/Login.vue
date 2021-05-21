<template>
  <div class="container">
    <form @submit.prevent="login">
      <h2>Login</h2>
      <input type="text" v-model="email" placeholder="Email address..." />
      <input type="password" v-model="password" placeholder="password..." />
      <button>Login</button>
    </form>
  </div>
</template>

<script>
export default {
  name: 'Login',
  data() {
    return {
      email: '',
      password: '',
    };
  },
  methods: {
    async login() {
      await this.$store.dispatch('login', {
        email: this.$data.email,
        password: this.$data.password,
      });
    },
  },
};
</script>
