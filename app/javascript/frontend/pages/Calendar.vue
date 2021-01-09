<template>
  <el-container>
    <el-header class="calendar-header">日程管理</el-header>
    <el-main>
      <el-row :gutter="20">
        <el-col :span="22">
        <el-col :span="18">
          <el-card class="box-card-cal">
            <div slot="header">
              <span>日程表</span>
            </div>
            <Timetable />
          </el-card>
        </el-col>
        <el-col :span="6">
          <el-card class="box-card" :body-style="{ padding: '0px' }">
          <Minicalendar />
          </el-card>
        </el-col>
        <el-col :span="6">
          <el-card class="box-card" :body-style="{ padding: '0px' }">
            <Minitodo />
          </el-card>
        </el-col>
        </el-col>
      </el-row>
    </el-main>
  </el-container>
</template>

<style>
  .box-card-cal {
    height: 810px;
  }

  .calendar-header {
    background-color: #e9eef3;
    color: #333;
    text-align: center;
    line-height: 60px;
  }

  .box-card {
    height: 400px;
  }
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 0px;
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
    data() {
      return {}
    },

  };

</script>
