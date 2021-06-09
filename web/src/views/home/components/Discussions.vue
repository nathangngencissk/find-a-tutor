<template>
  <div class="mt-4">
    <v-parallax src="@/assets/home-discussion.jpg">
      <v-card class="mx-auto" color="blue darken-3" dark max-width="400">
        <v-card-title> </v-card-title>

        <v-card-text class="headline font-weight-bold">
          "A realidade é uma só, Vue.js é melhor que React."
        </v-card-text>
        <v-card-actions>
          <v-list-item class="grow">
            <v-list-item-avatar color="grey darken-3">
              <v-img
                class="elevation-6"
                alt=""
                src="https://avataaars.io/?avatarStyle=Transparent&topType=ShortHairShortCurly&accessoriesType=Prescription02&hairColor=Black&facialHairType=Blank&clotheType=Hoodie&clotheColor=White&eyeType=Default&eyebrowType=DefaultNatural&mouthType=Default&skinColor=Light"
              ></v-img>
            </v-list-item-avatar>

            <v-list-item-content>
              <v-list-item-title>Evan You</v-list-item-title>
            </v-list-item-content>

            <v-row align="center" justify="end">
              <v-btn color="secondary" depressed small to="/foruns">Ver Discussões</v-btn>
            </v-row>
          </v-list-item>
        </v-card-actions>
      </v-card>
    </v-parallax>
  </div>
</template>

<script>
export default {
  data: () => ({
    //
  }),
};
</script>

<style scoped lang="scss">
.v-parallax {
  width: 100vw;
  position: relative;
  left: calc(-50vw + 50%);
}

.v-parallax__image {
  transform: none !important;
  width: 100% !important;
}

.v-card {
  z-index: 10;
}
</style>
