<template>
  <v-container>
    <v-container>
      <v-row>
        <v-col xl="6" cols="12">
          <h2>Nome</h2>
          <v-text-field label="Nome" v-model="cl.name"></v-text-field>
        </v-col>
        <v-col xl="6" cols="12">
          <h2>Curso</h2>
          <v-select
            :items="courses"
            item-text="name"
            item-value="id"
            v-model="cl.course_id"
            label="Curso"
            dense
            outlined
          >
          </v-select>
        </v-col>
      </v-row>

      <v-row>
        <v-col xl="6" cols="12">
          <h2>Descrição</h2>
          <textarea v-model="cl.description" auto-grow @input="update($event)"></textarea>
        </v-col>
        <v-col xl="6" cols="12">
          <h2>Preview</h2>
          <div v-html="compiledMarkdown"></div>
        </v-col>
      </v-row>
      <v-row>
        <v-col xl="6" cols="12">
          <h2>Como acessar</h2>
          <textarea v-model="cl.how_to_access" auto-grow @input="updateAccess($event)"></textarea>
        </v-col>
        <v-col xl="6" cols="12">
          <h2>Preview</h2>
          <div v-html="compiledMarkdownAccess"></div>
        </v-col>
      </v-row>
      <v-row justify="center">
        <v-col xl="6" cols="12">
          <h2 class="mb-2">Datas de início e fim</h2>
          <v-row justify="center">
            <v-col cols="12">
              <v-dialog
                ref="dialog"
                v-model="modal"
                :return-value.sync="cl.start_date"
                persistent
                width="290px"
              >
                <template v-slot:activator="{ on, attrs }">
                  <v-text-field
                    v-model="cl.start_date"
                    label="Início"
                    prepend-icon="mdi-calendar"
                    readonly
                    v-bind="attrs"
                    v-on="on"
                  ></v-text-field>
                </template>
                <v-date-picker v-model="cl.start_date" scrollable locale="pt-br">
                  <v-spacer></v-spacer>
                  <v-btn text color="primary" @click="modal = false"> Cancelar </v-btn>
                  <v-btn text color="primary" @click="$refs.dialog.save(cl.start_date)"> OK </v-btn>
                </v-date-picker>
              </v-dialog>
            </v-col>
            <v-col cols="12">
              <v-dialog
                ref="dialog"
                v-model="modal"
                :return-value.sync="cl.end_date"
                persistent
                width="290px"
              >
                <template v-slot:activator="{ on, attrs }">
                  <v-text-field
                    v-model="cl.end_date"
                    label="Fim"
                    prepend-icon="mdi-calendar"
                    readonly
                    v-bind="attrs"
                    v-on="on"
                  ></v-text-field>
                </template>
                <v-date-picker v-model="cl.end_date" scrollable locale="pt-br">
                  <v-spacer></v-spacer>
                  <v-btn text color="primary" @click="modal = false"> Cancelar </v-btn>
                  <v-btn text color="primary" @click="$refs.dialog.save(cl.end_date)"> OK </v-btn>
                </v-date-picker>
              </v-dialog>
            </v-col>
          </v-row>
          <h2 class="mb-2">Horários</h2>
          <v-col cols="12">
            <v-select
              v-model="days"
              :items="daysOfTheWeek"
              item-text="label"
              item-value="value"
              :menu-props="{ maxHeight: '400' }"
              label="Dias"
              multiple
              hint="Escolha os dias da sua aula"
              persistent-hint
            ></v-select>
          </v-col>
          <v-col cols="12">
            <div>
              <v-row justify="space-around" align="center">
                <v-col style="width: 250px; flex: 0 1 auto">
                  <h2>Começo:</h2>
                  <v-time-picker v-model="scheduleStart" :max="scheduleEnd"></v-time-picker>
                </v-col>
                <v-col style="width: 250px; flex: 0 1 auto">
                  <h2>Término:</h2>
                  <v-time-picker v-model="scheduleEnd" :min="scheduleStart"></v-time-picker>
                </v-col>
              </v-row>
            </div>
          </v-col>
        </v-col>
      </v-row>
      <v-row justify="center">
        <v-col xl="6" cols="12">
          <h2 class="mb-2">Imagem de capa</h2>
          <v-hover>
            <template v-slot:default="{ hover }">
              <v-avatar width="600" height="400" tile>
                <v-img :src="classPicture" height="300" width="600" cover></v-img>
                <v-fade-transition>
                  <v-overlay v-if="hover" absolute color="#1976d2">
                    <v-btn color="primary" @click="$refs.FileInput.click()">Alterar Imagem</v-btn>
                  </v-overlay>
                </v-fade-transition>
                <input ref="FileInput" type="file" style="display: none" @change="onFileSelect" />
              </v-avatar>
            </template>
          </v-hover>
          <v-dialog v-model="dialog" width="500">
            <v-card>
              <v-card-text>
                <VueCropper
                  v-show="selectedFile"
                  ref="cropper"
                  :src="selectedFile"
                  alt="Source Image"
                ></VueCropper>
              </v-card-text>
              <v-card-actions>
                <v-btn class="primary" @click="saveImage(), (dialog = false)">Recortar</v-btn>
                <v-btn color="error" outlined text @click="dialog = false">Cancelar</v-btn>
              </v-card-actions>
            </v-card>
          </v-dialog>
        </v-col>
      </v-row>
    </v-container>
    <v-row justify="center">
      <v-col cols="10">
        <h2 class="mb-2">Postagens</h2>
        <v-data-table
          :headers="headers"
          :items="cl.posts"
          :page.sync="page"
          :items-per-page="itemsPerPage"
          @page-count="pageCount = $event"
          hide-default-footer
          item-key="name"
          class="elevation-1"
          :search="search"
        >
          <template v-slot:top>
            <v-toolbar flat>
              <v-toolbar-title>Postagens</v-toolbar-title>
              <v-divider class="mx-4" inset vertical></v-divider>
              <v-btn color="success" dark class="mb-2" @click="addPost" text outlined>
                Nova Postagem
              </v-btn>
            </v-toolbar>
          </template>
          <template v-slot:item.edit="{ item }">
            <v-btn color="primary" text @click="editPost($event, item)">Editar</v-btn>
          </template>
          <template v-slot:item.remove="{ item }">
            <v-btn color="error" text @click="deleteCoursePost($event, item)">Remover</v-btn>
          </template>
        </v-data-table>
      </v-col>
      <v-overlay :value="loading">
        <v-progress-circular indeterminate size="64"></v-progress-circular>
      </v-overlay>
    </v-row>
    <v-row justify="center">
      <v-btn class="mr-4" color="success" x-large @click="save"> Salvar </v-btn>
    </v-row>
    <v-overlay :z-index="zIndex" :value="overlay" :dark="$vuetify.theme.dark">
      <v-card class="pa-4" min-width="600px">
        <v-form>
          <v-text-field label="Título" v-model="editingPost.title"></v-text-field>
          <v-textarea
            outlined
            name="input-7-4"
            label="Corpo"
            v-model="editingPost.body"
          ></v-textarea>
        </v-form>
        <v-btn class="mr-4" color="success" @click="saveCoursePost"> Salvar </v-btn>
        <v-btn color="error" outlined @click="overlay = false"> Fechar </v-btn>
      </v-card>
    </v-overlay>
  </v-container>
</template>

<script>
import VueCropper from 'vue-cropperjs';
// eslint-disable-next-line import/no-extraneous-dependencies
import 'cropperjs/dist/cropper.css';
import DOMPurify from 'dompurify';
import { mapGetters } from 'vuex';
import {
  getCourses,
  createCourseClassPosts,
  updateCourseClassPosts,
  deleteCourseClassPosts,
  createCourseClass,
  updateCourseClass,
} from '@/graphql/queries';

export default {
  name: 'DashboardEditCourse',
  components: { VueCropper },
  data: () => ({
    daysOfTheWeek: [
      {
        label: 'Segunda-feira',
        value: 1,
      },
      {
        label: 'Terça-feira',
        value: 2,
      },
      {
        label: 'Quarta-feira',
        value: 3,
      },
      {
        label: 'Quinta-feira',
        value: 4,
      },
      {
        label: 'Sexta-feira',
        value: 5,
      },
      {
        label: 'Sábado',
        value: 6,
      },
      {
        label: 'Domingo',
        value: 7,
      },
    ],
    days: [],
    scheduleStart: '',
    scheduleEnd: '',
    menu: false,
    modal: false,
    input: '# hello',
    page: 1,
    pageCount: 0,
    itemsPerPage: 10,
    search: '',
    isDragging: false,
    overlay: false,
    zIndex: 2,
    title: '',
    body: '',
    mime_type: '',
    cropedImage: '',
    autoCrop: false,
    selectedFile: '',
    image: '',
    dialog: false,
    posts: [],
    courses: [],
    toCreatePosts: [],
    toUpdatePosts: [],
    toDeletePosts: [],
    editingPost: {},
    courseClassId: null,
    loading: false,
    classPicture: '',
  }),
  computed: {
    ...mapGetters('auth', ['currentUser']),
    cl() {
      return this.$route.params.class;
    },
    compiledMarkdown() {
      return this.$marked(DOMPurify.sanitize(this.$route.params.class.description));
    },
    compiledMarkdownAccess() {
      return this.$marked(DOMPurify.sanitize(this.$route.params.class.how_to_access));
    },
    dateRangeText() {
      return this.dates.join(' ~ ');
    },
    headers() {
      return [
        {
          text: 'Título',
          align: 'start',
          value: 'title',
        },
        {
          text: 'Corpo',
          value: 'body',
        },
        { text: 'Editar', value: 'edit', sortable: false, align: 'center' },
        { text: 'Remover', value: 'remove', sortable: false, align: 'center' },
      ];
    },
    dragOptions() {
      return {
        animation: 0,
        group: 'description',
        ghostClass: 'ghost',
      };
    },
  },
  methods: {
    save() {
      const start = this.scheduleStart.split(':');
      const end = this.scheduleEnd.split(':');
      const cronDays = this.days.join();
      const cron = `${start[1]} ${start[0]} * * ${cronDays}`;
      this.cl.schedule = cron;
      this.cl.duration = Math.ceil(end[0] - start[0]);
      if (Number.isInteger(this.cl.id)) {
        this.updateCourseClass(this.cl);
      } else {
        this.createCourseClass(this.cl);
      }
    },
    savePosts() {
      if (this.toCreatePosts.length > 0) {
        this.toCreatePosts.forEach((post) => {
          // eslint-disable-next-line no-param-reassign
          post.course_class_id = this.courseClassId;
        });
        this.createCourseClassPosts(JSON.stringify(this.toCreatePosts));
      }
      if (this.toUpdatePosts.length > 0) {
        this.toUpdatePosts.forEach((post) => {
          // eslint-disable-next-line no-param-reassign
          post.course_class_id = this.courseClassId;
        });
        this.updateCourseClassPosts(JSON.stringify(this.toUpdatePosts));
      }
      if (this.toDeletePosts.length > 0) {
        this.deleteCourseClassPosts(JSON.stringify(this.toDeletePosts));
      }
    },
    saveCoursePost() {
      if (this.editingPost.id == null) {
        this.toCreatePosts.push(this.editingPost);
        this.cl.posts.push(this.editingPost);
      } else {
        this.toUpdatePosts.push(this.editingPost);
      }
      this.overlay = false;
    },
    // eslint-disable-next-line camelcase
    deleteCoursePost(event, to_delete_post) {
      this.toCreatePosts.forEach((post) => {
        // eslint-disable-next-line eqeqeq
        if (post.id == to_delete_post.id) {
          // eslint-disable-next-line no-param-reassign
          const index = this.toCreatePosts.indexOf(post);
          if (index > -1) {
            this.toCreatePosts.splice(index, 1);
          }
        }
      });
      this.toUpdatePosts.forEach((post) => {
        // eslint-disable-next-line eqeqeq
        if (post.id == to_delete_post.id) {
          // eslint-disable-next-line no-param-reassign
          const index = this.toUpdatePosts.indexOf(post);
          if (index > -1) {
            this.toUpdatePosts.splice(index, 1);
          }
        }
      });
      this.cl.posts.forEach((post) => {
        // eslint-disable-next-line eqeqeq
        if (post.id == to_delete_post.id) {
          // eslint-disable-next-line no-param-reassign
          const index = this.cl.posts.indexOf(post);
          if (index > -1) {
            this.cl.posts.splice(index, 1);
          }
        }
      });
      if (Number.isInteger(to_delete_post.id)) {
        this.toDeletePosts.push(to_delete_post);
      }
    },
    // eslint-disable-next-line func-names
    update(event) {
      this.cl.description = event.target.value;
    },
    updateAccess(event) {
      this.cl.how_to_access = event.target.value;
    },
    onMove({ relatedContext, draggedContext }) {
      const relatedElement = relatedContext.element;
      const draggedElement = draggedContext.element;
      return (!relatedElement || !relatedElement.fixed) && !draggedElement.fixed;
    },
    editPost(event, post) {
      this.editingPost = null;
      this.editingPost = post;
      this.overlay = true;
    },
    addPost() {
      this.editingStep = {};
      this.editingStep.id = null;
      this.editingStep.course_class_id = null;
      this.editingStep.title = '';
      this.editingStep.body = '';
      this.editingStep.created_at = this.$getFormattedDate();
      this.editingStep.updated_at = this.$getFormattedDate();
      this.overlay = true;
    },
    uuidv4() {
      return 'xxxx-xxxx-xxx-xxxx'.replace(/[x]/g, () => {
        const r = Math.floor(Math.random() * 16);
        return r.toString(16);
      });
    },
    saveImage() {
      this.overlayUpload = !this.overlayUpload;
      this.cropedImage = this.$refs.cropper.getCroppedCanvas().toDataURL();
      const fileName = `${this.uuidv4()}.${this.mime_type.replace('image/', '')}`;
      this.$refs.cropper.getCroppedCanvas().toBlob(async (blob) => {
        await this.$store.dispatch('course/updateCourseImage', {
          file: blob,
          fileName,
        });
        this.cl.image = fileName;
      }, this.mime_type);
      this.overlayUpload = !this.overlayUpload;
    },
    onFileSelect(e) {
      const file = e.target.files[0];
      this.mime_type = file.type;
      if (typeof FileReader === 'function') {
        this.dialog = true;
        const reader = new FileReader();
        reader.onload = (event) => {
          this.selectedFile = event.target.result;
          this.$refs.cropper.replace(this.selectedFile);
        };
        reader.readAsDataURL(file);
      } else {
        console.log('Sorry, FileReader API not supported');
      }
    },
    getCourses() {
      this.$gqlClient
        .query({
          query: this.$gql(getCourses),
          fetchPolicy: 'network-only',
          variables: { user_id: this.currentUser.username },
        })
        .then((response) => {
          const result = JSON.parse(response.data.getCourses);
          this.courses = result;
        });
    },
    createCourseClassPosts(posts) {
      this.$gqlClient.query({
        query: this.$gql(createCourseClassPosts),
        fetchPolicy: 'network-only',
        variables: {
          posts,
        },
      });
    },
    updateCourseClassPosts(posts) {
      this.$gqlClient.query({
        query: this.$gql(updateCourseClassPosts),
        fetchPolicy: 'network-only',
        variables: {
          posts,
        },
      });
    },
    deleteCourseClassPosts(posts) {
      this.$gqlClient.query({
        query: this.$gql(deleteCourseClassPosts),
        fetchPolicy: 'network-only',
        variables: {
          posts,
        },
      });
    },
    createCourseClass() {
      this.loading = true;
      this.$gqlClient
        .query({
          query: this.$gql(createCourseClass),
          fetchPolicy: 'network-only',
          variables: {
            name: this.cl.name,
            description: this.cl.description,
            image: this.cl.image,
            schedule: this.cl.schedule,
            how_to_access: this.cl.how_to_access,
            duration: this.cl.duration,
            start_date: this.cl.start_date,
            end_date: this.cl.end_date,
            course_id: this.cl.course_id,
            id: 0,
          },
        })
        .then((response) => {
          const result = JSON.parse(response.data.createCourseClass);
          this.courseClassId = result.id;
          this.savePosts();
          this.loading = false;
        });
    },
    updateCourseClass() {
      this.loading = true;
      this.$gqlClient
        .query({
          query: this.$gql(updateCourseClass),
          fetchPolicy: 'network-only',
          variables: {
            name: this.cl.name,
            description: this.cl.description,
            image: this.cl.image,
            schedule: this.cl.schedule,
            how_to_access: this.cl.how_to_access,
            duration: this.cl.duration,
            start_date: this.cl.start_date,
            end_date: this.cl.end_date,
            course_id: this.cl.course_id,
            id: this.cl.id,
            created_at: this.cl.created_at,
          },
        })
        .then((response) => {
          const result = JSON.parse(response.data.updateCourseClass);
          this.courseClassId = result.id;
          this.savePosts();
          this.loading = false;
        });
    },
  },
  watch: {
    isDragging(newValue) {
      if (newValue) {
        this.delayedDragging = true;
        return;
      }
      this.$nextTick(() => {
        this.delayedDragging = false;
      });
    },
  },
  async created() {
    this.getCourses();
    const classSchedule = this.$route.params.class.schedule.split(' ');
    this.days = classSchedule.at(-1).split(',');
    const daysInteger = [];
    this.days.forEach((day) => {
      daysInteger.push(parseInt(day, 10));
    });
    this.days = daysInteger;
    this.scheduleStart = `${classSchedule[1]}:${classSchedule[0]}`;
    const endHour =
      parseInt(classSchedule[1], 10) + parseInt(this.$route.params.class.duration, 10);
    this.scheduleEnd = `${endHour}:${classSchedule[0]}`;
    this.classPicture = await this.$getKeyUrl(this.$route.params.class.image);
  },
};
</script>

<style lang="scss" scoped>
textarea {
  border: none;
  border-right: 1px solid #ccc;
  resize: none;
  outline: none;
  background-color: #f6f6f6;
  font-size: 14px;
  font-family: 'Monaco', courier, monospace;
  padding: 20px;
  width: 100%;
  min-height: 300px;
}

.page--table {
  .page {
    &__table {
      margin-top: 20px;
    }
    &__grab-icon {
      cursor: move;
    }
  }
}

.flip-list-move {
  transition: transform 1s;
}

.ghost {
  opacity: 0.2;
}
</style>
