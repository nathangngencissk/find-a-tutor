<template>
  <v-container>
    <v-data-table
      :headers="headers"
      :items="payments"
      hide-default-footer
      item-key="name"
      class="elevation-1"
      :items-per-page="itemsPerPage"
      :search="search"
    >
      <template v-slot:top>
        <v-toolbar flat>
          <v-toolbar-title>Pagamentos</v-toolbar-title>
          <v-divider class="mx-4" inset vertical></v-divider>
          <v-text-field v-model="search" label="Filtrar" class="mx-4"></v-text-field>
        </v-toolbar>
      </template>
      <template v-slot:item.confirm="{ item }">
        <v-btn
          color="primary"
          text
          @click="confirmPayment($event, item)"
          v-if="item.status !== 'APPROVED'"
          >Atualizar</v-btn
        >
      </template>
    </v-data-table>
    <v-overlay :value="loading">
      <v-progress-circular indeterminate size="64"></v-progress-circular>
    </v-overlay>
  </v-container>
</template>

<script>
import { getPayments, confirmPayment } from '@/graphql/queries';

export default {
  title: 'Pagamentos | Find a Tutor',
  data() {
    return {
      loading: true,
      search: '',
      payments: [],
      itemsPerPage: -1,
    };
  },
  computed: {
    headers() {
      return [
        {
          text: 'Usuário',
          align: 'start',
          value: 'user_id',
        },
        { text: 'Pedido', value: 'order_id', align: 'center' },
        { text: 'Valor (R$)', value: 'value', align: 'center' },
        { text: 'Status', value: 'status', align: 'center' },
        { text: 'Data', value: 'created_at', align: 'center' },
        { text: 'Verificar', value: 'confirm', sortable: false, align: 'center' },
      ];
    },
  },
  methods: {
    getPayments() {
      this.$gqlClient
        .query({
          query: this.$gql(getPayments),
          fetchPolicy: 'network-only',
        })
        .then((response) => {
          const result = JSON.parse(response.data.getPayments);
          this.payments = result;
          this.loading = false;
        });
    },
    confirmPayment(event, payment) {
      this.loading = true;
      this.$gqlClient
        .query({
          query: this.$gql(confirmPayment),
          fetchPolicy: 'network-only',
          variables: {
            id: payment.id,
            order_id: payment.order_id,
            user_id: payment.user_id,
          },
        })
        // eslint-disable-next-line no-unused-vars
        .then((response) => {
          this.getPayments();
        });
    },
  },
  created() {
    this.getPayments();
  },
};
</script>
