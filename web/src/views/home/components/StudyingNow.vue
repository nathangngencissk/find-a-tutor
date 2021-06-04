<template>
  <v-slide-group v-model="model" class="pa-4" active-class="success" show-arrows>
    <v-slide-item v-for="course in courses" :key="course.id">
      <CourseCardFull
        :courseName="course.name"
        :courseImage="course.image"
        :courseRating="course.rating"
        :courseReviews="course.reviews"
        :courseCategory="course.category"
        :courseDescription="course.description"
        :courseId="course.id"
        courseLanguage="pt-br"
        :courseCost="course.value"
      />
    </v-slide-item>
  </v-slide-group>
</template>

<script>
import CourseCardFull from '@/components/CourseCardFull.vue';

export default {
  name: 'StudyingCourses',

  components: {
    CourseCardFull,
  },

  data: () => ({
    loading: false,
    selection: 1,
    model: null,
    courses: [
      {
        id: 2,
        name: 'Programação C#',
        description:
          'Lorem ipsum dolor sit amet consectetur, adipisicing elit. Quibusdam autem, nulla ut pariatur atque, voluptates amet accusamus temporibus totam dignissimos eius quasi ips a veritatis repudiandae eaque, eum fuga facere rerum.',
        value: '150',
        rating: 4.5,
        reviews: 413,
        image:
          'https://images.unsplash.com/photo-1571171637578-41bc2dd41cd2?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80',
      },
      {
        id: 2,
        name: 'Programação Básica',
        description:
          'Lorem ipsum dolor sit amet consectetur, adipisicing elit. Quibusdam autem, nulla ut pariatur atque, voluptates amet accusamus temporibus totam dignissimos eius quasi ips a veritatis repudiandae eaque, eum fuga facere rerum.',
        value: '120',
        rating: 4.6,
        reviews: 22,
        image:
          'https://images.unsplash.com/photo-1542831371-29b0f74f9713?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1050&q=80',
      },
      {
        id: 2,
        name: 'Redes de computadores',
        description:
          'Lorem ipsum dolor sit amet consectetur, adipisicing elit. Quibusdam autem, nulla ut pariatur atque, voluptates amet accusamus temporibus totam dignissimos eius quasi ips a veritatis repudiandae eaque, eum fuga facere rerum.',
        value: '200',
        rating: 4.8,
        reviews: 111,
        image:
          'https://images.unsplash.com/photo-1597733336794-12d05021d510?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=967&q=80',
      },
      {
        id: 2,
        name: 'Matemática financeira',
        description:
          'Lorem ipsum dolor sit amet consectetur, adipisicing elit. Quibusdam autem, nulla ut pariatur atque, voluptates amet accusamus temporibus totam dignissimos eius quasi ips a veritatis repudiandae eaque, eum fuga facere rerum.',
        value: '180',
        rating: 4.4,
        reviews: 98,
        image:
          'https://images.unsplash.com/photo-1511377107391-116a9d5d20b5?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80',
      },
      {
        id: 2,
        name: 'Arduino do básico ao avançado',
        description:
          'Lorem ipsum dolor sit amet consectetur, adipisicing elit. Quibusdam autem, nulla ut pariatur atque, voluptates amet accusamus temporibus totam dignissimos eius quasi ips a veritatis repudiandae eaque, eum fuga facere rerum.',
        value: '250',
        rating: 4.9,
        reviews: 42,
        image:
          'https://images.unsplash.com/photo-1557855506-3619a44bab73?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=701&q=80',
      },
    ],
  }),

  methods: {
    reserve() {
      this.loading = true;

      // eslint-disable-next-line no-return-assign
      setTimeout(() => (this.loading = false), 2000);
    },
  },
};
</script>
