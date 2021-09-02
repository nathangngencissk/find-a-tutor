<template>
  <v-container>
    <v-row justify="center" align="center">
      <v-col cols="4" align="center" justify="center" class="mt-4">
        <div v-html="compiledMarkdown"></div>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import { getCourseClass } from '@/graphql/queries';
import DOMPurify from 'dompurify';

export default {
  name: 'Class',
  title: 'Detalhes da Turma | Find a Tutor',
  data: () => ({
    cl: {
      how_to_access: '',
    },
  }),
  computed: {
    compiledMarkdown() {
      return this.$marked(DOMPurify.sanitize(this.cl.how_to_access));
    },
  },
  methods: {
    getCourseClass() {
      this.$gqlClient
        .query({
          query: this.$gql(getCourseClass),
          variables: { id: this.$route.params.id },
        })
        .then((response) => {
          const result = JSON.parse(response.data.getCourseClass);
          // eslint-disable-next-line prefer-destructuring
          this.cl = result[0];
        });
    },
  },
  created() {
    this.getCourseClass();
  },
};
</script>
