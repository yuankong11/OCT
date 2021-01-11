<template>
  <el-container>
    <el-header class="todo-header">Todo任务管理</el-header>
    <el-main>
      <el-row :gutter="20">
        <el-col :span="22">
          <el-col :span="18">
          <el-card class="box-card-todo">
            <div slot="header">
              <span>Todo List</span>
            </div>
              <Todolist />
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
.todo-header {
  background-color: #e9eef3;
  color: #333;
  text-align: center;
  line-height: 60px;
}

.box-card {
  height: 400px;
}
.box-card-todo {
  height: 810px;
}
</style>

<script>
/* eslint-disable */
import Minicalendar from '../components/Calendar/Minicalendar'
import Minitodo from "../components/Todo/Minitodo"
import Todolist from "../components/Todo/Todolist"
export default {
  methods: {

  },
  data () {
    return {
      dateValue: new Date(),
    }
  },
  components: {
    Minicalendar,
    Minitodo,
    Todolist
  },
};
</script>
