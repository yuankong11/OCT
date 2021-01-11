<template>
<v-card class="overflow-y-auto" v-scroll.self="onScroll" :max-width="width" :max-height="height">
  <component v-bind:is="component"></component>
</v-card>
</template>

<script>
import Timetable from '../components/Calendar/Timetable.vue';
import Allwork from '../components/Homework/Allwork.vue';
//import ScienceLecture from '../components/LectureInfo/ScienceLecture.vue';
import Files from '../components/LessonResource/Files.vue';
import Homework from './Homework.vue';
import LectureInfo from './LectureInfo.vue';
import Resource from "./Resource.vue";

export default {
  components: {
    Resource,
    Timetable,
    LectureInfo,
    Homework,
    Allwork,
    //ScienceLecture,
    Files
  },
  data() {
    return {

    }
  },
  props: [
    'height',
    'width',
    'component'
  ],
  methods: {
    onScroll() {

    }
  }
}
</script>
