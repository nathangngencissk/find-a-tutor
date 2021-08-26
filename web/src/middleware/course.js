export default async function course({ router, to, next }) {
  let userCourses = router.app.$store.getters['course/userCourses'];
  const toCourseId = to.params.id;
  if (userCourses === null) {
    await router.app.$store.dispatch('auth/fetchUser');
    await router.app.$store.dispatch('course/updateUserCourses');
    userCourses = router.app.$store.getters['course/userCourses'];
  }
  if (userCourses.includes(toCourseId)) {
    return next();
  }
  return router.push({ name: 'Course', params: { id: toCourseId } });
}
