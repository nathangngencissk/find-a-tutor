/* eslint-disable no-shadow */

const namespaced = true;

const state = {
  userCourses: ['2'],
};

const getters = {
  userCourses(state) {
    return state.userCourses;
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
