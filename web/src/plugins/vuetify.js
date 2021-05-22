import Vue from 'vue';
import Vuetify from 'vuetify/lib/framework';
import colors from 'vuetify/lib/util/colors';

Vue.use(Vuetify);

const vuetify = new Vuetify({
  theme: {
    themes: {
      light: {
        primary: colors.blue,
        secondary: colors.blue.lighten1,
        tertiary: colors.blue.lighten2,
        quaternary: colors.blue.lighten3,
        primaryText: colors.blue.darken1,
        accent: colors.shades.black,
        error: colors.red.accent3,
      },
      dark: {
        primary: colors.blue.darken3,
        secondary: colors.blue.darken2,
        tertiary: colors.blue.darken1,
        primaryText: colors.blue.lighten1,
      },
      options: {
        themeCache: {
          get: (key) => localStorage.getItem(key),
          set: (key, value) => localStorage.setItem(key, value),
        },
      },
    },
  },
});

export default vuetify;
