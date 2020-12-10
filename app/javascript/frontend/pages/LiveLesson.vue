<template>
  <el-container>
    <el-header class="lecture-header">课程直播信息</el-header>
    <el-main>
      <el-row :gutter="20">
        <el-col :span="12">
          <el-card><CurrentLesson /></el-card>
        </el-col>
        <el-col :span="12">
          <el-card><CollecttedLesson /></el-card>
        </el-col>
      </el-row>
    </el-main>
  </el-container>
</template>

<style>
.lecture-header {
  background-color: #e9eef3;
  color: #333;
  text-align: center;
  line-height: 60px;
}
</style>

<script>
import CurrentLesson from '../components/LiveLesson/CurrentLesson'
import CollecttedLesson from '../components/LiveLesson/CollecttedLesson.vue'

export default {
  components: { CurrentLesson, CollecttedLesson },
}
</script>
