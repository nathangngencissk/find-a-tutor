/* eslint-disable camelcase */
/* eslint-disable prefer-destructuring */
/* eslint-disable no-unused-vars */
/* eslint-disable no-shadow */
import { Storage, Auth } from 'aws-amplify';

const namespaced = true;

const state = {
  profilePicture: '',
  updateSuccess: '',
  updateError: '',
};

const getters = {
  profilePicture(state) {
    return state.profilePicture;
  },
  updateSuccess(state) {
    return state.updateSuccess;
  },
  updateError(state) {
    return state.updateError;
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
        if (currentUser.attributes.picture === 'default-profile-picture.png') {
          const picture = await Storage.get(currentUser.attributes.picture, {
            level: 'public',
          });
          commit('changeProfilePicture', picture);
          return;
        }

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
  async updateProfilePersonalInformation(
    { dispatch, commit, getters, rootGetters },
    { name, family_name }
  ) {
    try {
      const user = await Auth.currentAuthenticatedUser();

      const result = await Auth.updateUserAttributes(user, {
        name,
        family_name,
      });
      await dispatch('auth/fetchUser', null, { root: true });
      commit('changeUpdateSuccess', 'Seus dados foram atualizados com sucesso!');
    } catch (error) {
      commit('changeUpdateError', 'Ocorreu um erro, por favor tente novamente.');
    }
  },
  async updateProfilePassword(
    { dispatch, commit, getters, rootGetters },
    { oldPassword, newPassword }
  ) {
    try {
      const user = await Auth.currentAuthenticatedUser();

      const result = await Auth.changePassword(user, oldPassword, newPassword);
      await dispatch('auth/fetchUser', null, { root: true });
      commit('changeUpdateSuccess', 'Seus dados foram atualizados com sucesso!');
    } catch (error) {
      commit('changeUpdateError', 'Ocorreu um erro, por favor tente novamente.');
    }
  },
};

const mutations = {
  changeProfilePicture(state, picture) {
    state.profilePicture = picture;
  },
  changeProfilePersonalInformation(state, picture) {
    state.profilePicture = picture;
  },
  changeUpdateError(state, error) {
    state.updateError = error;
  },
  changeUpdateSuccess(state, success) {
    state.updateSuccess = success;
  },
};

export default {
  namespaced,
  state,
  actions,
  mutations,
  getters,
};
