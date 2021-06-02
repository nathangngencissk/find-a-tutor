export default function student({ router, next }) {
  const isStudent = router.app.$store.getters['common/student'];
  if (isStudent) {
    return next();
  }
  return router.push({ name: 'Home' });
}
