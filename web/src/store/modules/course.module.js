/* eslint-disable no-unused-vars */
/* eslint-disable no-shadow */
import { getUserCourses } from '@/graphql/queries';
import Vue from 'vue';

const namespaced = true;

const state = {
  userCourses: null,
};

const getters = {
  userCourses(state) {
    return state.userCourses;
  },
};

const actions = {
  async updateUserCourses({ dispatch, commit, getters, rootGetters }) {
    try {
      const currentUser = rootGetters['auth/currentUser'];
      Vue.gqlClient
        .query({
          query: Vue.gql(getUserCourses),
          variables: { user_id: currentUser.username },
        })
        .then(async (response) => {
          const result = JSON.parse(response.data.getUserCourses);
          await commit('updateUserCourses', result);
        });
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
