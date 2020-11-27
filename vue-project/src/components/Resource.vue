<template>
  <div id="Resource">
    <el-container>
      <el-aside width="240">
        <el-container>
          <el-header>New？？？</el-header>
          <el-main
            >收藏夹？？？
            <Favorites />
          </el-main>
        </el-container>
      </el-aside>
      <el-main>
        <files />
      </el-main>
    </el-container>
  </div>
</template>

<script>
import Favorites from './Favorites.vue'
import Files from './Files.vue'

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
</style>
