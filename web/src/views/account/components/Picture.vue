/* eslint-disable no-bitwise */ /* eslint-disable no-bitwise */ /* eslint-disable no-bitwise */ /*
eslint-disable eqeqeq */ /* eslint-disable no-bitwise */
<template>
  <div>
    <div size="120" class="user">
      <v-img :src="image_name" class="profile-img"></v-img>
      <v-icon class="icon primary white--text" @click="$refs.FileInput.click()">mdi-upload</v-icon>
      <input ref="FileInput" type="file" style="display: none" @change="onFileSelect" />
    </div>
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
          <v-btn class="primary" @click="saveImage(), (dialog = false)">Crop</v-btn>
          <v-btn color="primary" text @click="dialog = false">Cancel</v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </div>
</template>

<script>
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
    };
  },
  methods: {
    uuidv4() {
      return 'xxxx-xxxx-xxx-xxxx'.replace(/[x]/g, () => {
        const r = Math.floor(Math.random() * 16);
        return r.toString(16);
      });
    },
    saveImage() {
      this.cropedImage = this.$refs.cropper.getCroppedCanvas().toDataURL();
      this.$refs.cropper.getCroppedCanvas().toBlob(async (blob) => {
        await this.$store.dispatch('profile/updateProfilePicture', {
          file: blob,
          fileName: `${this.uuidv4()}.${this.mime_type.replace('image/', '')}`,
        });
      }, this.mime_type);
    },
    onFileSelect(e) {
      const file = e.target.files[0];
      this.mime_type = file.type;
      console.log(this.mime_type);
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
  border: 3px solid #2e7d32;
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
