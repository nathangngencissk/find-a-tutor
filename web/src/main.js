import Vue from 'vue';
import gql from 'graphql-tag';
import Amplify, { Auth } from 'aws-amplify';
import AWSAppSyncClient, { AUTH_TYPE } from 'aws-appsync';
import './plugins/base';
import './plugins/globals';
import './plugins/chartist';
import './plugins/lodash';
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

const client = new AWSAppSyncClient({
  url: aws_exports.aws_appsync_graphqlEndpoint,
  region: aws_exports.aws_appsync_region,
  auth: {
    type: AUTH_TYPE.AMAZON_COGNITO_USER_POOLS,
    jwtToken: async () => (await Auth.currentSession()).getIdToken().getJwtToken(),
  },
});

Vue.use(VuePlyr, {
  plyr: {},
});

Vue.use({
  install() {
    Vue.marked = marked;
    Vue.prototype.$marked = marked;
    Vue.parser = parser;
    Vue.prototype.$parser = parser;
    Vue.gql = gql;
    Vue.prototype.$gql = gql;
    Vue.gqlClient = client;
    Vue.prototype.$gqlClient = client;
  },
});

new Vue({
  router,
  store,
  vuetify,
  render: (h) => h(App),
}).$mount('#app');
