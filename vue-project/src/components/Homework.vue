<template>
  <div id="Homework">
    <el-row :gutter="20">
      <el-col :span="12">
        <el-row>
          <Newwork />
        </el-row>
        <el-row>
          <Sorted :handleEdit="handleEdit" />
        </el-row>
      </el-col>
      <el-col :span="12">
        <Allwork :handleEdit="handleEdit" />
      </el-col>
    </el-row>

    <Workpad />
  </div>
</template>

<script>
import Newwork from "./Newwork.vue"
import Sorted from "./Sorted.vue"
import Workpad from "./Workpad.vue"
import Allwork from "./Allwork"

export default {
  name: "Homework",
  components: {
    Newwork,
    Sorted,
    Workpad,
    Allwork
  },
  methods: {
    handleEdit () {
      this.$children[1].dialogTableVisible = true
    }
  },
};
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
