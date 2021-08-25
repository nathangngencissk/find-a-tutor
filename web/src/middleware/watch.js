export default function watch({ router, to, next }) {
  const userCourses = router.app.$store.getters['course/userCourses'];
  const toCourseId = parseInt(to.params.id, 10);
  if (userCourses.includes(toCourseId)) {
    return router.push({ name: 'Watch', params: { id: toCourseId } });
  }
  return next();
}
