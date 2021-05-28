/* eslint-disable prefer-destructuring */
/* eslint-disable no-unused-vars */
/* eslint-disable no-shadow */
import { Storage, Auth } from 'aws-amplify';

const namespaced = true;

const state = {
  profilePicture: '',
};

const getters = {
  profilePicture(state) {
    return state.profilePicture;
  },
};

const actions = {
  async getProfilePicture({ dispatch, commit, getters, rootGetters }) {
    await dispatch('auth/fetchUser', null, { root: true });
    const currentUser = rootGetters['auth/currentUser'];
    if (currentUser.username.includes('Facebook')) {
      const userPictureData = JSON.parse(currentUser.attributes.picture);
      commit('changeProfilePicture', userPictureData.data.url);
    } else if (currentUser.username.includes('Google')) {
      commit('changeProfilePicture', currentUser.attributes.picture);
    } else {
      try {
        const picture = await Storage.get(currentUser.attributes.picture, {
          level: 'private',
        });
        commit('changeProfilePicture', picture);
      } catch (err) {
        console.error(err);
      }
    }
  },
  async updateProfilePicture({ dispatch, commit, getters, rootGetters }, { file, fileName }) {
    try {
      await Storage.put(fileName, file, {
        level: 'private',
      });
      const user = await Auth.currentAuthenticatedUser();

      const result = await Auth.updateUserAttributes(user, {
        picture: fileName,
      });
      await dispatch('getProfilePicture');
    } catch (error) {
      console.error('Error uploading file: ', error);
    }
  },
};

const mutations = {
  changeProfilePicture(state, picture) {
    state.profilePicture = picture;
  },
};

export default {
  namespaced,
  state,
  actions,
  mutations,
  getters,
};
