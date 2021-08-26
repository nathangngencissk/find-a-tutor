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
  forgotPasswordError: '',
  forgotPasswordSubmit: false,
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
  forgotPasswordError(state) {
    return state.forgotPasswordError;
  },
  forgotPasswordSubmit(state) {
    return state.forgotPasswordSubmit;
  },
};

const actions = {
  async login({ dispatch, state }, { email, password }) {
    state.loginError = '';
    try {
      const user = await Auth.signIn(email, password);
      if (user.challengeName === 'NEW_PASSWORD_REQUIRED') {
        Auth.completeNewPassword(user, password, {
          email,
        });
      }
    } catch (err) {
      console.log(`Login Error [${err}]`);
      if (err) state.loginError = err.message || err;
      return;
    }
    await dispatch('fetchUser');
    await dispatch('profile/getProfilePicture', null, { root: true });
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
          picture: 'default-profile-picture.png',
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
      if (user) {
        commit('user', user);
        await dispatch('course/updateUserCourses');
      }
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
  async forgotPassword({ commit }, { username }) {
    Auth.forgotPassword(username).catch((err) => commit('setForgotPasswordError', err));
    commit('setForgotPasswordSubmit', true);
  },
  async forgotPasswordSubmit({ commit }, { username, code, new_password }) {
    Auth.forgotPasswordSubmit(username, code, new_password).catch((err) =>
      commit('setForgotPasswordError', err)
    );
    commit('setForgotPasswordSubmit', false);
    router.push({ name: 'Login' }).catch((error) => {
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
  setForgotPasswordError(state, error) {
    state.forgotPasswordError = error;
  },
  setForgotPasswordSubmit(state, submit) {
    state.forgotPasswordSubmit = submit;
  },
};

export default {
  namespaced,
  state,
  actions,
  mutations,
  getters,
};
