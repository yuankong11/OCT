<template>
  <el-tabs v-model="activeName" @tab-click="handleClick">
    <el-tab-pane label="今日任务" name="first">
      <el-input
        placeholder="回车添加待办事项"
        class="todoinput"
        @keyup.enter.native="add"
        v-model="newtodo.content"
      ></el-input>
      <p>
        进行中：{{ ingnum }} 已完成：{{ donenum
        }}<el-progress :percentage="50"></el-progress>
      </p>
      <el-row
        v-for="(item, index) in todolist"
        class="list-row"
        v-bind:key="item.id"
      >
        <el-col
          :xs="2"
          :sm="1"
          :md="1"
          :lg="1"
          :xl="1"
          class="check"
          :class="{
            red: !todolist[index].done,
            green: todolist[index].done,
          }"
        >
          <el-checkbox size="mini" v-model="item.done"></el-checkbox>
        </el-col>
        <el-col :xs="20" :sm="22" :md="22" :lg="22" :xl="22">
          <input
            type="text"
            v-model="item.content"
            class="ipcont"
            :class="{ done: todolist[index].done }"
          />
        </el-col>
        <el-col :xs="2" :sm="1" :md="1" :lg="1" :xl="1" class="close">
          <i class="el-icon-close" @click="del(index)"></i>
        </el-col>
      </el-row>
    </el-tab-pane>
    <el-tab-pane label="重要" name="second">重要</el-tab-pane>
    <el-tab-pane label="已规划日程" name="third">已规划日程</el-tab-pane>
    <el-tab-pane label="已完成" name="fourth">已完成</el-tab-pane>
  </el-tabs>
</template>
