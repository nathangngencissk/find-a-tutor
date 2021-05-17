import Amplify from 'aws-amplify';
import aws_exports from './aws-exports';
import {
    applyPolyfills,
    defineCustomElements,
} from '@aws-amplify/ui-components/loader';

import { createApp } from 'vue'
import App from './App.vue'

Amplify.configure(aws_exports);
applyPolyfills().then(() => {
    defineCustomElements(window);
});

createApp(App).mount('#app')
