import Vue from 'vue';
import VueRouter from 'vue-router';
import Home from '@/views/home/Home.vue';
import auth from '@/middleware/auth';
import course from '@/middleware/course';
import watch from '@/middleware/watch';

Vue.use(VueRouter);

const routes = [
  {
    path: '/',
    name: 'Home',
    component: Home,
  },
  {
    path: '/about',
    name: 'About',
    component: () => import('@/views/about/About.vue'),
  },
  {
    path: '/register',
    name: 'Register',
    component: () => import('@/views/register/Register.vue'),
  },
  {
    path: '/login',
    name: 'Login',
    component: () => import('@/views/login/Login.vue'),
  },
  {
    path: '/search',
    name: 'Search',
    component: () => import('@/views/search/Search.vue'),
    props: (route) => ({ searchText: route.query.search }),
  },
  {
    path: '/courses',
    name: 'MyCourses',
    component: () => import('@/views/myCourses/MyCourses.vue'),
    meta: {
      middleware: auth,
    },
  },
  {
    path: '/paths',
    name: 'Paths',
    component: () => import('@/views/paths/Paths.vue'),
  },
  {
    path: '/path',
    name: 'Path',
    component: () => import('@/views/path/Path.vue'),
  },
  {
    path: '/cart',
    name: 'Cart',
    component: () => import('@/views/cart/Cart.vue'),
    meta: {
      middleware: auth,
    },
  },
  {
    path: '/account',
    name: 'Account',
    component: () => import('@/views/account/Account.vue'),
    children: [
      {
        path: 'personal',
        component: () => import('@/views/account/components/PersonalInformation.vue'),
      },
      {
        path: 'password',
        component: () => import('@/views/account/components/Password.vue'),
      },
      {
        path: 'picture',
        component: () => import('@/views/account/components/Picture.vue'),
      },
    ],
    meta: {
      middleware: auth,
    },
  },
  {
    path: '/course/:id',
    name: 'Course',
    component: () => import('@/views/course/Course.vue'),
    meta: {
      middleware: [watch],
    },
  },
  {
    path: '/account/forgot',
    name: 'ForgotPassword',
    component: () => import('@/views/forgotPassword/ForgotPassword.vue'),
  },
  {
    path: '/exercises',
    name: 'Exercises',
    component: () => import('@/views/exercises/Exercises.vue'),
    meta: {
      middleware: auth,
    },
  },
  {
    path: '/exercise/:id',
    name: 'Exercise',
    component: () => import('@/views/exercise/Exercise.vue'),
    meta: {
      middleware: auth,
    },
  },
  {
    path: '/notes',
    name: 'Notes',
    component: () => import('@/views/notes/Notes.vue'),
    meta: {
      middleware: auth,
    },
  },
  {
    path: '/watch/:id',
    name: 'Watch',
    component: () => import('@/views/watch/Watch.vue'),
    meta: {
      middleware: [auth, course],
    },
  },
  {
    path: '/classes',
    name: 'Classes',
    component: () => import('@/views/classes/Classes.vue'),
    meta: {
      middleware: auth,
    },
  },
  {
    path: '/class/:id',
    name: 'Class',
    component: () => import('@/views/class/Class.vue'),
    children: [
      {
        name: 'ClassLecture',
        path: 'lecture',
        component: () => import('@/views/class/components/Lecture.vue'),
      },
      {
        name: 'ClassCalendar',
        path: 'calendar',
        component: () => import('@/views/class/components/Calendar.vue'),
      },
      {
        name: 'ClassPosts',
        path: 'posts',
        component: () => import('@/views/class/components/Posts.vue'),
        children: [
          {
            name: 'ClassPost',
            path: ':postId',
            component: () => import('@/views/class/components/Post.vue'),
          },
        ],
      },
    ],
    meta: {
      middleware: auth,
    },
  },
];

const router = new VueRouter({
  routes,
});

function nextFactory(context, middleware, index) {
  const subsequentMiddleware = middleware[index];
  // If no subsequent Middleware exists,
  // the default `next()` callback is returned.
  if (!subsequentMiddleware) return context.next;

  return (...parameters) => {
    // Run the default Vue Router `next()` callback first.
    context.next(...parameters);
    // Then run the subsequent Middleware with a new
    // `nextMiddleware()` callback.
    const nextMiddleware = nextFactory(context, middleware, index + 1);
    subsequentMiddleware({ ...context, next: nextMiddleware });
  };
}

router.beforeEach((to, from, next) => {
  if (to.meta.middleware) {
    const middleware = Array.isArray(to.meta.middleware)
      ? to.meta.middleware
      : [to.meta.middleware];

    const context = {
      from,
      next,
      router,
      to,
    };
    const nextMiddleware = nextFactory(context, middleware, 1);

    return middleware[0]({ ...context, next: nextMiddleware });
  }

  return next();
});

export default router;
