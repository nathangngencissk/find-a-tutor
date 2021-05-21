import { getToken } from '@/services/jwt.service';

export default async function auth({ next, router }) {
  const token = await getToken();

  if (token) {
    return next();
  }
  return router.push({ name: 'Login' });
}
