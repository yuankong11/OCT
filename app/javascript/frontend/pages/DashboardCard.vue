<template>
<v-card class="overflow-y-auto" v-scroll.self="onScroll" :max-width="width" :max-height="height">
  <component v-bind:is="component"></component>
</v-card>
</template>

<script>
import Timetable from '../components/Calendar/Timetable.vue';
import Homework from './Homework.vue';
import LectureInfo from './LectureInfo.vue';
import Resource from "./Resource.vue";

export default {
  components: {
    Resource,
    Timetable,
    LectureInfo,
    Homework
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
