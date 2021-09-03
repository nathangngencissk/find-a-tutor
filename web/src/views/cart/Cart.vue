<template>
  <v-container>
    <v-row justify="center">
      <v-col xl="6" lg="8" md="12" sm="12" xs="12" class="mt-4" v-if="shoppingCart.length > 0">
        <CourseCardShort v-for="course in shoppingCart" :key="course.id" :course="course" />
      </v-col>
      <v-col xl="6" lg="8" md="12" sm="12" xs="12" class="mt-4" v-else>
        <h2 class="header-2">Seu carrinho está vazio, por favor adicione cursos para continuar.</h2>
      </v-col>
      <v-col xl="3" lg="4" md="12" sm="12" xs="12">
        <v-card width="350">
          <v-subheader> Total:</v-subheader>
          <h1 class="ml-5">R$ {{ cartTotal }},00</h1>
          <v-card-text class="text--primary">
            <div class="my-2">
              <v-btn
                x-large
                color="success"
                block
                @click="createPayment"
                v-if="shoppingCart.length > 0"
              >
                Finalizar
              </v-btn>
              <v-btn x-large color="success" block disabled v-else> Finalizar </v-btn>
            </div>
          </v-card-text>
        </v-card>
      </v-col>
      <v-overlay :value="overlay">
        <v-progress-circular indeterminate size="64"></v-progress-circular>
      </v-overlay>
    </v-row>
  </v-container>
</template>

<script>
import { mapGetters } from 'vuex';
import CourseCardShort from '@/components/CourseCardShort.vue';
import { createPayment } from '@/graphql/queries';

export default {
  name: 'Cart',

  title: 'Meu Carrinho | Find a Tutor',

  components: {
    CourseCardShort,
  },

  data: () => ({
    overlay: false,
  }),

  computed: {
    ...mapGetters('shopping', ['shoppingCart']),
    ...mapGetters('auth', ['currentUser']),
    cartTotal() {
      return this.shoppingCart.reduce((sum, obj) => sum + parseFloat(obj.price || 0), 0);
    },
  },

  methods: {
    createPayment() {
      this.overlay = true;
      const courses = [];
      this.shoppingCart.forEach((course) => {
        courses.push(parseInt(course.id, 10));
      });
      this.$gqlClient
        .query({
          query: this.$gql(createPayment),
          fetchPolicy: 'network-only',
          variables: {
            user_id: this.currentUser.username,
            value: this.cartTotal.toString(),
            courses,
          },
        })
        .then(async (response) => {
          const paymentLink = response.data.createPayment;
          await this.$store.dispatch('shopping/clearCart');
          this.overlay = false;
          window.open(paymentLink, '_blank');
          this.$router.push({ name: 'Home' }).catch((error) => {
            if (error.name !== 'NavigationDuplicated') {
              throw error;
            }
          });
        });
    },
  },
};
</script>
