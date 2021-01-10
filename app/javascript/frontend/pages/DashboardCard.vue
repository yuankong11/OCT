<template>
<v-card v-scroll.self="onScroll" :max-width="width" :max-height="height" class="overflow-y-auto">
  <component v-bind:is="component"></component>
</v-card>
</template>

<script>
import Resource from "./Resource.vue";

export default {
  components: {
    Resource
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
