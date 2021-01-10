<template>
<v-card class="overflow-y-auto" v-scroll.self="onScroll" :max-width="width" :max-height="height">
  <component v-bind:is="component"></component>
</v-card>
</template>

<script>
import Timetable from '../components/Calendar/Timetable.vue';
import Resource from "./Resource.vue";

export default {
  components: {
    Resource,
    Timetable
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
