<template>
<el-container id="Homework">
  <el-header class="homework-header">资源</el-header>
  <el-main>
    <files />
  </el-main>
</el-container>
</template>

<script>
import Files from '../components/LessonResource/Files.vue'
export default {
  components: {
    Files
  },
  data() {
    return {}
  }
}
</script>
