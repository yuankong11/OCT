<template>
  <el-container>
    <el-header style="text-align: center" class="lecture-info-header">
      <div>讲座信息</div>
    </el-header>
    <el-main>
      <el-row :gutter="20">
        <el-col :span="12">
          <el-card><HumanityLecture /></el-card>
        </el-col>
        <el-col :span="12">
          <el-card><ScienceLecture /></el-card>
        </el-col>
      </el-row>
    </el-main>
  </el-container>
</template>

<style>
.lecture-info-header {
  background-color: #e9eef3;
  color: #333;
  line-height: 60px;
}
</style>

<script>
import ScienceLecture from '../components/LectureInfo/ScienceLecture'
import HumanityLecture from '../components/LectureInfo/HumanityLecture.vue'

export default {
  components: { ScienceLecture, HumanityLecture },
}
</script>
