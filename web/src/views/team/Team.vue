<template>
  <v-container>
    <v-row justify="center">
      <v-col xl="2" lg="2" md="3" sm="3" xs="4">
        <h1>Time Find a Tutor</h1>
      </v-col>
    </v-row>
    <v-row justify="center">
      <v-col xl="2" lg="2" md="3" sm="3" xs="4">
        <v-img
          :aspect-ratio="16 / 9"
          max-height="200"
          max-width="200"
          min-width="120"
          min-height="100"
          src="@/assets/main-logo.png"
          id="main_logo"
        ></v-img>
      </v-col>
    </v-row>
    <v-row justify="center">
      <v-col xs="12" sm="8" md="8" lg="4" xl="4">
        <v-row>
          <v-col xs="12" sm="12" md="6" lg="6" xl="4">
            <v-avatar color="green lighten-2" size="150">
              <span class="white--text text-h5">GR</span>
            </v-avatar>
          </v-col>
          <v-col xs="12" sm="12" md="6" lg="6" xl="8">
            <h2>CEO</h2>
            <p>Guilherme Ruiz de Assis</p>
          </v-col>
        </v-row>
      </v-col>
      <v-col xs="12" sm="8" md="8" lg="4" xl="4">
        <v-row>
          <v-col xs="12" sm="12" md="6" lg="6" xl="4">
            <v-avatar color="indigo" size="150">
              <span class="white--text text-h5">NG</span>
            </v-avatar>
          </v-col>
          <v-col xs="12" sm="12" md="6" lg="6" xl="8">
            <h2>CTO</h2>
            <p>Nathan George Nascimento Gencissk</p>
          </v-col>
        </v-row>
      </v-col>
    </v-row>
    <v-row justify="center">
      <v-col xs="12" sm="8" md="8" lg="4" xl="4">
        <v-row>
          <v-col xs="12" sm="12" md="6" lg="6" xl="4">
            <v-avatar color="red lighten-2" size="150">
              <span class="white--text text-h5">KR</span>
            </v-avatar>
          </v-col>
          <v-col xs="12" sm="12" md="6" lg="6" xl="8">
            <h2>COO</h2>
            <p>Kamila Reis</p>
          </v-col>
        </v-row>
      </v-col>
      <v-col xs="12" sm="8" md="8" lg="4" xl="4">
        <v-row>
          <v-col xs="12" sm="12" md="6" lg="6" xl="4">
            <v-avatar color="orange" size="150">
              <span class="white--text text-h5">VP</span>
            </v-avatar>
          </v-col>
          <v-col xs="12" sm="12" md="6" lg="6" xl="8">
            <h2>CDO</h2>
            <p>Vinícius Peters</p>
          </v-col>
        </v-row>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
export default {
  title: 'Time | Find a Tutor',
};
</script>
