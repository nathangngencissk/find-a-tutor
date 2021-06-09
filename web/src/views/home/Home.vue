<template>
  <v-container id="main-container">
    <Slider />
    <Categories />
    <v-subheader class="mt-4 mb-2 section-title">Cursos Populares</v-subheader>
    <PopularCourses />
    <v-subheader class="mt-4 mb-2 section-title">Categorias Principais</v-subheader>
    <MainCategories />
    <Discussions />
    <v-subheader class="mt-4 mb-2 section-title">Outros estão estudando agora</v-subheader>
    <StudyingNow />
  </v-container>
</template>

<script>
import PopularCourses from '@/views/home/components/PopularCourses.vue';
import Slider from '@/views/home/components/Slider.vue';
import Categories from '@/views/home/components/Categories.vue';
import MainCategories from '@/views/home/components/MainCategories.vue';
import Discussions from '@/views/home/components/Discussions.vue';
import StudyingNow from '@/views/home/components/StudyingNow.vue';

export default {
  name: 'Home',
  title: 'Home Page | Find A Tutor',
  components: {
    PopularCourses,
    Slider,
    Categories,
    MainCategories,
    Discussions,
    StudyingNow,
  },
};
</script>

<style scoped lang="scss">
.v-subheader {
  font-size: 2rem;
  font-weight: '500';
}

.container {
  max-width: 1480px;
}

#main-container {
  padding-top: 0;
}

.section-title {
  font-weight: 700;
  letter-spacing: -1px;
  font-family: 'Roboto';
}
</style>
