<template>
  <el-aside width="200px" style="overflow: hidden">
    <el-menu
      :data="leftMenuData"
      class="el-menu-vertical-demo"
      @open="handleOpen"
      @close="handleClose"
      :collapse="isCollapse"
    >
      <el-menu-item index="1" @click="toHomework">
        <i class="el-icon-edit"></i>
        <span slot="title">作业</span>
      </el-menu-item>
      <!-- <el-submenu index="1">
            <template slot="title">
              <i class="el-icon-edit"></i>
              <span slot="title">作业</span>
            </template>
            <el-menu-item-group>
              <span slot="title">分组一</span>
              <el-menu-item index="1-1">选项1</el-menu-item>
              <el-menu-item index="1-2">选项2</el-menu-item>
            </el-menu-item-group>
            <el-menu-item-group title="分组2">
              <el-menu-item index="1-3">选项3</el-menu-item>
            </el-menu-item-group>
          </el-submenu> -->
      <el-menu-item index="2" @click="toResource">
        <i class="el-icon-folder-opened"></i>
        <span slot="title">资源</span>
      </el-menu-item>
      <el-menu-item index="3" @click="toCalendar">
        <i class="el-icon-date"></i>
        <span slot="title">日程</span>
      </el-menu-item>
      <el-menu-item index="4" @click="toTodo">
        <i class="el-icon-finished"></i>
        <span slot="title">事项</span>
      </el-menu-item>
      <el-menu-item index="5" @click="toLectureInfo">
        <i class="el-icon-data-analysis"></i>
        <span slot="title">讲座</span>
      </el-menu-item>
      <el-menu-item index="6" @click="toLiveLesson">
        <i class="el-icon-video-camera"></i>
        <span slot="title">直播</span>
      </el-menu-item>
      <el-menu-item index="7" @click="toDatatest">
        <i class="el-icon-video-camera"></i>
        <span slot="title">数据测试</span>
      </el-menu-item>
      <el-menu-item index="8" @click="toAnotherCalendar">
        <i class="el-icon-date"></i>
        <span slot="title">另一个日程</span>
      </el-menu-item>
    </el-menu>
  </el-aside>
</template>


<style>
.el-aside {
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.12), 0 0 6px rgba(0, 0, 0, 0.04);
}
.el-menu-vertical-demo:not(.el-menu--collapse) {
  width: 200px;
  min-height: 400px;
}
</style>


<script>
import LiveLesson from '../../pages/LiveLesson.vue'
import LectureInfo from '../../pages/LectureInfo.vue'
import Homework from '../../pages/Homework.vue'
import Resource from '../../pages/Resource.vue'
import Calendar from '../../pages/Calendar.vue'
import Todo from '../../pages/Todo.vue'
import Datatest from '../../pages/Datatest.vue'
import AnotherCalendar from '../../pages/AnotherCalendar'
export default {
  name: "Sidebar",
  components: {
    Homework,
    Resource,
    LiveLesson,
    LectureInfo,
    Calendar,
    Todo,
    Datatest,
    AnotherCalendar,
  },
  methods: {
    get_bodyHeight () {//动态获取浏览器高度
      const that = this
      window.onresize = () => {
        return (() => {
          window.fullHeight = document.documentElement.clientHeight
          that.fullHeight = window.fullHeight
        })()
      }
    },
    handleSelect (key, keyPath) {
      console.log(key, keyPath)
    },
    handleOpen (key, keyPath) {
      console.log(key, keyPath)
    },
    handleClose (key, keyPath) {
      console.log(key, keyPath)
    },
    toHomework (e) {
      this.$router.push({ name: "Homework" })
    },
    toResource (e) {
      this.$router.push({ name: "Resource" })
    },
    toLiveLesson (e) {
      this.$router.push({ name: "LiveLesson" })
    },
    toLectureInfo (e) {
      this.$router.push({ name: "LectureInfo" })
    },
    toCalendar (e) {
      this.$router.push({ name: "Calendar" })
    },
    toTodo (e) {
      this.$router.push({ name: "Todo" })
    },
    toDatatest (e) {
      this.$router.push({ name: "Datatest" })

    },
    toAnotherCalendar (e) {
      this.$router.push({ name: "AnotherCalendar" })
    },
  },
  watch: {
    fullHeight (val) {//监控浏览器高度变化
      if (!this.timer) {
        this.fullHeight = val
        this.timer = true
        let that = this
        setTimeout(function () {
          that.timer = false
        }, 400)
      }
    }
  },
  mounted () {
    this.get_bodyHeight()
  },
  data () {
    return {
      fullHeight: document.documentElement.clientHeight,
      leftMenuData: [{
        isCollapse: true
      }]
    }
  }
}
</script>
