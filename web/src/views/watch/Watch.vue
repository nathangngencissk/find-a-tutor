<template>
  <v-container>
    <v-row>
      <v-col xl="8" lg="8" cols="12">
        <v-row>
          <v-sheet width="100%" height="100%" elevation="1">
            <vue-plyr>
              <div class="plyr__video-embed">
                <iframe
                  src="https://www.youtube.com/embed/Ejkb_YpuHWs?amp;iv_load_policy=3&amp;modestbranding=1&amp;playsinline=1&amp;showinfo=0&amp;rel=0&amp;enablejsapi=1"
                  allowfullscreen
                  allowtransparency
                ></iframe>
              </div>
            </vue-plyr>
          </v-sheet>
        </v-row>
        <v-row>
          <v-tabs v-model="tab" color="primary" fixed-tabs :dark="$vuetify.theme.dark">
            <v-tab v-for="item in items" :key="item.name">
              {{ item.name }}
            </v-tab>
          </v-tabs>
          <v-tabs-items v-model="tab" id="tabs-items">
            <v-tab-item>
              <v-card color="basil" flat min-height="200px">
                <CourseNotes id="1" />
              </v-card>
            </v-tab-item>
            <v-tab-item>
              <v-card color="basil" flat min-height="200px">
                <CourseClasses id="1" />
              </v-card>
            </v-tab-item>
            <v-tab-item>
              <v-card color="basil" flat min-height="200px">
                <CourseReview id="1" />
              </v-card>
            </v-tab-item>
          </v-tabs-items>
        </v-row>
      </v-col>
      <v-col xl="4" lg="4" cols="12">
        <v-subheader>Aulas</v-subheader>
        <v-expansion-panels popout>
          <v-expansion-panel v-for="(item, i) in 11" :key="i">
            <v-expansion-panel-header> Aula {{ i }} </v-expansion-panel-header>
            <v-expansion-panel-content>
              <p>
                Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor
                incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud
                exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
              </p>
              <v-btn color="primary" depressed text>Assistir</v-btn>
            </v-expansion-panel-content>
          </v-expansion-panel>
        </v-expansion-panels>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import CourseNotes from '@/views/watch/components/CourseNotes.vue';
import CourseClasses from '@/views/watch/components/CourseClasses.vue';
import CourseReview from '@/views/watch/components/CourseReview.vue';

export default {
  name: 'Watch',
  title: 'Programação C# | Find a Tutor',
  props: ['courseId'],
  components: { CourseNotes, CourseClasses, CourseReview },
  data: () => ({
    tab: null,
    items: [
      {
        name: 'Anotações',
        body: '',
      },
      {
        name: 'Turmas',
        body: '',
      },
      {
        name: 'Avaliar',
        body: '',
      },
    ],
    text: `# h1 Heading 8-)
<h2> h2 Heading by HTML</h2>
## h2 Heading
### h3 Heading

## Horizontal Rules

___

---

***

## Typographic replacements

Enable typographer option to see result.

(c) (C) (r) (R) (tm) (TM) (p) (P) +-

test.. test... test..... test?..... test!....

!!!!!! ???? ,,  -- ---

"Smartypants, double quotes" and 'single quotes'


## Emphasis

**This is bold text**

__This is bold text__

*This is italic text*

_This is italic text_

~~Strikethrough~~


## Blockquotes


> Blockquotes can also be nested...
>> ...by using additional greater-than signs right next to each other...
> > > ...or with spaces between arrows.`,
  }),
  methods: {},
  computed: {
    compiledMarkdown() {
      return this.$marked(this.text, { sanitize: true });
    },
  },
};
</script>

<style lang="scss" scoped>
#tabs-items {
  width: 100%;
  margin-bottom: 16px;
}
</style>
