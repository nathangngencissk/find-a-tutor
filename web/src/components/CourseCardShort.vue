<template>
  <v-card class="mb-4 mr-2" max-width="800">
    <v-row justify="center">
      <v-col xl="4" lg="6" md="12" sm="12" xs="12">
        <v-avatar class="mx-10" size="200" tile>
          <v-img :src="$cloudfrontUrl + 'public/' + course.image" contain></v-img>
        </v-avatar>
      </v-col>
      <v-col xl="5" lg="6" md="12" sm="12" xs="12">
        <v-card-title>{{ course.name }}</v-card-title>

        <v-card-text class="text--primary">
          <div>
            {{ course.short_description }}
          </div>
        </v-card-text>
      </v-col>
      <v-col xl="3" lg="12" md="12" sm="8" xs="8">
        <v-card-actions class="flex-column">
          <v-btn color="red" depressed outlined text @click="removeFromCart(course)">
            Remover
          </v-btn>
          <v-btn color="primary" text class="mx-0" :to="'/course/' + course.id"> Ver Curso </v-btn>
          <h4 class="mt-16">R$ {{ course.price }},00</h4>
        </v-card-actions>
      </v-col>
    </v-row>
  </v-card>
</template>

<script>
export default {
  name: 'CourseCardShort',

  props: ['course'],

  data: () => ({}),

  computed: {},

  methods: {
    async removeFromCart(course) {
      await this.$store.dispatch('shopping/removeFromCart', {
        course,
      });
    },
  },
};
</script>
