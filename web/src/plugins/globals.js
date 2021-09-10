/* eslint-disable consistent-return */
/* eslint-disable func-names */
/* eslint-disable no-param-reassign */
/* eslint-disable no-undef */
/* eslint-disable no-plusplus */
/* eslint-disable no-unused-vars */
import Vue from 'vue';
import { Storage } from 'aws-amplify';

const AWS = require('aws-sdk');

AWS.config.update({ region: 'us-east-1' });

Vue.use({
  install() {
    Vue.prototype.$cloudfrontUrl = 'https://d2xja4rap1t567.cloudfront.net/';

    Vue.prototype.$getKeyUrl = async (key) => {
      const picture = await Storage.get(key, {
        level: 'public',
        download: true,
      });

      const objUrl = URL.createObjectURL(picture.Body);
      return objUrl;
    };

    Vue.prototype.$getKeyUrlSync = (key) => {
      Storage.get(key, {
        level: 'public',
        download: true,
      }).then((picture) => URL.createObjectURL(picture.Body));
    };

    Vue.prototype.$getFormattedDate = () => {
      const m = new Date();
      const dateString = `${m.getUTCFullYear()}-${`0${m.getUTCMonth() + 1}`.slice(
        -2
      )}-${`0${m.getUTCDate()}`.slice(-2)} ${`0${m.getUTCHours()}`.slice(
        -2
      )}:${`0${m.getUTCMinutes()}`.slice(-2)}:${`0${m.getUTCSeconds()}`.slice(-2)}`;
      return dateString;
    };

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
          level: 'public',
        });
        return picture;
      } catch (err) {
        console.error(err);
      }
    };
  },
});
