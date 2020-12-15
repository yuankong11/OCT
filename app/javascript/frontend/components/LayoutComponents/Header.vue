<template>
  <el-row class="row-bg" type="flex" justify="space-around" align="middle">
    <el-col :span="4"
      ><h1>
        <router-link
          :style="{ color: '#409eff', textDecoration: 'none' }"
          to="/app/dashboard"
          >OCT</router-link
        >
      </h1>
    </el-col>
    <el-col :span="8">
      <el-menu
        :data="menuData"
        :default-active="activeIndex"
        class="el-menu-demo"
        mode="horizontal"
        @select="handleSelect"
      >
        <el-menu-item index="1">我的课程</el-menu-item>
        <el-menu-item index="2">课后学习</el-menu-item>
        <!-- <el-submenu index="2">
                <template slot="title">课后学习</template>
                <el-menu-item index="2-1">选项1</el-menu-item>
                <el-menu-item index="2-2">选项2</el-menu-item>
                <el-menu-item index="2-3">选项3</el-menu-item>
                <el-submenu index="2-4">
                  <template slot="title">资讯</template>
                  <el-menu-item index="2-4-1">选项1</el-menu-item>
                  <el-menu-item index="2-4-2">选项2</el-menu-item>
                  <el-menu-item index="2-4-3">选项3</el-menu-item>
                </el-submenu>
              </el-submenu> -->
        <el-menu-item index="3">资讯</el-menu-item>
      </el-menu>
    </el-col>
    <el-col :span="12" class="right-menu">
      <!-- TODO: 点击弹出工具栏 -->
      <!-- <el-menu
              class="el-right-sub-menu"
              :data="rightSubMenuData"
              :collapse="isRightSubMenuCollapse"
            >
              <el-button class="right-menu-icons" type="text"
                ><i class="el-icon-menu"></i></el-button
              ><el-button class="right-menu-icons" type="text"
                ><i class="el-icon-menu"></i></el-button
              ><el-button class="right-menu-icons" type="text"
                ><i class="el-icon-menu"></i></el-button
              ><el-button class="right-menu-icons" type="text"
                ><i class="el-icon-menu"></i
              ></el-button>
            </el-menu> -->
      <el-button class="right-menu-icons right-tools" type="text"
        ><i class="el-icon-edit"></i></el-button
      ><el-button class="right-menu-icons right-tools" type="text"
        ><i class="el-icon-folder-opened"></i
      ></el-button>
      <el-button class="right-menu-icons right-tools" type="text"
        ><i class="el-icon-date"></i></el-button
      ><el-button class="right-menu-icons right-tools" type="text"
        ><i class="el-icon-finished"></i></el-button
      ><el-button class="right-menu-icons right-tools" type="text"
        ><i class="el-icon-data-analysis"></i></el-button
      ><el-button class="right-menu-icons right-tools" type="text"
        ><i class="el-icon-video-camera"></i
      ></el-button>
      <!-- <el-button
        class="right-menu-icons"
        type="text"
        @click="handleRightSubMenu"
        ><i class="el-icon-menu"></i
      ></el-button> -->

      <el-dropdown trigger="click">
        <el-button class="right-menu-icons el-dropdown-link" type="text">
          <i class="el-icon-menu" />
        </el-button>
        <el-dropdown-menu slot="dropdown">
          <el-dropdown-item>
            <span>Tools: </span>
          </el-dropdown-item>
          <draggable class="list-group" :list="list1" group="cards">
            <el-dropdown-item
              class="list-group-item"
              v-for="element in list1"
              :key="element.component"
            >
              <span>{{ element.component }}</span>
            </el-dropdown-item>
          </draggable>
        </el-dropdown-menu>
      </el-dropdown>

      <el-button class="right-menu-icons" type="text"
        ><i class="el-icon-refresh"></i
      ></el-button>
      <el-button class="right-menu-icons" type="text"
        ><i class="el-icon-bell"></i
      ></el-button>
      <el-button class="right-menu-icons" type="text"
        ><el-avatar :size="27" :src="circleUrl"></el-avatar
      ></el-button>
    </el-col>
  </el-row>
</template>

<style>
.right-menu-icons {
  font-size: 24px;
  padding: 10px;
}

.right-tools {
  visibility: hidden;
}
</style>


<script>
import draggable from 'vuedraggable'
export default {
  name: "Header",
  components: {
    draggable
  },
  // methods: {
  // get_bodyHeight () {//动态获取浏览器高度
  //   const that = this
  //   window.onresize = () => {
  //     return (() => {
  //       window.fullHeight = document.documentElement.clientHeight
  //       that.fullHeight = window.fullHeight
  //     })()
  //   }
  // },
  // handleSelect (key, keyPath) {
  //   console.log(key, keyPath)
  // },
  // handleOpen (key, keyPath) {
  //   console.log(key, keyPath)
  // },
  // handleClose (key, keyPath) {
  //   console.log(key, keyPath)
  // },
  // handleRightSubMenu () {
  //   isRightSubMenuCollapse = !isRightSubMenuCollapse
  // }
  // },
  // watch: {
  //   fullHeight (val) {//监控浏览器高度变化
  //     if (!this.timer) {
  //       this.fullHeight = val
  //       this.timer = true
  //       let that = this
  //       setTimeout(function () {
  //         that.timer = false
  //       }, 400)
  //     }
  //   }
  // },
  // mounted () {
  //   this.get_bodyHeight()
  // },
  data () {
    return {
      circleUrl: "https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png",
      fullHeight: document.documentElement.clientHeight,
      leftMenuData: [{
        isCollapse: true
      }],
      rightSubMenuData: [{
        isRightSubMenuCollapse: true
      }],
      menuData: [{
        activeIndex: '1',
        activeIndex2: '1'
      }],
      list1: [],
    }
  }
}
</script>
