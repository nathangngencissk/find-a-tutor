<template>
  <v-container>
    <v-subheader>Postagens</v-subheader>
    <v-row>
      <v-col cols="4">
        <v-list subheader two-line flat>
          <v-list-item-group v-model="settings" multiple>
            <v-list-item
              v-for="post in posts"
              :key="post.id"
              :to="{ name: 'ClassPost', params: { postId: post.id } }"
            >
              <template v-slot:default="{ active }">
                <v-list-item-action>
                  <v-checkbox :input-value="active" color="primary"></v-checkbox>
                </v-list-item-action>

                <v-list-item-content>
                  <v-list-item-title>{{ post.title }}</v-list-item-title>
                  <v-list-item-subtitle>{{ post.subtitle }}</v-list-item-subtitle>
                </v-list-item-content>
              </template>
            </v-list-item>
          </v-list-item-group>
        </v-list>
      </v-col>
      <v-divider vertical inset></v-divider>
      <v-col cols="8">
        <router-view></router-view>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
export default {
  name: 'ClassPosts',
  title: 'Turma Programação C# | Postagens | Find a Tutor',
  data: () => ({
    settings: [],
    posts: [
      {
        id: 1,
        action: '15 min',
        headline: 'Brunch this weekend?',
        subtitle: `Subtitulo 1`,
        title: 'Titulo 1',
      },
      {
        id: 2,
        action: '2 hr',
        headline: 'Summer BBQ',
        subtitle: `Subtitulo 2`,
        title: 'Titulo 2',
      },
      {
        id: 3,
        action: '6 hr',
        headline: 'Oui oui',
        subtitle: `Subtitulo 3`,
        title: 'Titulo 3',
      },
      {
        id: 4,
        action: '12 hr',
        headline: 'Birthday gift',
        subtitle: `Subtitulo 4`,
        title: 'Titulo 4',
      },
      {
        id: 5,
        action: '18hr',
        headline: 'Recipe to try',
        subtitle: `Subtitulo 5`,
        title: 'Titulo 5',
      },
    ],
  }),
};
</script>
