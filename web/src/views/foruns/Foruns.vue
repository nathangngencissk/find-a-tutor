<template>
  <v-container>
    <v-row justify="end">
      <v-col cols="3">
        <v-btn color="primary" @click="newPost">Novo post</v-btn>
      </v-col>
    </v-row>
    <v-row justify="center">
      <v-col xl="2" cols="12">
        <v-card class="mx-auto" max-width="300" tile>
          <v-list>
            <v-subheader>Categorias</v-subheader>
            <v-list-item-group v-model="activeCategory" v-on:change="filter" color="primary">
              <v-list-item v-for="category in categories" :key="'category' + category.id">
                <v-list-item-content>
                  <v-list-item-title v-text="category.name"></v-list-item-title>
                </v-list-item-content>
              </v-list-item>
            </v-list-item-group>
          </v-list>
        </v-card>
      </v-col>
      <v-col xl="8" cols="12">
        <v-list three-line>
          <v-skeleton-loader
            v-bind="attrs"
            type="article, actions"
            v-if="loading"
          ></v-skeleton-loader>
          <template v-for="(post, index) in filteredPosts" v-else>
            <v-subheader v-if="post.header" :key="index" v-text="post.header"></v-subheader>

            <v-divider v-else-if="post.divider" :key="index" :inset="post.inset"></v-divider>
            <v-hover v-else v-slot="{ hover }" :key="'post' + post.id">
              <v-list-item
                :key="post.title"
                :class="{ 'on-hover': hover }"
                :to="{ name: 'Thread', params: { threadId: post.id } }"
              >
                <v-list-item-avatar>
                  <v-img :src="post.avatar"></v-img>
                </v-list-item-avatar>

                <v-list-item-content>
                  <v-row>
                    <v-col cols="8">
                      <v-list-item-title v-html="post.title"></v-list-item-title>
                      <v-list-item-subtitle v-html="post.short_description"></v-list-item-subtitle>
                      <v-row class="mt-1">
                        <v-chip class="ma-2" label>
                          {{ post.category_name }}
                        </v-chip>
                      </v-row>
                    </v-col>
                    <v-col cols="4">
                      <v-row class="d-flex flex-column">
                        <v-col class="pa-0 mt-5">
                          <span class="post-info">Respostas: {{ post.post_comments_count }} </span>
                        </v-col>
                        <v-col class="pa-0">
                          <span class="post-info">
                            Última Resposta: {{ post.last_comments_timestamp }}</span
                          >
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
            item-text="name"
            item-value="id"
            v-model="selectedCategory"
            label="Categoria"
            dense
            outlined
          ></v-select>
        </v-form>
        <v-btn class="mr-4" color="success" @click="createForumPost"> Postar </v-btn>
        <v-btn color="error" outlined @click="overlay = false"> Fechar </v-btn>
      </v-card>
    </v-overlay>
  </v-container>
</template>

<script>
import { mapGetters } from 'vuex';
import { getAllCourseCategories, getForumPosts, createForumPost } from '@/graphql/queries';

export default {
  name: 'Foruns',
  title: 'Forum | Find a Tutor',
  data: () => ({
    loading: true,
    attrs: {
      class: 'mb-6',
      boilerplate: true,
      elevation: 2,
    },
    page: 1,
    pagesLength: 1,
    pages: [],
    transparent: 'rgba(255, 255, 255, 0)',
    selectedItem: 0,
    title: '',
    text: '',
    overlay: false,
    categories: [],
    activeCategory: {},
    selectedCategory: [],
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
    posts: [],
    filteredPosts: [],
    zIndex: 999,
  }),
  methods: {
    newPost() {
      this.title = '';
      this.text = '';
      this.selectedCategory = 0;
      this.overlay = true;
    },
    getAllCourseCategories() {
      this.$gqlClient
        .query({
          query: this.$gql(getAllCourseCategories),
        })
        .then((response) => {
          const categories = JSON.parse(response.data.getAllCourseCategories);
          this.categories = categories;
          this.categories.splice(0, 0, {
            id: null,
            name: 'Todas',
          });
          // eslint-disable-next-line prefer-destructuring
          this.activeCategory = this.categories[0];
        });
    },
    getForumPosts() {
      this.$gqlClient
        .query({
          query: this.$gql(getForumPosts),
          fetchPolicy: 'network-only',
        })
        .then((response) => {
          const posts = JSON.parse(response.data.getForumPosts);
          this.posts.push({ header: 'Posts Recentes' });
          posts.forEach((post) => {
            this.$getProfilePicture(post.username, post.creator_picture).then((responsePicture) => {
              // eslint-disable-next-line no-param-reassign
              post.avatar = responsePicture;
              this.posts.push(post);
              this.posts.push({ divider: true, inset: true });
              this.filteredPosts = this.posts;
              this.paginate();
            });
          });
        });
    },
    createForumPost() {
      if (!this.text || !this.title) {
        return;
      }
      this.$gqlClient
        .query({
          query: this.$gql(createForumPost),
          variables: {
            title: this.title,
            description: this.text,
            category_id: this.selectedCategory,
            creator_id: this.currentUser.username,
          },
        })
        .then((response) => {
          const newPost = JSON.parse(response.data.createForumPost);
          newPost.creator_name = `${this.currentUser.attributes.name} ${this.currentUser.attributes.family_name}`;
          newPost.avatar = this.profilePicture;
          this.overlay = false;
          this.posts.push({ divider: true, inset: true });
          this.posts.push(newPost);
          this.posts.push({ divider: true, inset: true });
          this.filteredPosts = this.posts;
          this.paginate();
          this.goToPage(0);
        });
    },
    filter() {
      if (this.activeCategory !== 0) {
        this.filteredPosts = this.posts.filter((post) => post.category_id === this.activeCategory);
      } else {
        this.filteredPosts = this.posts;
      }
      this.paginate();
    },
    paginate() {
      const numPages = Math.ceil(this.filteredPosts.length / 6);
      const paginated = this.$chunkify(this.filteredPosts, numPages, false);
      this.pagesLength = paginated.length;
      this.pages = paginated;
      // eslint-disable-next-line prefer-destructuring
      this.filteredPosts = paginated[0];
      this.loading = false;
    },
    changePage() {
      this.filteredPosts = this.pages[this.page - 1];
    },
    goToPage(page) {
      if (page <= this.pages.length) {
        this.filteredPosts = this.pages[page - 1];
      } else {
        this.filteredPosts = this.pages[-1];
      }
    },
  },
  computed: {
    ...mapGetters('auth', ['currentUser']),
    ...mapGetters('profile', ['profilePicture']),
  },
  created() {
    this.getAllCourseCategories();
    this.getForumPosts();
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
