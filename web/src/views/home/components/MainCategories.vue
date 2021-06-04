<template>
  <v-row dense>
    <template v-for="(card, i) in cards">
      <v-col :key="i" :cols="card.flex">
        <v-hover v-slot="{ hover }">
          <v-card class="mx-auto" :class="{ 'on-hover': hover }" max-width="344" to="/search">
            <v-img :src="card.src" height="200px"></v-img>

            <v-card-title> {{ card.title }} </v-card-title>
          </v-card>
        </v-hover>
      </v-col>
    </template>
  </v-row>
</template>

<script>
export default {
  data: () => ({
    transparent: 'rgba(255, 255, 255, 0)',
    cards: [
      {
        title: 'Fotografia',
        src: 'https://images.unsplash.com/photo-1542038784456-1ea8e935640e?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80',
        flex: 3,
      },
      {
        title: 'Culinária',
        src: 'https://images.unsplash.com/photo-1556910103-1c02745aae4d?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80',
        flex: 3,
      },
      {
        title: 'Tecnologia',
        src: 'https://nova-escola-producao.s3.amazonaws.com/EBUupJuWp5ttKkmKf5PZXN2rdxsMJ376JtzZaTE7MQRdbWVNrt5CsVgFGaDK/gettyimages-663622960.jpg',
        flex: 3,
      },
      {
        title: 'Matemática',
        src: 'https://images.unsplash.com/photo-1596495577886-d920f1fb7238?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1054&q=80',
        flex: 3,
      },
      {
        title: 'Inglês',
        src: 'https://images.unsplash.com/photo-1543109740-4bdb38fda756?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
        flex: 3,
      },
      {
        title: 'Filosofia',
        src: 'https://images.unsplash.com/photo-1505664194779-8beaceb93744?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80',
        flex: 3,
      },
      {
        title: 'Economia',
        src: 'https://images.unsplash.com/photo-1521897258701-21e2a01f5e8b?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80',
        flex: 3,
      },
      {
        title: 'Finanças Pessoais',
        src: 'https://images.unsplash.com/photo-1554224155-8d04cb21cd6c?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80',
        flex: 3,
      },
    ],
  }),
};
</script>

<style scoped>
.v-card {
  transition: opacity 0.4s ease-in-out;
}

.on-hover {
  opacity: 0.6;
}

.show-btns {
  color: rgba(255, 255, 255, 1) !important;
}
</style>
