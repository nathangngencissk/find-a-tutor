<template>
  <v-row justify="space-around" align="center">
    <v-col cols="10" xl="10" lg="10" md="8" sm="6">
      <v-chip-group multiple active-class="primary--text">
        <v-chip v-for="tag in tags" :key="tag">
          {{ tag }}
        </v-chip>
      </v-chip-group>
    </v-col>
    <v-col cols="2" xl="2" lg="2" md="4" sm="6">
      <v-btn text color="primary"> See All </v-btn>
    </v-col>
  </v-row>
</template>

<script>
export default {
  data: () => ({
    tags: [
      'Work',
      'Home Improvement',
      'Vacation',
      'Food',
      'Drawers',
      'Shopping',
      'Art',
      'Tech',
      'Creative Writing',
      'Work',
      'Home Improvement',
      'Vacation',
      'Food',
      'Drawers',
      'Shopping',
      'Art',
      'Tech',
      'Creative Writing',
    ],
  }),
};
</script>
