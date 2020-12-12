<template>
  <el-menu
    default-active="1-4-1"
    class="el-menu-vertical-demo"
    @open="handleOpen"
    @close="handleClose"
    :collapse="isCollapse"
  >
    <el-menu-item index="0">今日任务</el-menu-item>
    <el-submenu index="1">
      <template slot="title">
        <i class="el-icon-location"></i>
        <span slot="title">学习任务</span>
      </template>

      <el-menu-item index="1-1">学科作业</el-menu-item>
      <el-menu-item index="1-2">文献阅读</el-menu-item>
      <el-menu-item index="1-2">自我扩充</el-menu-item>
    </el-submenu>

    <el-submenu index="2">
      <template slot="title">
        <i class="el-icon-s-home"></i>
        <span slot="title">日常生活</span>
      </template>

      <el-menu-item index="2-1">行程任务</el-menu-item>
      <el-menu-item index="2-2">购物清单</el-menu-item>
      <el-menu-item index="2-3">灵光一闪</el-menu-item>
    </el-submenu>

    <el-menu-item index="3">
      <i class="el-icon-document"></i>
      <span slot="title">工作安排</span>
    </el-menu-item>
    <el-menu-item index="4" disabled>
      <i class="el-icon-setting"></i>
      <span slot="title">待添加</span>
    </el-menu-item>
  </el-menu>
</template>
<style>
.el-aside {
  color: #333;
}
</style>
