module.exports = {
  transpileDependencies: ['vuetify'],
  css: {
    loaderOptions: {
      scss: {
        additionalData: `
          @import "@/sass/main.scss";
          `,
      },
    },
  },
};
