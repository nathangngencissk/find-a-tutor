<template>
  <div>
    <Slider />
    <Categories />
    <v-subheader color="blue darken-1" class="mt-4 mb-2">Popular Courses</v-subheader>
    <PopularCourses />
    <v-subheader color="blue darken-1" class="mt-4 mb-2">Main Categories</v-subheader>
    <MainCategories />
    <Discussions />
    <v-subheader color="blue darken-1" class="mt-4 mb-2">Others are studying now</v-subheader>
    <StudyingNow />
  </div>
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
</style>
