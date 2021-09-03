<template>
  <v-container>
    <v-container>
      <v-row>
        <v-col xl="6" cols="12">
          <h2>Nome</h2>
          <v-text-field label="Nome" v-model="course.name"></v-text-field>
        </v-col>
        <v-col xl="3" xs="12" cols="6">
          <h2>Categoria</h2>
          <v-select
            :items="categories"
            item-text="name"
            item-value="id"
            v-model="course.category_id"
            label="Categoria"
            dense
            outlined
          >
          </v-select>
        </v-col>
        <v-col xl="3" xs="12" cols="6">
          <h2>Valor (R$)</h2>
          <v-text-field label="Valor" v-model="course.price"></v-text-field>
        </v-col>
      </v-row>
      <v-row>
        <v-col xl="6" cols="12">
          <h2>Descrição</h2>
          <textarea v-model="course.description" auto-grow @input="update($event)"></textarea>
        </v-col>
        <v-col xl="6" cols="12">
          <h2>Preview</h2>
          <div v-html="compiledMarkdown"></div>
        </v-col>
      </v-row>
      <v-row>
        <v-col xl="6" cols="12">
          <h2>Descrição curta (Preview)</h2>
          <textarea
            v-model="course.short_description"
            auto-grow
            @input="updateShort($event)"
          ></textarea>
        </v-col>
        <v-col xl="6" cols="12">
          <h2>Preview</h2>
          <div v-html="compiledMarkdownShort"></div>
        </v-col>
      </v-row>
    </v-container>
    <v-row justify="center">
      <v-col xl="6" cols="12">
        <h2 class="mb-2">Imagem de capa</h2>
        <v-hover>
          <template v-slot:default="{ hover }">
            <v-avatar width="600" height="400" tile>
              <img :src="$cloudfrontUrl + 'public/' + course.image" alt="imagem do curso" />
              <v-fade-transition>
                <v-overlay v-if="hover" absolute color="#1976d2">
                  <v-btn color="primary" @click="$refs.FileInput.click()">Mudar Foto</v-btn>
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
    <v-row justify="center">
      <v-col cols="12">
        <h2 class="mb-2">Aulas</h2>
        <v-data-table
          :headers="headers"
          :items="course.steps"
          :page.sync="page"
          :items-per-page="itemsPerPage"
          @page-count="pageCount = $event"
          hide-default-footer
          item-key="name"
          class="elevation-1 page__table"
          :search="search"
        >
          <template v-slot:top>
            <v-toolbar flat>
              <v-toolbar-title>Aulas</v-toolbar-title>
              <v-divider class="mx-4" inset vertical></v-divider>
              <v-btn color="success" dark class="mb-2" @click="addLecture" text outlined>
                Adicionar Aula
              </v-btn>
            </v-toolbar>
          </template>
          <template v-slot:body="props">
            <draggable
              ghost-class="ghost"
              v-bind="dragOptions"
              :move="onMove"
              @start="isDragging = true"
              @end="onEnd"
              :list="course.steps"
              tag="tbody"
            >
              <tr v-for="(lecture, index) in course.steps" :key="index">
                <td>
                  <v-icon small class="page__grab-icon"> mdi-arrow-all </v-icon>
                </td>
                <td>
                  <b>{{ index + 1 }}</b>
                </td>
                <td>{{ lecture.name }}</td>
                <td>{{ lecture.description }}</td>
                <td>
                  <v-btn color="primary" @click="editLecture($event, lecture)" text>Editar</v-btn>
                </td>
                <td>
                  <v-btn color="error" text @click="deleteCourseStep($event, lecture)"
                    >Remover</v-btn
                  >
                </td>
              </tr>
            </draggable>
          </template>
        </v-data-table>
      </v-col>
      <v-btn class="mr-4" color="success" @click="save" x-large> Salvar </v-btn>
      <v-snackbar v-model="snackbar">
        {{ text }}

        <template v-slot:action="{ attrs }">
          <v-btn color="primary" text v-bind="attrs" @click="snackbar = false"> Close </v-btn>
        </template>
      </v-snackbar>
    </v-row>
    <v-overlay :z-index="zIndex" :value="overlay" :dark="$vuetify.theme.dark">
      <v-card class="pa-4" min-width="600px">
        <v-form>
          <v-text-field label="Nome" v-model="editingStep.name"></v-text-field>
          <v-textarea
            outlined
            name="input-7-4"
            label="Descrição"
            v-model="editingStep.description"
          ></v-textarea>
          <v-row justify="start" align="center" class="mb-4">
            <v-col cols="6">
              <template>
                <v-file-input show-size label="Arquivo" @change="uploadVideo"></v-file-input>
              </template>
            </v-col>
            <v-col cols="6">
              <span><v-icon left> fas fa-file-video </v-icon> {{ editingStep.video }}</span>
            </v-col>
            <v-overlay :value="loading">
              <v-progress-circular indeterminate size="64"></v-progress-circular>
            </v-overlay>
          </v-row>
        </v-form>
        <v-btn class="mr-4" color="success" @click="saveCourseStep"> Salvar </v-btn>
        <v-btn color="error" outlined @click="overlay = false" text> Fechar </v-btn>
      </v-card>
    </v-overlay>
  </v-container>
</template>

<script>
import draggable from 'vuedraggable';
import VueCropper from 'vue-cropperjs';
// eslint-disable-next-line import/no-extraneous-dependencies
import 'cropperjs/dist/cropper.css';
import { mapGetters } from 'vuex';
import {
  getAllCourseCategories,
  createCourseSteps,
  updateCourseSteps,
  deleteCourseSteps,
  createCourse,
  updateCourse,
} from '@/graphql/queries';
import DOMPurify from 'dompurify';

export default {
  name: 'DashboardEditCourse',
  components: { draggable, VueCropper },
  data: () => ({
    items: ['Tecnologia', 'Música', 'Matemática', 'Desenho'],
    input: '# hello',
    page: 1,
    pageCount: 0,
    itemsPerPage: 10,
    search: '',
    isDragging: false,
    overlay: false,
    zIndex: 2,
    name: '',
    description: '',
    video: '',
    text: 'Salvo com sucesso!',
    snackbar: false,
    mime_type: '',
    cropedImage: '',
    autoCrop: false,
    selectedFile: '',
    image: '',
    dialog: false,
    files: '',
    overlayUpload: false,
    editingStep: {},
    categories: [],
    toCreateSteps: [],
    toUpdateSteps: [],
    toDeleteSteps: [],
    loading: false,
    courseId: null,
  }),
  computed: {
    ...mapGetters('auth', ['currentUser']),
    course() {
      return this.$route.params.course;
    },
    compiledMarkdown() {
      return this.$marked(DOMPurify.sanitize(this.$route.params.course.description));
    },
    compiledMarkdownShort() {
      return this.$marked(DOMPurify.sanitize(this.$route.params.course.short_description));
    },
    headers() {
      return [
        {
          text: '',
          align: 'start',
          sortable: false,
          value: 'drag',
        },
        {
          text: '#',
          align: 'start',
          sortable: false,
          value: 'order',
        },
        {
          text: 'Nome',
          align: 'start',
          value: 'name',
        },
        {
          text: 'Descrição',
          value: 'description',
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
      if (Number.isInteger(this.course.id)) {
        this.updateCourse(this.course);
      } else {
        this.createCourse(this.course);
      }
    },
    saveSteps() {
      if (this.toCreateSteps.length > 0) {
        this.toCreateSteps.forEach((step) => {
          // eslint-disable-next-line no-param-reassign
          step.course_id = this.courseId;
        });
        this.createCourseSteps(JSON.stringify(this.toCreateSteps));
      }
      if (this.toUpdateSteps.length > 0) {
        this.toUpdateSteps.forEach((step) => {
          // eslint-disable-next-line no-param-reassign
          step.course_id = this.courseId;
        });
        this.updateCourseSteps(JSON.stringify(this.toUpdateSteps));
      }
      if (this.toDeleteSteps.length > 0) {
        this.deleteCourseSteps(JSON.stringify(this.toDeleteSteps));
      }
    },
    saveCourseStep() {
      if (this.editingStep.id == null) {
        this.toCreateSteps.push(this.editingStep);
        this.course.steps.push(this.editingStep);
      } else {
        this.toUpdateSteps.push(this.editingStep);
      }
      this.overlay = false;
    },
    deleteCourseStep(event, lecture) {
      this.toCreateSteps.forEach((step) => {
        // eslint-disable-next-line eqeqeq
        if (step.id == lecture.id) {
          // eslint-disable-next-line no-param-reassign
          const index = this.toCreateSteps.indexOf(step);
          if (index > -1) {
            this.toCreateSteps.splice(index, 1);
          }
        }
      });
      this.toUpdateSteps.forEach((step) => {
        // eslint-disable-next-line eqeqeq
        if (step.id == lecture.id) {
          // eslint-disable-next-line no-param-reassign
          const index = this.toUpdateSteps.indexOf(step);
          if (index > -1) {
            this.toUpdateSteps.splice(index, 1);
          }
        }
      });
      this.course.steps.forEach((step) => {
        // eslint-disable-next-line eqeqeq
        if (step.id == lecture.id) {
          // eslint-disable-next-line no-param-reassign
          const index = this.course.steps.indexOf(step);
          if (index > -1) {
            this.course.steps.splice(index, 1);
          }
        }
      });
      if (Number.isInteger(lecture.id)) {
        this.toDeleteSteps.push(lecture);
      }
    },
    // eslint-disable-next-line func-names
    update(event) {
      this.course.description = event.target.value;
    },
    // eslint-disable-next-line func-names
    updateShort(event) {
      this.course.short_description = event.target.value;
    },
    onMove({ relatedContext, draggedContext }) {
      const relatedElement = relatedContext.element;
      const draggedElement = draggedContext.element;
      return (!relatedElement || !relatedElement.fixed) && !draggedElement.fixed;
    },
    // eslint-disable-next-line no-unused-vars
    onEnd() {
      this.isDragging = false;
      this.updateList(this.course.steps);
    },
    editLecture(event, lecture) {
      this.editingStep = null;
      this.editingStep = lecture;
      this.overlay = true;
    },
    addLecture() {
      this.editingStep = {};
      this.editingStep.course_id = null;
      this.editingStep.created_at = this.$getFormattedDate();
      this.editingStep.description = '';
      this.editingStep.id = null;
      this.editingStep.name = '';
      this.editingStep.order = this.course.steps.length + 1;
      this.editingStep.updated_at = this.$getFormattedDate();
      this.editingStep.video = '';
      this.overlay = true;
    },
    updateList(l) {
      l.forEach((step, i) => {
        // eslint-disable-next-line no-param-reassign
        step.order = i + 1;
      });
      this.course.steps = l;
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
        this.course.image = fileName;
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
    async uploadVideo(file) {
      this.loading = true;
      const fileName = `${this.uuidv4()}.mp4`;
      await this.$store.dispatch('course/uploadVideo', {
        file,
        fileName,
      });
      this.editingStep.video = fileName;
      this.loading = false;
    },
    getAllCourseCategories() {
      this.$gqlClient
        .query({
          query: this.$gql(getAllCourseCategories),
        })
        .then((response) => {
          const result = JSON.parse(response.data.getAllCourseCategories);
          this.categories = result;
        });
    },
    createCourseSteps(steps) {
      this.$gqlClient.query({
        query: this.$gql(createCourseSteps),
        fetchPolicy: 'network-only',
        variables: {
          steps,
        },
      });
    },
    updateCourseSteps(steps) {
      this.$gqlClient.query({
        query: this.$gql(updateCourseSteps),
        fetchPolicy: 'network-only',
        variables: {
          steps,
        },
      });
    },
    deleteCourseSteps(steps) {
      this.$gqlClient.query({
        query: this.$gql(deleteCourseSteps),
        fetchPolicy: 'network-only',
        variables: {
          steps,
        },
      });
    },
    createCourse() {
      this.loading = true;
      this.$gqlClient
        .query({
          query: this.$gql(createCourse),
          fetchPolicy: 'network-only',
          variables: {
            name: this.course.name,
            description: this.course.description,
            short_description: this.course.short_description,
            image: this.course.image,
            price: this.course.price,
            category_id: this.course.category_id,
            owner_id: this.currentUser.username,
            id: 0,
          },
        })
        .then((response) => {
          const result = JSON.parse(response.data.createCourse);
          this.courseId = result.id;
          this.saveSteps();
          this.loading = false;
        });
    },
    updateCourse() {
      this.loading = true;
      this.$gqlClient
        .query({
          query: this.$gql(updateCourse),
          fetchPolicy: 'network-only',
          variables: {
            id: this.course.id,
            name: this.course.name,
            description: this.course.description,
            short_description: this.course.short_description,
            image: this.course.image,
            price: this.course.price,
            category_id: this.course.category_id,
            owner_id: this.currentUser.username,
            created_at: this.course.created_at,
          },
        })
        .then((response) => {
          const result = JSON.parse(response.data.updateCourse);
          this.courseId = result.id;
          this.saveSteps();
          this.loading = false;
        });
    },
  },
  created() {
    this.getAllCourseCategories();
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
