<template>
  <el-container :style="'height:' + fullHeight + 'px;'">
    <el-header>
      <Dashboard-header />
    </el-header>
    <el-container :style="'height:' + fullHeight - 60 + 'px;'">
      <Dashboard-aside />
      <el-main> <Live-lesson /></el-main>
    </el-container>
  </el-container>
</template>



<style>
* {
  margin: 0 !important; /* 去掉body的默认margin */
}
</style>

<script>
import DashboardHeader from './share/DashboardHeader.vue'
import DashboardAside from './share/DashboardAside.vue'
import LiveLesson from './LiveLesson.vue'

export default {
  name: "Dashboard",
  components: {
    DashboardHeader,
    DashboardAside,
    LiveLesson
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
    handleRightSubMenu () {
      isRightSubMenuCollapse = !isRightSubMenuCollapse
    },
    toHomework (e) {
      this.$router.push({ name: "Homework" })
    }
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
      }]
    }
  }
}
</script>
