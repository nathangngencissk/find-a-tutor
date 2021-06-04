export default function watch({ router, to, next }) {
  const userCourses = router.app.$store.getters['course/userCourses'];
  const toCourseId = to.params.id;
  if (userCourses.includes(toCourseId)) {
    return router.push({ name: 'Watch', params: { id: toCourseId } });
  }
  return next();
}
