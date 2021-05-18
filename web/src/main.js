import Amplify from 'aws-amplify';
import aws_exports from './aws-exports';
import {
    applyPolyfills,
    defineCustomElements,
} from '@aws-amplify/ui-components/loader';

import { createApp } from 'vue'
import vuetify from './plugins/vuetify'
import App from './App.vue'

Amplify.configure(aws_exports);
applyPolyfills().then(() => {
    defineCustomElements(window);
});

const app = createApp(App)
app.use(vuetify)
app.mount('#app')