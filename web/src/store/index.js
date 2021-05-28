import Vue from 'vue';
import Vuex from 'vuex';
import auth from './modules/auth.module';
import common from './modules/common.module';
import shopping from './modules/shopping.module';
import profile from './modules/profile.module';

Vue.use(Vuex);

export default new Vuex.Store({
  modules: {
    auth,
    common,
    shopping,
    profile,
  },
});
