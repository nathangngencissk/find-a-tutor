/* eslint-disable no-unused-vars */
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

const actions = {
  async updateUserCourses({ dispatch, commit, getters, rootGetters }, { courses }) {
    try {
      await commit('updateUserCourses', courses);
    } catch (error) {
      console.error('Error updating user courses: ', error);
    }
  },
};

const mutations = {
  updateUserCourses(state, courses) {
    state.userCourses = courses;
  },
};

export default {
  namespaced,
  state,
  actions,
  mutations,
  getters,
};
