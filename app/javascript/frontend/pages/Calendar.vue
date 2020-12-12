<template>
  <el-container>
    <el-header class="calendar-header">日程管理</el-header>
    <el-main>
      <el-row :gutter="20">
        <el-col :span="17">
          <el-card class="box-card-cal">
            <Timetable />
          </el-card>
        </el-col>
        <el-col :span="6">
          <el-card class="box-card">
            <Minicalendar />
          </el-card>
        </el-col>
        <el-col :span="6">
          <el-card class="box-card">
            <Minitodo />
          </el-card>
        </el-col>
      </el-row>
    </el-main>
  </el-container>
</template>

<style>
.box-card-cal {
  height: 820px;
}
.calendar-header {
  background-color: #e9eef3;
  color: #333;
  text-align: center;
  line-height: 60px;
}
</style>

<script>
/* eslint-disable */
import Minicalendar from '../components/Calendar/Minicalendar'
import Minitodo from "../components/Todo/Minitodo"
import Timetable from "../components/Calendar/Timetable"

export default {
  components: {
    Minitodo,
    Minicalendar,
    Timetable
  },
  data () {
    return {
    }
  },

};
</script>
