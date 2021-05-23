<template>
  <div class="text-center">
    <v-snackbar v-model="show" :timeout="timeout">
      {{ text }}

      <template v-slot:action="{ attrs }">
        <v-btn color="blue" text v-bind="attrs" @click="show = false"> Fechar </v-btn>
      </template>
    </v-snackbar>
  </div>
</template>

<script>
export default {
  name: 'Snackbar',
  props: ['text', 'timeout', 'show'],
};
</script>
