import Vue from 'vue';
import VueRouter from 'vue-router';
import Home from '@/views/home/Home.vue';
import auth from '@/middleware/auth';
import course from '@/middleware/course';
import watch from '@/middleware/watch';
import tutor from '@/middleware/tutor';

Vue.use(VueRouter);

const routes = [
  {
    path: '/',
    name: 'Home',
    component: Home,
    meta: {
      middleware: auth,
    },
  },
  {
    path: '/about',
    name: 'About',
    component: () => import('@/views/about/About.vue'),
  },
  {
    path: '/team',
    name: 'Team',
    component: () => import('@/views/team/Team.vue'),
  },
  {
    path: '/contact',
    name: 'Contact',
    component: () => import('@/views/contact/Contact.vue'),
  },
  {
    path: '/categories',
    name: 'Categories',
    component: () => import('@/views/categories/Categories.vue'),
    meta: {
      middleware: auth,
    },
  },
  {
    path: '/foruns',
    name: 'Foruns',
    component: () => import('@/views/foruns/Foruns.vue'),
    meta: {
      middleware: auth,
    },
  },
  {
    path: '/foruns/thread',
    name: 'Thread',
    component: () => import('@/views/foruns/components/Thread.vue'),
    meta: {
      middleware: auth,
    },
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
    meta: {
      middleware: auth,
    },
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
    meta: {
      middleware: auth,
    },
  },
  {
    path: '/path',
    name: 'Path',
    component: () => import('@/views/path/Path.vue'),
    meta: {
      middleware: auth,
    },
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
      middleware: [watch, auth],
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
  {
    path: '/dashboard',
    name: 'Dashboard',
    component: () => import('@/views/dashboard/Dashboard.vue'),
    meta: {
      middleware: [auth, tutor],
    },
    children: [
      {
        name: 'DashboardMain',
        path: '',
        component: () => import('@/views/dashboard/components/Main.vue'),
      },
      {
        name: 'DashboardClasses',
        path: 'classes',
        component: () => import('@/views/dashboard/components/Classes.vue'),
      },
      {
        name: 'DashboardEditClass',
        path: 'classes/edit',
        component: () => import('@/views/dashboard/components/EditClass.vue'),
      },
      {
        name: 'DashboardCourses',
        path: 'courses',
        component: () => import('@/views/dashboard/components/Courses.vue'),
      },
      {
        name: 'DashboardEditCourse',
        path: 'courses/edit',
        component: () => import('@/views/dashboard/components/EditCourse.vue'),
      },
      {
        name: 'DashboardExercises',
        path: 'exercises',
        component: () => import('@/views/dashboard/components/Exercises.vue'),
      },
      {
        name: 'DashboardEditExercise',
        path: 'exercises/edit',
        component: () => import('@/views/dashboard/components/EditExercise.vue'),
      },
      {
        name: 'DashboardPaths',
        path: 'paths',
        component: () => import('@/views/dashboard/components/Paths.vue'),
      },
      {
        name: 'DashboardEditPath',
        path: 'paths/edit',
        component: () => import('@/views/dashboard/components/EditPath.vue'),
      },
      {
        name: 'DashboardWithdrawal',
        path: 'withdrawal',
        component: () => import('@/views/dashboard/components/Withdrawal.vue'),
      },
      {
        name: 'DashboardWithdrawalAccount',
        path: 'account',
        component: () => import('@/views/dashboard/components/WithdrawalAccount.vue'),
      },
    ],
  },
  {
    path: '/admin',
    name: 'Admin',
    component: () => import('@/views/admin/Admin.vue'),
    meta: {
      middleware: auth,
    },
    children: [
      {
        name: 'AdminMain',
        path: '',
        component: () => import('@/views/admin/components/Main.vue'),
      },
      {
        name: 'AdminPayments',
        path: 'payments',
        component: () => import('@/views/admin/components/Payments.vue'),
      },
      {
        name: 'AdminPayouts',
        path: 'payouts',
        component: () => import('@/views/admin/components/Payouts.vue'),
      },
      {
        name: 'AdminCourses',
        path: 'courses',
        component: () => import('@/views/admin/components/Courses.vue'),
      },
      {
        name: 'AdminExercises',
        path: 'exercises',
        component: () => import('@/views/admin/components/Exercises.vue'),
      },
    ],
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
