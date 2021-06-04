/* eslint-disable no-shadow */

const namespaced = true;

const state = {
  shoppingCartItemsNumber: '3',
};

const getters = {
  shoppingCartItemsNumber(state) {
    return state.shoppingCartItemsNumber;
  },
};

const actions = {};

const mutations = {};

export default {
  namespaced,
  state,
  actions,
  mutations,
  getters,
};
