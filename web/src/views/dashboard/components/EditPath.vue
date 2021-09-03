<template>
  <v-container>
    <v-row justify="center">
      <v-col xl="6" cols="12">
        <h2>Nome</h2>
        <v-text-field label="Nome" v-model="path.name"></v-text-field>
      </v-col>
    </v-row>
    <v-row justify="center">
      <v-col xl="6" cols="12">
        <h2>Descrição</h2>
        <v-textarea
          class="mt-2"
          outlined
          name="input-7-4"
          label="Descrição"
          v-model="path.description"
        ></v-textarea>
      </v-col>
    </v-row>
    <v-row justify="center">
      <v-col xl="6" cols="12">
        <h2 class="mb-2">Imagem de capa</h2>
        <v-hover>
          <template v-slot:default="{ hover }">
            <v-avatar width="600" height="400" tile>
              <v-img
                :src="$cloudfrontUrl + 'public/' + path.image"
                height="300"
                width="600"
                cover
              ></v-img>
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
    <v-row justify="center" v-for="course in path.courses" :key="course.id">
      <v-col xl="6" cols="12">
        <v-row>
          <v-col cols="10">
            <v-subheader>{{ course.section_name }} </v-subheader>
          </v-col>
          <v-col cols="2">
            <v-btn
              class="mx-2"
              fab
              dark
              small
              color="error"
              @click="deletePathCourse($event, course)"
            >
              <v-icon dark> mdi-minus </v-icon>
            </v-btn>
          </v-col>
        </v-row>

        <h3 class="mb-2">Curso: {{ course.name }}</h3>
        <v-hover>
          <template v-slot:default="{ hover }">
            <v-img :src="$cloudfrontUrl + 'public/' + course.image" height="300" width="600" cover>
              <v-fade-transition>
                <v-overlay v-if="hover" absolute color="rgba(0, 0, 0, 0.87)">
                  <v-btn color="primary" @click="change($event, course)">Alterar</v-btn>
                </v-overlay>
              </v-fade-transition>
            </v-img>
          </template>
        </v-hover>
      </v-col>
    </v-row>
    <v-row justify="center" class="my-3">
      <v-btn color="primary" @click="addSection">Adicionar Seção</v-btn>
    </v-row>
    <v-row justify="center">
      <v-btn color="success" x-large @click="save"> Salvar </v-btn>
    </v-row>
    <v-dialog v-model="dialogPathCourse" scrollable max-width="600px">
      <v-card>
        <v-card-title>Selecione o Curso</v-card-title>
        <v-divider></v-divider>
        <v-card-text style="height: 600px">
          <v-form>
            <v-text-field
              label="Nome da seção"
              placeholder="Nome da seção"
              v-model="sectionName"
            ></v-text-field>
            <v-text-field label="Buscar" v-model="keywords"></v-text-field>
            <v-btn color="success" depressed outlined @click="searchCourse" class="mb-2"
              >Buscar</v-btn
            >
            <v-row>
              <v-card
                class="mx-auto mt-2"
                max-width="400"
                v-for="result in searchResults"
                :key="result.id"
              >
                <v-img
                  class="white--text align-end"
                  height="200px"
                  :src="$cloudfrontUrl + 'public/' + result.image"
                >
                  <v-card-title>{{ result.name }}</v-card-title>
                </v-img>

                <v-card-subtitle class="pb-0 mb-1">
                  {{ result.category_name }}
                  <div>
                    <b class="mr-1">Avaliação: </b> {{ result.avg_rating }} ({{ result.reviews }})
                  </div>
                </v-card-subtitle>

                <v-card-text class="text--primary">
                  <p>
                    {{ result.short_description }}
                  </p>
                </v-card-text>

                <v-card-actions>
                  <v-btn
                    color="primary"
                    text
                    @click="changeSectionCourse($event, result)"
                    v-if="editingPathCourse.id !== null"
                  >
                    Escolher
                  </v-btn>
                  <v-btn color="primary" text @click="addSectionCourse($event, result)" v-else>
                    Escolher
                  </v-btn>
                </v-card-actions>
              </v-card>
              <v-overlay :value="loading">
                <v-progress-circular indeterminate size="64"></v-progress-circular>
              </v-overlay>
            </v-row>
          </v-form>
        </v-card-text>
        <v-divider></v-divider>
        <v-card-actions>
          <v-btn
            class="white--text mr-4"
            color="success"
            v-if="editingPathCourse.id !== null"
            @click="changeSectionCourse($event, editingPathCourse)"
          >
            Salvar
          </v-btn>
          <v-btn
            class="white--text mr-4"
            color="success"
            v-else
            @click="addSectionCourse($event, result)"
          >
            Salvar
          </v-btn>
          <v-btn class="white--text" color="error" outlined @click="dialogPathCourse = false">
            Fechar
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </v-container>
</template>

<script>
import VueCropper from 'vue-cropperjs';
// eslint-disable-next-line import/no-extraneous-dependencies
import 'cropperjs/dist/cropper.css';
import { mapGetters } from 'vuex';
import {
  createPathCourses,
  updatePathCourses,
  deletePathCourses,
  createPath,
  updatePath,
  searchCourse,
} from '@/graphql/queries';

export default {
  name: 'DashboardEditPath',
  components: { VueCropper },
  data: () => ({
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
    toCreatePathCourses: [],
    toUpdatePathCourses: [],
    toDeletePathCourses: [],
    editingPathCourse: {},
    pathId: null,
    loading: false,
    searchResults: [],
    keywords: [],
    dialogPathCourse: false,
    sectionName: '',
  }),
  computed: {
    ...mapGetters('auth', ['currentUser']),
    path() {
      return this.$route.params.path;
    },
  },
  methods: {
    changeSectionCourse(event, result) {
      this.editingPathCourse.course_id = result.id;
      this.editingPathCourse.name = result.name;
      this.editingPathCourse.section_name = this.sectionName;
      this.editingPathCourse.image = result.image;
      this.path.courses.forEach((course) => {
        // eslint-disable-next-line eqeqeq
        if (course.id == this.editingPathCourse.id) {
          // eslint-disable-next-line no-param-reassign
          course = this.editingPathCourse;
        }
      });
      this.toUpdatePathCourses.push({
        id: this.editingPathCourse.id,
        path_id: this.editingPathCourse.path_id,
        course_id: result.id,
        section_name: this.sectionName,
        order: this.path.courses.length,
        created_at: this.editingPathCourse.created_at,
        updated_at: this.$getFormattedDate(),
      });
      this.dialogPathCourse = false;
    },
    addSection() {
      this.editingPathCourse = {};
      this.sectionName = '';
      this.editingPathCourse.id = null;
      this.dialogPathCourse = true;
    },
    addSectionCourse(event, result) {
      this.editingPathCourse.course_id = result.id;
      this.editingPathCourse.name = result.name;
      this.editingPathCourse.section_name = this.sectionName;
      this.editingPathCourse.image = result.image;
      this.path.courses.push(this.editingPathCourse);
      this.toCreatePathCourses.push({
        id: null,
        path_id: null,
        course_id: result.id,
        section_name: this.sectionName,
        order: this.path.courses.length,
        created_at: this.$getFormattedDate(),
        updated_at: this.$getFormattedDate(),
      });
      this.dialogPathCourse = false;
    },
    deletePathCourse(event, result) {
      this.toCreatePathCourses.forEach((course) => {
        // eslint-disable-next-line eqeqeq
        if (course.id == result.id) {
          // eslint-disable-next-line no-param-reassign
          const index = this.toCreatePathCourses.indexOf(course);
          if (index > -1) {
            this.toCreatePathCourses.splice(index, 1);
          }
        }
      });
      this.toUpdatePathCourses.forEach((course) => {
        // eslint-disable-next-line eqeqeq
        if (course.id == result.id) {
          // eslint-disable-next-line no-param-reassign
          const index = this.toUpdatePathCourses.indexOf(course);
          if (index > -1) {
            this.toUpdatePathCourses.splice(index, 1);
          }
        }
      });
      this.path.courses.forEach((course) => {
        // eslint-disable-next-line eqeqeq
        if (course.id == result.id) {
          // eslint-disable-next-line no-param-reassign
          const index = this.path.courses.indexOf(course);
          if (index > -1) {
            this.path.courses.splice(index, 1);
          }
        }
      });
      if (Number.isInteger(result.id)) {
        this.toDeletePathCourses.push({ id: result.id });
      }
    },
    change(event, course) {
      this.editingPathCourse = {};
      this.editingPathCourse = course;
      this.sectionName = course.section_name;
      this.dialogPathCourse = true;
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
        this.path.image = fileName;
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
    save() {
      if (Number.isInteger(this.path.id)) {
        this.updatePath(this.path);
      } else {
        this.createPath(this.path);
      }
    },
    savePaths() {
      if (this.toCreatePathCourses.length > 0) {
        this.toCreatePathCourses.forEach((course) => {
          // eslint-disable-next-line no-param-reassign
          course.path_id = this.pathId;
        });
        this.createPathCourses(JSON.stringify(this.toCreatePathCourses));
      }
      if (this.toUpdatePathCourses.length > 0) {
        this.toUpdatePathCourses.forEach((course) => {
          // eslint-disable-next-line no-param-reassign
          course.path_id = this.pathId;
        });
        this.updatePathCourses(JSON.stringify(this.toUpdatePathCourses));
      }
      if (this.toDeletePathCourses.length > 0) {
        this.deletePathCourses(JSON.stringify(this.toDeletePathCourses));
      }
    },
    createPathCourses(courses) {
      this.$gqlClient.query({
        query: this.$gql(createPathCourses),
        fetchPolicy: 'network-only',
        variables: {
          courses,
        },
      });
    },
    updatePathCourses(courses) {
      this.$gqlClient.query({
        query: this.$gql(updatePathCourses),
        fetchPolicy: 'network-only',
        variables: {
          courses,
        },
      });
    },
    deletePathCourses(courses) {
      this.$gqlClient.query({
        query: this.$gql(deletePathCourses),
        fetchPolicy: 'network-only',
        variables: {
          courses,
        },
      });
    },
    createPath() {
      this.loading = true;
      this.$gqlClient
        .query({
          query: this.$gql(createPath),
          fetchPolicy: 'network-only',
          variables: {
            name: this.path.name,
            description: this.path.description,
            image: this.path.image,
            creator_id: this.currentUser.username,
          },
        })
        .then((response) => {
          const result = JSON.parse(response.data.createPath);
          this.pathId = result.id;
          this.savePaths();
          this.loading = false;
        });
    },
    updatePath() {
      this.loading = true;
      this.$gqlClient
        .query({
          query: this.$gql(updatePath),
          fetchPolicy: 'network-only',
          variables: {
            name: this.path.name,
            description: this.path.description,
            image: this.path.image,
            creator_id: this.currentUser.username,
            id: this.path.id,
            created_at: this.path.created_at,
          },
        })
        .then((response) => {
          const result = JSON.parse(response.data.updatePath);
          this.pathId = result.id;
          this.savePaths();
          this.loading = false;
        });
    },
    searchCourse() {
      this.loading = true;
      this.$gqlClient
        .query({
          query: this.$gql(searchCourse),
          fetchPolicy: 'network-only',
          variables: {
            keywords: this.keywords,
          },
        })
        .then((response) => {
          const result = JSON.parse(response.data.searchCourse);
          this.searchResults = result;
          this.loading = false;
        });
    },
  },
  created() {},
};
</script>
