import Vue from 'vue';
import lodash from 'lodash';

Vue.use({
  install() {
    Vue.lodash = lodash;
    Vue.prototype.$lodash = lodash;
  },
});
