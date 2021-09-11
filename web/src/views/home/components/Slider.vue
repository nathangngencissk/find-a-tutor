<template>
  <v-carousel class="mt-0" cycle height="400" hide-delimiter-background show-arrows-on-hover>
    <v-carousel-item v-for="(slide, i) in slides" :key="i" :src="slide.image">
      <v-sheet color="white" max-width="500" class="mt-16 ml-10">
        <v-row class="fill-height py-6 px-10" align="center" justify="start">
          <div class="display-1 slide-title mb-2">{{ slide.title }}</div>
          <p class="slide-body">
            {{ slide.body }}
          </p>
        </v-row>
      </v-sheet>
    </v-carousel-item>
  </v-carousel>
</template>

<script>
import ad from '@/assets/advertisements/advertisement.jpg';
import ad1 from '@/assets/advertisements/advertisement1.jpg';
import ad2 from '@/assets/advertisements/advertisement2.jpg';

export default {
  name: 'Slider',
  data() {
    return {
      slides: [
        {
          image: ad2,
          body: 'Se prepare para chegar aonde quiser. Cursos a partir de R$22,90 até 2 de Dezembro.',
          title: 'Aprenda para o seu futuro',
        },
        {
          image: ad,
          body: 'Se prepare para chegar aonde quiser. Cursos a partir de R$22,90 até 2 de Dezembro.',
          title: 'Aprenda para o seu futuro',
        },
        {
          image: ad1,
          body: 'Se prepare para chegar aonde quiser. Cursos a partir de R$22,90 até 2 de Dezembro.',
          title: 'Aprenda para o seu futuro',
        },
      ],
    };
  },
};
</script>

<style lang="scss" scoped>
.slide-title {
  color: #3c3b37;
  font-weight: 700;
  letter-spacing: -0.02rem;
}

.slide-body {
  color: #3c3b37;
  font-weight: 300;
  line-height: 1.4;
  font-size: 1.1rem;
}
</style>
