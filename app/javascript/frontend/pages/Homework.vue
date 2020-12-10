<template>
  <el-container id="Homework">
    <el-header class="homework-header">作业</el-header>
    <el-main>
      <Workpad ref="workpad"/>
      <el-row :gutter="20">
        <el-col :span="12">
          <el-card class="box-card">
            <div slot="header">
              <span>新的作业</span>
            </div>
            <Newwork />
          </el-card>
        </el-col>
        <el-col :span="12">
          <el-card class="box-card" style="margin-bottom: 18px">
            <div slot="header">
              <span>未完成的作业</span>
            </div>
            <Sorted :handleEdit="handleEdit" />
          </el-card>
        </el-col>
        <el-col :span="24">
          <el-card class="box-card">
            <div slot="header">
              <span>所有作业</span>
            </div>
            <Allwork :handleEdit="handleEdit" />
          </el-card>
        </el-col>
      </el-row>
    </el-main>
  </el-container>
</template>

<script>
import Newwork from "../components/Homework/Newwork"
import Sorted from "../components/Homework/Sorted"
import Workpad from "../components/Homework/Workpad"
import Allwork from "../components/Homework/Allwork"

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
      // console.log(this)
      this.$refs.workpad.dialogTableVisible = true
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
.homework-header {
  background-color: #e9eef3;
  color: #333;
  line-height: 60px;
  text-align: center;
}
</style>
