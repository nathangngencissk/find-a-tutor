/* eslint-disable no-unused-vars */
/* eslint-disable no-shadow */
import { getUserCourses } from '@/graphql/queries';
import Vue from 'vue';
import { Storage } from 'aws-amplify';

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
          fetchPolicy: 'network-only',
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
  async updateCourseImage({ dispatch, commit, getters, rootGetters }, { file, fileName }) {
    try {
      await Storage.put(fileName, file, {
        level: 'public',
      });
    } catch (error) {
      console.error('Error uploading file: ', error);
    }
  },
  async uploadVideo({ dispatch, commit, getters, rootGetters }, { file, fileName }) {
    try {
      await Storage.put(fileName, file, {
        level: 'public',
      });
    } catch (error) {
      console.error('Error uploading file: ', error);
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
