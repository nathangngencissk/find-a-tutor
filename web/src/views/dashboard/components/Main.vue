<template>
  <v-container id="dashboard" fluid tag="section" class="mt-3">
    <v-row class="mb-4">
      <v-col cols="12" lg="4">
        <base-material-chart-card
          :data="sumPerMonth.data"
          :options="sumPerMonth.options"
          :responsive-options="sumPerMonth.responsiveOptions"
          color="primary"
          hover-reveal
          type="Bar"
        >
          <template v-slot:reveal-actions>
            <v-tooltip bottom>
              <template v-slot:activator="{ attrs, on }">
                <v-btn v-bind="attrs" color="info" icon v-on="on">
                  <v-icon color="info"> mdi-refresh </v-icon>
                </v-btn>
              </template>

              <span>Refresh</span>
            </v-tooltip>

            <v-tooltip bottom>
              <template v-slot:activator="{ attrs, on }">
                <v-btn v-bind="attrs" light icon v-on="on">
                  <v-icon>mdi-pencil</v-icon>
                </v-btn>
              </template>

              <span>Change Date</span>
            </v-tooltip>
          </template>

          <h4 class="card-title font-weight-light mt-2 ml-2">Visitas dos cursos</h4>

          <p class="d-inline-flex font-weight-light ml-2 mt-1">Performance do último ano</p>

          <template v-slot:actions>
            <v-icon class="mr-1" small> mdi-clock-outline </v-icon>
            <span class="caption grey--text font-weight-light">Atualizado 10 minutos atrás</span>
          </template>
        </base-material-chart-card>
      </v-col>

      <v-col cols="12" lg="4">
        <base-material-chart-card
          :data="countPerMonth.data"
          :options="countPerMonth.options"
          color="success"
          hover-reveal
          type="Line"
        >
          <template v-slot:reveal-actions>
            <v-tooltip bottom>
              <template v-slot:activator="{ attrs, on }">
                <v-btn v-bind="attrs" color="info" icon v-on="on">
                  <v-icon color="info"> mdi-refresh </v-icon>
                </v-btn>
              </template>

              <span>Refresh</span>
            </v-tooltip>

            <v-tooltip bottom>
              <template v-slot:activator="{ attrs, on }">
                <v-btn v-bind="attrs" light icon v-on="on">
                  <v-icon>mdi-pencil</v-icon>
                </v-btn>
              </template>

              <span>Change Date</span>
            </v-tooltip>
          </template>

          <h4 class="card-title font-weight-light mt-2 ml-2">Vendas diárias</h4>

          <p class="d-inline-flex font-weight-light ml-2 mt-1">
            <v-icon color="green" small> mdi-arrow-up </v-icon>
            <span class="green--text mr-2">55%</span>&nbsp; de aumento no total semanal
          </p>

          <template v-slot:actions>
            <v-icon class="mr-1" small> mdi-clock-outline </v-icon>
            <span class="caption grey--text font-weight-light">Atualizado 5 minutos atrás</span>
          </template>
        </base-material-chart-card>
      </v-col>

      <v-col cols="12" lg="4">
        <base-material-chart-card
          :data="avgRatingPerMonth.data"
          :options="avgRatingPerMonth.options"
          hover-reveal
          color="orange darken-3"
          type="Line"
        >
          <template v-slot:reveal-actions>
            <v-tooltip bottom>
              <template v-slot:activator="{ attrs, on }">
                <v-btn v-bind="attrs" color="info" icon v-on="on">
                  <v-icon color="info"> mdi-refresh </v-icon>
                </v-btn>
              </template>

              <span>Refresh</span>
            </v-tooltip>

            <v-tooltip bottom>
              <template v-slot:activator="{ attrs, on }">
                <v-btn v-bind="attrs" light icon v-on="on">
                  <v-icon>mdi-pencil</v-icon>
                </v-btn>
              </template>

              <span>Change Date</span>
            </v-tooltip>
          </template>

          <h3 class="card-title font-weight-light mt-2 ml-2">Média de avaliações</h3>

          <p class="d-inline-flex font-weight-light ml-2 mt-1">Média semanal</p>

          <template v-slot:actions>
            <v-icon class="mr-1" small> mdi-clock-outline </v-icon>
            <span class="caption grey--text font-weight-light">Atualizado 10 minutos atrás</span>
          </template>
        </base-material-chart-card>
      </v-col>

      <v-col cols="12" sm="6" lg="3">
        <base-material-stats-card
          color="info"
          icon="fas fa-user-graduate"
          title="Alunos"
          :value="totalUsers"
          sub-icon="mdi-clock"
          sub-text="Atualizado agora"
        />
      </v-col>

      <v-col cols="12" sm="6" lg="3">
        <base-material-stats-card
          color="primary"
          icon="mdi-poll"
          title="Total de cursos vendidos"
          :value="totalCount"
          sub-icon="mdi-calendar"
          sub-text="Último mês"
        />
      </v-col>

      <v-col cols="12" sm="6" lg="3">
        <base-material-stats-card
          color="success"
          icon="mdi-store"
          title="Ganhos"
          :value="'R$ ' + totalSum"
          sub-icon="mdi-calendar"
          sub-text="Último mês"
        />
      </v-col>

      <v-col cols="12" sm="6" lg="3">
        <base-material-stats-card
          color="orange"
          icon="fas fa-star"
          title="Média de avaliações"
          :value="lastAverage"
          sub-icon="mdi-clock"
          sub-text="Atualizado agora"
        />
      </v-col>
      <v-overlay :value="overlay">
        <v-progress-circular indeterminate size="64"></v-progress-circular>
      </v-overlay>
    </v-row>
  </v-container>
</template>

<script>
import { mapGetters } from 'vuex';
import { getDashboardData } from '@/graphql/queries';

export default {
  name: 'DashboardDashboard',

  data() {
    return {
      overlay: true,
      totalCount: '0',
      totalUsers: '0',
      totalSum: '0',
      lastAverage: '5',
      countPerMonth: {
        data: {
          labels: [],
          series: [[]],
        },
        options: {
          lineSmooth: this.$chartist.Interpolation.cardinal({
            tension: 0,
          }),
          low: 0,
          high: 50, // creative tim: we recommend you to set the high sa the biggest value + something for a better look
          chartPadding: {
            top: 0,
            right: 0,
            bottom: 0,
            left: 0,
          },
        },
      },
      avgRatingPerMonth: {
        data: {
          labels: [],
          series: [[]],
        },
        options: {
          lineSmooth: this.$chartist.Interpolation.cardinal({
            tension: 0,
          }),
          low: 0,
          high: 5, // creative tim: we recommend you to set the high sa the biggest value + something for a better look
          chartPadding: {
            top: 0,
            right: 0,
            bottom: 0,
            left: 0,
          },
        },
      },
      sumPerMonth: {
        data: {
          labels: [],
          series: [[]],
        },
        options: {
          axisX: {
            showGrid: false,
          },
          low: 0,
          high: 1600,
          chartPadding: {
            top: 0,
            right: 5,
            bottom: 0,
            left: 0,
          },
        },
        responsiveOptions: [
          [
            'screen and (max-width: 640px)',
            {
              seriesBarDistance: 5,
              axisX: {
                labelInterpolationFnc(value) {
                  return value[0];
                },
              },
            },
          ],
        ],
      },
    };
  },

  methods: {
    getDashboardData() {
      this.$gqlClient
        .query({
          query: this.$gql(getDashboardData),
          fetchPolicy: 'network-only',
          variables: { user_id: this.currentUser.username },
        })
        .then((response) => {
          const result = JSON.parse(response.data.getDashboardData);
          this.totalCount = result.total_count.toString();
          this.totalSum = result.total_sum.toString();
          this.totalUsers = result.total_users[0].count.toString();
          this.lastAverage = result.last_average.toString();
          result.sum_per_month.forEach((month) => {
            this.sumPerMonth.data.labels.push(month.month_name);
            this.sumPerMonth.data.series[0].push(month.total_month);
          });
          result.avg_rating_per_month.forEach((month) => {
            this.avgRatingPerMonth.data.labels.push(month.month_name);
            this.avgRatingPerMonth.data.series[0].push(month.cum_amt);
          });
          result.count_per_month.forEach((month) => {
            this.countPerMonth.data.labels.push(month.month_name);
            this.countPerMonth.data.series[0].push(month.count_month);
          });
          this.overlay = false;
        });
    },
  },
  computed: {
    ...mapGetters('auth', ['currentUser']),
  },
  created() {
    this.getDashboardData();
  },
};
</script>
