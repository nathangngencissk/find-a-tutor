/* eslint-disable no-shadow */
import { Auth } from 'aws-amplify';

import router from '@/router';
import { LOGIN } from '../actions.type';

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
};

const actions = {
  async [LOGIN]({ dispatch, state }, { email, password }) {
    state.loginError = '';
    try {
      await Auth.signIn(email, password);
    } catch (err) {
      console.log(`Login Error [${err}]`);
      if (err) state.loginError = err.message || err;
      return;
    }
    await dispatch('fetchUser');
  },
  async signup({ commit, state }, { email, password }) {
    state.signupError = '';
    try {
      await Auth.signUp({
        username: email,
        email,
        password,
        attributes: {
          email,
        },
        validationData: [],
      });
      // switch email confirmation form
      commit('confirm', true);
    } catch (err) {
      console.log(`Signup Error [${err}]`);
      if (err) state.signupError = err.message || err;
      commit('confirm', false);
    }
  },
  async confirm({ commit, state }, { email, code }) {
    state.confirmError = '';
    try {
      await Auth.confirmSignUp(email, code, {
        forceAliasCreation: true,
      });
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
  },
};

const mutations = {
  user(state, user) {
    state.authorized = !!user && user.attributes && user.attributes.email_verified;
    state.user = user;

    router.push({ name: 'Home' }).catch((error) => {
      if (error.name !== 'NavigationDuplicated') {
        throw error;
      }
    });
  },
  confirm(state, showConfirm) {
    state.confirm = !!showConfirm;
  },
};

export default {
  state,
  actions,
  mutations,
  getters,
};
