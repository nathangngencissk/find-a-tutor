export default function course({ router, to, next }) {
  const userCourses = router.app.$store.getters['course/userCourses'];
  const toCourseId = to.params.id;
  if (userCourses.includes(toCourseId)) {
    return next();
  }
  return router.push({ name: 'Course', params: { id: toCourseId } });
}
