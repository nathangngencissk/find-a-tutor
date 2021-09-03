<template>
  <v-container>
    <v-data-table
      :headers="headers"
      :items="payouts"
      hide-default-footer
      item-key="name"
      class="elevation-1"
      :items-per-page="itemsPerPage"
      :search="search"
    >
      <template v-slot:top>
        <v-toolbar flat>
          <v-toolbar-title>Remessas</v-toolbar-title>
          <v-divider class="mx-4" inset vertical></v-divider>
          <v-text-field v-model="search" label="Filtrar" class="mx-4"></v-text-field>
        </v-toolbar>
      </template>
      <template v-slot:item.approve="{ item }">
        <v-btn color="success" text @click="changePayoutStatus($event, item, 'APROVADO')"
          >Aprovar</v-btn
        >
      </template>
      <template v-slot:item.deny="{ item }">
        <v-btn color="error" text @click="changePayoutStatus($event, item, 'NEGADO')">Negar</v-btn>
      </template>
    </v-data-table>
    <v-overlay :value="loading">
      <v-progress-circular indeterminate size="64"></v-progress-circular>
    </v-overlay>
  </v-container>
</template>

<script>
import { getPayoutsForApproval, changePayoutStatus } from '@/graphql/queries';

export default {
  title: 'Remessas | Find a Tutor',
  data() {
    return {
      loading: true,
      search: '',
      payouts: [],
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
        { text: 'Valor (R$)', value: 'value', align: 'center' },
        { text: 'Status', value: 'status', align: 'center' },
        { text: 'Data', value: 'created_at', align: 'center' },
        { text: 'Aprovar', value: 'approve', sortable: false, align: 'center' },
        { text: 'Negar', value: 'deny', sortable: false, align: 'center' },
      ];
    },
  },
  methods: {
    getPayoutsForApproval() {
      this.$gqlClient
        .query({
          query: this.$gql(getPayoutsForApproval),
          fetchPolicy: 'network-only',
        })
        .then((response) => {
          const result = JSON.parse(response.data.getPayoutsForApproval);
          this.payouts = result;
          this.loading = false;
        });
    },
    changePayoutStatus(event, payout, status) {
      this.loading = true;
      this.$gqlClient
        .query({
          query: this.$gql(changePayoutStatus),
          fetchPolicy: 'network-only',
          variables: {
            id: payout.id,
            status,
            updated_at: this.$getFormattedDate(),
          },
        })
        // eslint-disable-next-line no-unused-vars
        .then((response) => {
          this.getPayoutsForApproval();
        });
    },
  },
  created() {
    this.getPayoutsForApproval();
  },
};
</script>
