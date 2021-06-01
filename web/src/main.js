import Vue from 'vue';
import Amplify from 'aws-amplify';
import marked from 'marked';
import parser from 'cron-parser';
import VuePlyr from 'vue-plyr';
import 'vue-plyr/dist/vue-plyr.css';
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

Vue.use(VuePlyr, {
  plyr: {},
});

Vue.use({
  install() {
    Vue.marked = marked;
    Vue.prototype.$marked = marked;
    Vue.parser = parser;
    Vue.prototype.$parser = parser;
  },
});

new Vue({
  router,
  store,
  vuetify,
  render: (h) => h(App),
}).$mount('#app');
