/* eslint-disable consistent-return */
/* eslint-disable func-names */
/* eslint-disable no-param-reassign */
/* eslint-disable no-undef */
/* eslint-disable no-plusplus */
/* eslint-disable no-unused-vars */
import Vue from 'vue';
import { Storage } from 'aws-amplify';

Vue.use({
  install() {
    Vue.cloudfrontUrl = 'd2xja4rap1t567.cloudfront.net';

    Vue.prototype.$chunkify = (a, n, balanced) => {
      if (n < 2) return [a];

      const len = a.length;
      const out = [];
      let i = 0;
      let size;

      if (len % n === 0) {
        size = Math.floor(len / n);
        while (i < len) {
          out.push(a.slice(i, (i += size)));
        }
      } else if (balanced) {
        while (i < len) {
          size = Math.ceil((len - i) / n--);
          out.push(a.slice(i, (i += size)));
        }
      } else {
        n--;
        size = Math.floor(len / n);
        if (len % size === 0) size--;
        while (i < size * n) {
          out.push(a.slice(i, (i += size)));
        }
        out.push(a.slice(size * n));
      }

      return out;
    };
    Vue.prototype.$getProfilePicture = async (username, pictureUrl) => {
      if (username.includes('Facebook')) {
        const picture = await Storage.get('default-profile-picture.png', {
          level: 'public',
        });
        return picture;
      }
      if (username.includes('Google')) {
        return pictureUrl;
      }
      try {
        if (pictureUrl === 'default-profile-picture.png') {
          const picture = await Storage.get(pictureUrl, {
            level: 'public',
          });
          return picture;
        }

        const picture = await Storage.get(pictureUrl, {
          level: 'private',
        });
        return picture;
      } catch (err) {
        console.error(err);
      }
    };
  },
});
