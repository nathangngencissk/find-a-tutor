export default function tutor({ router, next }) {
  const isStudent = router.app.$store.getters['common/student'];
  if (!isStudent) {
    return next();
  }
  return router.push({ name: 'Home' });
}
