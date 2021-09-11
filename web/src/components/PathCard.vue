<template>
  <v-card class="mx-auto mr-4" max-width="400">
    <v-img class="white--text align-end" height="200px" :src="pathImageUrl">
      <v-card-title>{{ pathName }}</v-card-title>
    </v-img>

    <v-card-text class="text--primary">
      <v-row align="center" class="mx-0 my-2">
        <v-rating
          :value="pathRatingInteger"
          color="amber"
          dense
          half-increments
          readonly
          empty-icon="$ratingFull"
          background-color="grey darken-1"
          size="14"
        ></v-rating>

        <div class="grey--text ml-2 mr-4">{{ pathRating }} ({{ pathReviews }})</div>
      </v-row>
      <div>
        {{ pathDescription }}
      </div>
    </v-card-text>

    <v-card-actions>
      <v-btn color="primary" text :to="{ name: 'Path', params: { id: pathId } }">
        Ver Trilha
      </v-btn>
    </v-card-actions>
  </v-card>
</template>

<script>
export default {
  name: 'PathCard',

  props: ['pathName', 'pathImage', 'pathRating', 'pathReviews', 'pathDescription', 'pathId'],

  data: () => ({
    pathImageUrl: '',
  }),

  computed: {
    pathRatingInteger() {
      return parseFloat(this.pathRating);
    },
  },

  async created() {
    this.pathImageUrl = await this.$getKeyUrl(this.pathImage);
  },
};
</script>
