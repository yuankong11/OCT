<template>
  <el-container>
    <el-header class="todo-header">Todo任务管理</el-header>
    <el-main>
      <el-row :gutter="30">
        <el-col :span="17">
          <el-card class="box-card-todo" padding="20px">
            <div slot="header">
              <span>Todo List</span>
            </div>
            <el-col :span="5">
              <Sidemenu />
            </el-col>
            <el-col :span="19">
              <Todolist />
            </el-col>
          </el-card>
        </el-col>

        <el-col :span="6">
          <el-card class="box-card">
            <Minicalendar /> </el-card
        ></el-col>

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
.todo-header {
  background-color: #e9eef3;
  color: #333;
  text-align: center;
  line-height: 60px;
}

.box-card {
  margin-bottom: 18px;
}
.box-card-todo {
  height: 760px;
}

.wh_container >>> .wh_content_all {
  background-color: #ffffff !important;
  border: 1px solid #dfe0e6;
  width: 600px;
  border-radius: 6px;
}
.wh_container {
  margin: 0px !important;
}

.wh_container >>> .wh_item_date {
  color: #211d48;
}
</style>

<script>
/* eslint-disable */
import Calendar from "vue-calendar-component"
import Minitodo from "../components/Todo/Minitodo"
import Sidemenu from "../components/Todo/Sidemenu"
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
    Calendar,
    Minitodo,
    Sidemenu,
    Todolist
  },
};
</script>
