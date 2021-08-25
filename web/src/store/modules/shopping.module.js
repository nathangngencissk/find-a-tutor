/* eslint-disable eqeqeq */
/* eslint-disable no-unused-vars */
/* eslint-disable no-shadow */

import router from '@/router';

const namespaced = true;

const state = {
  shoppingCart: [],
};

const getters = {
  shoppingCart(state) {
    return state.shoppingCart;
  },
  shoppingCartItemsNumber(state) {
    return state.shoppingCart.length;
  },
};

const actions = {
  async addToCart({ dispatch, commit, getters, rootGetters }, { course }) {
    try {
      await commit('addToCart', course);
    } catch (error) {
      console.error('Error adding to cart: ', error);
    }
  },
  async removeFromCart({ dispatch, commit, getters, rootGetters }, { course }) {
    try {
      await commit('removeFromCart', course);
    } catch (error) {
      console.error('Error removing from cart: ', error);
    }
  },
};

const mutations = {
  addToCart(state, course) {
    let duplicate = false;
    state.shoppingCart.forEach((c) => {
      if (JSON.stringify(c) == JSON.stringify(course)) {
        duplicate = true;
      }
    });
    if (!duplicate) {
      state.shoppingCart.push(course);
    }
    router.push({ path: '/cart' });
  },
  removeFromCart(state, course) {
    let pos = -1;
    state.shoppingCart.forEach((c, index) => {
      if (JSON.stringify(c) == JSON.stringify(course)) {
        pos = index;
      }
    });
    if (pos != -1) {
      state.shoppingCart.splice(pos, 1);
    }
  },
};

export default {
  namespaced,
  state,
  actions,
  mutations,
  getters,
};
