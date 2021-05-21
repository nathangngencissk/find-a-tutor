<template>
  <v-row class="text-center">
    <v-col cols="12">
      <Slider />
    </v-col>
    <hello-world />
  </v-row>
</template>

<script>
import HelloWorld from '@/views/home/components/HelloWorld.vue';
import Slider from '@/views/home/components/Slider.vue';

export default {
  name: 'Home',

  components: {
    HelloWorld,
    Slider,
  },
};
</script>
