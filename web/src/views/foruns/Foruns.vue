<template>
  <v-container>
    <v-row justify="end">
      <v-col cols="3">
        <v-btn color="primary" @click="newPost">Novo post</v-btn>
      </v-col>
    </v-row>
    <v-row justify="center">
      <v-col cols="2">
        <v-card class="mx-auto" max-width="300" tile>
          <v-list disabled>
            <v-subheader>Categorias</v-subheader>
            <v-list-item-group v-model="selectedItem" color="primary">
              <v-list-item v-for="(category, i) in categories" :key="i">
                <v-list-item-content>
                  <v-list-item-title v-text="category"></v-list-item-title>
                </v-list-item-content>
              </v-list-item>
            </v-list-item-group>
          </v-list>
        </v-card>
      </v-col>
      <v-col cols="8">
        <v-list three-line>
          <template v-for="(item, index) in items">
            <v-subheader v-if="item.header" :key="item.header" v-text="item.header"></v-subheader>

            <v-divider v-else-if="item.divider" :key="index" :inset="item.inset"></v-divider>
            <v-hover v-else v-slot="{ hover }" :key="item">
              <v-list-item
                :key="item.title"
                :class="{ 'on-hover': hover }"
                :to="{ name: 'Thread', params: { thread: item } }"
              >
                <v-list-item-avatar>
                  <v-img :src="item.avatar"></v-img>
                </v-list-item-avatar>

                <v-list-item-content>
                  <v-row>
                    <v-col cols="8">
                      <v-list-item-title v-html="item.title"></v-list-item-title>
                      <v-list-item-subtitle v-html="item.subtitle"></v-list-item-subtitle>
                      <v-row class="mt-1">
                        <v-chip
                          class="ma-2"
                          v-for="category in item.categories"
                          :key="category"
                          label
                        >
                          {{ category }}
                        </v-chip>
                      </v-row>
                    </v-col>
                    <v-col cols="4">
                      <v-row class="d-flex flex-column">
                        <v-col class="pa-0 mt-5">
                          <span class="post-info">Respostas: {{ item.repliesCount }} </span>
                        </v-col>
                        <v-col class="pa-0">
                          <span class="post-info"> Última Resposta: {{ item.last }}</span>
                        </v-col>
                      </v-row>
                    </v-col>
                  </v-row>
                </v-list-item-content>
              </v-list-item>
            </v-hover>
          </template>
        </v-list>
        <div class="text-center mt-2">
          <v-pagination v-model="page" :length="1" circle></v-pagination>
        </div>
      </v-col>
    </v-row>
    <v-overlay :z-index="zIndex" :value="overlay" :dark="$vuetify.theme.dark">
      <v-card class="pa-4" min-width="600px">
        <v-form>
          <v-text-field label="Título" v-model="title"></v-text-field>
          <v-textarea outlined name="input-7-4" label="Texto" v-model="text"></v-textarea>
          <v-select
            :items="categories"
            label="Categorias"
            v-model="selectedCategories"
            multiple
          ></v-select>
        </v-form>
        <v-btn class="mr-4" color="success" @click="addPost"> Postar </v-btn>
        <v-btn color="error" outlined @click="overlay = false"> Fechar </v-btn>
      </v-card>
    </v-overlay>
  </v-container>
</template>

<script>
import { mapGetters } from 'vuex';

export default {
  name: 'Foruns',
  title: 'Forum | Find a Tutor',
  data: () => ({
    page: 1,
    transparent: 'rgba(255, 255, 255, 0)',
    selectedItem: 0,
    title: '',
    text: '',
    overlay: false,
    categories: ['Todas', 'Tecnologia', 'Fotografia'],
    selectedCategories: [],
    items: [
      { header: 'Posts Recentes' },
      {
        avatar: 'https://cdn.vuetifyjs.com/images/lists/1.jpg',
        title: 'Brunch this weekend?',
        subtitle: `<span class="text--primary">Ali Connors</span> &mdash; I'll be in your neighborhood doing errands this weekend. Do you want to hang out?`,
        repliesCount: 11,
        last: '11/06/2021 18:34',
        categories: ['Tecnologia'],
        posts: [
          {
            id: 1,
            title: 'Título do post',
            text: 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Neque vel obcaecati autem commodi doloremque aliquid accusantium? Velit, asperiores neque praesentium provident exercitationem necessitatibus beatae aspernatur perferendis culpa aut tenetur nemo!',
            ownerImage: 'https://cdn.vuetifyjs.com/images/lists/1.jpg',
            ownerName: 'Ali Connors',
          },
        ],
        replies: [
          {
            id: 1,
            text: 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Neque vel obcaecati autem commodi doloremque aliquid accusantium? Velit, asperiores neque praesentium provident exercitationem necessitatibus beatae aspernatur perferendis culpa aut tenetur nemo!',
            ownerImage: 'https://cdn.vuetifyjs.com/images/lists/2.jpg',
            ownerName: 'Scott',
          },
        ],
      },
      { divider: true, inset: true },
      {
        avatar: 'https://cdn.vuetifyjs.com/images/lists/2.jpg',
        title: 'Summer BBQ',
        subtitle: `<span class="text--primary">Scott</span> &mdash; Wish I could come, but I'm out of town this weekend.`,
        repliesCount: 2,
        last: '10/06/2021 22:11',
        categories: [],
        posts: [
          {
            id: 2,
            title: 'Título do post',
            text: 'Texto do post',
            ownerImage: 'https://cdn.vuetifyjs.com/images/lists/2.jpg',
            ownerName: 'Scott',
          },
        ],
        replies: [],
      },
      { divider: true, inset: true },
      {
        avatar: 'https://cdn.vuetifyjs.com/images/lists/3.jpg',
        title: 'Oui oui',
        subtitle:
          '<span class="text--primary">Sandra Adams</span> &mdash; Do you have Paris recommendations? Have you ever been?',
        repliesCount: 4,
        last: '10/06/2021 20:25',
        categories: ['Fotografia'],
        posts: [
          {
            id: 3,
            title: 'Título do post',
            text: 'Texto do post',
            ownerImage: 'https://cdn.vuetifyjs.com/images/lists/3.jpg',
            ownerName: 'Sandra Adams',
          },
        ],
        replies: [
          {
            id: 1,
            text: 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Neque vel obcaecati autem commodi doloremque aliquid accusantium? Velit, asperiores neque praesentium provident exercitationem necessitatibus beatae aspernatur perferendis culpa aut tenetur nemo!',
            ownerImage: 'https://cdn.vuetifyjs.com/images/lists/2.jpg',
            ownerName: 'Scott',
          },
        ],
      },
      { divider: true, inset: true },
      {
        avatar: 'https://cdn.vuetifyjs.com/images/lists/4.jpg',
        title: 'Birthday gift',
        subtitle:
          '<span class="text--primary">Trevor Hansen</span> &mdash; Have any ideas about what we should get Heidi for her birthday?',
        repliesCount: 1,
        last: '09/06/2021 19:12',
        categories: ['Tecnologia', 'Fotografia'],
        posts: [
          {
            id: 4,
            title: 'Título do post',
            text: 'Texto do post',
            ownerImage: 'https://cdn.vuetifyjs.com/images/lists/4.jpg',
            ownerName: 'Trevor Hansen',
          },
        ],
        replies: [
          {
            id: 1,
            text: 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Neque vel obcaecati autem commodi doloremque aliquid accusantium? Velit, asperiores neque praesentium provident exercitationem necessitatibus beatae aspernatur perferendis culpa aut tenetur nemo!',
            ownerImage: 'https://cdn.vuetifyjs.com/images/lists/2.jpg',
            ownerName: 'Scott',
          },
        ],
      },
      { divider: true, inset: true },
      {
        avatar: 'https://cdn.vuetifyjs.com/images/lists/5.jpg',
        title: 'Recipe to try',
        subtitle:
          '<span class="text--primary">Britta Holt</span> &mdash; We should eat this: Grate, Squash, Corn, and tomatillo Tacos.',
        repliesCount: 3,
        last: '07/06/2021 14:11',
        categories: ['Tecnologia'],
        posts: [
          {
            id: 5,
            title: 'Título do post',
            text: 'Texto do post',
            ownerImage: 'https://cdn.vuetifyjs.com/images/lists/5.jpg',
            ownerName: 'Britta Holt',
          },
        ],
        replies: [],
      },
    ],
  }),
  methods: {
    newPost() {
      this.title = '';
      this.text = '';
      this.selectedCategories = [];
      this.overlay = true;
    },
    addPost() {
      this.items.push({ divider: true, inset: true });
      const newPost = {
        avatar: this.profilePicture,
        title: this.title,
        subtitle: this.text,
        repliesCount: 0,
        last: 'Agora',
        categories: this.selectedCategories,
        posts: [
          {
            id: 1,
            title: this.title,
            text: this.text,
            ownerImage: this.profilePicture,
            ownerName: `${this.currentUser.attributes.name} ${this.currentUser.attributes.family_name}`,
          },
        ],
        replies: [],
      };
      this.items.push(newPost);
      this.overlay = false;
    },
  },
  computed: {
    ...mapGetters('auth', ['currentUser']),
    ...mapGetters('profile', ['profilePicture']),
  },
};
</script>

<style lang="scss" scoped>
.post-info {
  font-weight: 300;
  line-height: 1.4;
  font-size: 0.9rem;
}

.v-list-item {
  transition: opacity 0.2s ease-in-out;
}

.on-hover {
  opacity: 0.6;
  cursor: pointer;
}

.show-btns {
  color: rgba(255, 255, 255, 1) !important;
}
</style>
