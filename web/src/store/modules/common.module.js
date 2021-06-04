/* eslint-disable no-shadow */

const namespaced = true;

const state = {
  student: null,
};

const getters = {
  student(state) {
    return state.student;
  },
};

const actions = {
  changeToStudent({ commit }) {
    commit('change', true);
  },
  changeToTutor({ commit }) {
    commit('change', false);
  },
};

const mutations = {
  change(state, change) {
    state.student = change;
    localStorage.student = String(change);
  },
};

export default {
  namespaced,
  state,
  actions,
  mutations,
  getters,
};
