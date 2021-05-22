import Vue from 'vue';
import Amplify from 'aws-amplify';
// eslint-disable-next-line camelcase
import aws_exports from './aws-exports';
import App from './App.vue';
import router from './router';
import store from './store';
import vuetify from './plugins/vuetify';
import titleMixin from './mixins/titleMixin';

Vue.config.productionTip = false;

Vue.mixin(titleMixin);

Amplify.configure(aws_exports);

new Vue({
  router,
  store,
  vuetify,
  render: (h) => h(App),
}).$mount('#app');
