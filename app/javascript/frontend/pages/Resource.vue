<template>
  <el-container id="Resource">
    <el-header class="resource-header">资源</el-header>
    <el-main>
      <el-row :gutter="20">
        <el-col :span="6">
          <el-card class="box-card">
            <div slot="header">
              <span>最新的资源</span>
            </div>
            <Favorites />
          </el-card>
        </el-col>
        <el-col :span="18">
          <el-card class="box-card"><Files /> </el-card>
        </el-col>
      </el-row>
    </el-main>
  </el-container>
</template>

<script>
import Favorites from '../components/LessonResource/Favorites'
import Files from '../components/LessonResource/Files.vue'

export default {
  name: 'Resource',
  components: {
    Files,
    Favorites
  }
}
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}

.resource-header {
  background-color: #e9eef3;
  color: #333;
  text-align: center;
  line-height: 60px;
}
</style>
