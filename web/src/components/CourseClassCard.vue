<template>
  <v-card class="mb-4 mr-2" max-width="400">
    <v-img class="white--text align-end" height="200px" :src="classPicture" />
    <v-card-title>{{ courseClass.name }}</v-card-title>
    <v-card-subtitle class="pb-0"> {{ courseClass.category }} </v-card-subtitle>

    <v-card-text class="text--primary">
      <p>
        {{ courseClass.description }}
      </p>
      <div class="mt-8">
        de <b>{{ courseClass.start_date }}</b> até <b>{{ courseClass.end_date }}</b>
      </div>
    </v-card-text>

    <v-card-actions>
      <v-btn color="primary" text :to="'/class/' + courseClass.id + '/lecture'"> Ver Turma </v-btn>
    </v-card-actions>
  </v-card>
</template>

<script>
export default {
  name: 'CourseClassCard',
  props: ['courseClass'],
  data: () => ({
    classPicture: '',
  }),
  async created() {
    this.classPicture = await this.$getKeyUrl(this.courseClass.image);
  },
};
</script>
