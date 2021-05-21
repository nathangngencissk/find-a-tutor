import { Auth } from 'aws-amplify';

export const getToken = async () => {
  try {
    const session = await Auth.currentSession();
    const jwt = session.idToken.jwtToken;
    return jwt;
  } catch (err) {
    return null;
  }
};

export default { getToken };
