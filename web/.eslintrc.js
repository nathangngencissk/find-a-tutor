module.exports = {
  root: true,
  env: {
    node: true,
  },
  extends: ['plugin:vue/essential', '@vue/airbnb', 'prettier'],
  plugins: ['prettier'],
  parserOptions: {
    parser: 'babel-eslint',
  },
  rules: {
    'no-console': process.env.NODE_ENV === 'production' ? 'warn' : 'off',
    'no-debugger': process.env.NODE_ENV === 'production' ? 'warn' : 'off',
    'prettier/prettier': ['error'],
    'import/no-unresolved': ['off'],
    'import/extensions': ['off'],
    'vue/no-unused-vars': ['off'],
  },
  settings: {
    'import/resolver': {
      alias: {
        map: [
          ['@', './resources'],
          ['~', './resources/js'],
        ],
        extensions: ['.js', '.vue'],
      },
    },
  },
};
