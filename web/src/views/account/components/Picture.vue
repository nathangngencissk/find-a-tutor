<template>
  <v-container>
    <v-subheader> Foto </v-subheader>
    <v-sheet elevation="1" height="400">
      <v-row justify="center" align="center">
        <v-col cols="4">
          <v-hover>
            <template v-slot:default="{ hover }">
              <v-avatar class="mt-10" width="300" height="300">
                <img :src="profilePicture" alt="profilePicture" />
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
      <v-overlay :value="overlayUpload">
        <v-progress-circular indeterminate size="64"></v-progress-circular>
      </v-overlay>
    </v-sheet>
  </v-container>
</template>

<script>
import { mapGetters } from 'vuex';
import VueCropper from 'vue-cropperjs';
// eslint-disable-next-line import/no-extraneous-dependencies
import 'cropperjs/dist/cropper.css';

export default {
  name: 'Picture',
  components: { VueCropper },
  props: ['image_name'],
  data() {
    return {
      mime_type: '',
      cropedImage: '',
      autoCrop: false,
      selectedFile: '',
      image: '',
      dialog: false,
      files: '',
      overlay: false,
      overlayUpload: false,
    };
  },
  computed: {
    ...mapGetters('profile', ['profilePicture']),
  },
  methods: {
    uuidv4() {
      return 'xxxx-xxxx-xxx-xxxx'.replace(/[x]/g, () => {
        const r = Math.floor(Math.random() * 16);
        return r.toString(16);
      });
    },
    saveImage() {
      this.overlayUpload = !this.overlayUpload;
      console.log(this.overlayUpload);
      this.cropedImage = this.$refs.cropper.getCroppedCanvas().toDataURL();
      this.$refs.cropper.getCroppedCanvas().toBlob(async (blob) => {
        await this.$store.dispatch('profile/updateProfilePicture', {
          file: blob,
          fileName: `${this.uuidv4()}.${this.mime_type.replace('image/', '')}`,
        });
      }, this.mime_type);
      this.overlayUpload = !this.overlayUpload;
      console.log(this.overlayUpload);
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
  },
  async updateProfilePicture(e) {
    const file = e.target.files[0];
    await this.$store.dispatch('profile/updateProfilePicture', {
      file,
    });
  },
};
</script>
<style scoped>
.user {
  width: 140px;
  height: 140px;
  border-radius: 100%;
  border: 3px solid #1976d2;
  position: relative;
}
.profile-img {
  height: 100%;
  width: 100%;
  border-radius: 50%;
}
.icon {
  position: absolute;
  top: 10px;
  right: 0;
  background: #e2e2e2;
  border-radius: 100%;
  width: 30px;
  height: 30px;
  line-height: 30px;
  vertical-align: middle;
  text-align: center;
  color: #0000ff;
  font-size: 14px;
  cursor: pointer;
}
</style>
