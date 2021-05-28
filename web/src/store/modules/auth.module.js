/* eslint-disable camelcase */
/* eslint-disable no-shadow */
import { Auth } from 'aws-amplify';

import router from '@/router';

const namespaced = true;

const state = {
  authorized: true,
  user: null,
  loginError: '',
  signupError: '',
  confirm: false,
  confirmError: '',
};

const getters = {
  currentUser(state) {
    return state.user;
  },
  isAuthorized(state) {
    return state.authorized;
  },
  isAuthenticated(state) {
    return !!state.user;
  },
  verification(state) {
    return state.confirm;
  },
  loginError(state) {
    return state.loginError;
  },
  signupError(state) {
    return state.signupError;
  },
  confirmError(state) {
    return state.confirmError;
  },
};

const actions = {
  async login({ dispatch, state }, { email, password }) {
    state.loginError = '';
    try {
      await Auth.signIn(email, password);
    } catch (err) {
      console.log(`Login Error [${err}]`);
      if (err) state.loginError = err.message || err;
      return;
    }
    await dispatch('fetchUser');
    router.push({ name: 'Home' }).catch((error) => {
      if (error.name !== 'NavigationDuplicated') {
        throw error;
      }
    });
  },
  async signup({ commit, state }, { email, password, name, family_name }) {
    state.signupError = '';
    try {
      await Auth.signUp({
        username: email,
        email,
        password,
        attributes: {
          email,
          name,
          family_name,
          picture: '',
        },
      });
      // switch email confirmation form
      commit('confirm', true);
    } catch (err) {
      console.log(`Signup Error [${err}]`);
      if (err) state.signupError = err.message || err;
      commit('confirm', false);
    }
  },
  async confirm({ commit, state }, { username, code }) {
    state.confirmError = '';
    try {
      await Auth.confirmSignUp(username, code, {
        forceAliasCreation: true,
      });
      router.push({ name: 'Login' });
    } catch (err) {
      console.log(`Confirm Error [${err}]`);
      if (err) state.confirmError = err.message || err;
      return;
    }
    commit('confirm', false);
  },
  async authState({ commit, dispatch }, state) {
    if (state === 'signedIn') await dispatch('fetchUser');
    else commit('user', null);
  },
  async fetchUser({ commit, dispatch }) {
    try {
      const user = await Auth.currentAuthenticatedUser();
      const expires =
        user.getSignInUserSession().getIdToken().payload.exp -
        Math.floor(new Date().getTime() / 1000);
      setTimeout(async () => {
        await dispatch('fetchUser');
      }, expires * 1000);
      commit('user', user);
    } catch (err) {
      commit('user', null);
    }
  },
  async logout({ commit }) {
    await Auth.signOut();
    commit('user', null);
    router.push({ name: 'Home' }).catch((error) => {
      if (error.name !== 'NavigationDuplicated') {
        throw error;
      }
    });
  },
};

const mutations = {
  user(state, user) {
    state.authorized = !!user && user.attributes && user.attributes.email_verified;
    state.user = user;
  },
  confirm(state, showConfirm) {
    state.confirm = !!showConfirm;
  },
};

export default {
  namespaced,
  state,
  actions,
  mutations,
  getters,
};
