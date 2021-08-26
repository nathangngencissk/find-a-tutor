export default async function watch({ router, to, next }) {
  let userCourses = router.app.$store.getters['course/userCourses'];
  const toCourseId = parseInt(to.params.id, 10);
  if (userCourses === null) {
    await router.app.$store.dispatch('auth/fetchUser');
    await router.app.$store.dispatch('course/updateUserCourses');
    userCourses = router.app.$store.getters['course/userCourses'];
  }
  if (userCourses.includes(toCourseId)) {
    return router.push({ name: 'Watch', params: { id: toCourseId } });
  }
  return next();
}
