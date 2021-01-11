<template>
<v-app style="background-color: inherit;">
  <v-main>
    <draggable :list="list1" class="list-group row" group="cards">
      <v-col v-for="element in list1" :key="element.id" class="list-group-item">
        <dashboard-card height="400" width="600" :component="element.component">
        </dashboard-card>
      </v-col>
    </draggable>
  </v-main>
</v-app>
</template>

<style>
body {
  margin: 0 !important;
  /* 去掉body的默认margin */
}
</style>

<script>
import DashboardCard from './DashboardCard.vue'
// import Resource from './Resource.vue'
// import CurrentLesson from '../components/LiveLesson/CurrentLesson'
// import Newwork from '../components/Homework/Newwork.vue'
// import Files from '../components/LessonResource/Files.vue'
import draggable from 'vuedraggable'
export default {
  name: "Dashboard",
  components: {
    DashboardCard,
    // Resource
    // CurrentLesson,
    // Newwork,
    // Files,
    draggable,
  },
  created() {},
  methods: {
    get_bodyHeight() { //动态获取浏览器高度
      const that = this
      window.onresize = () => {
        return (() => {
          window.fullHeight = document.documentElement.clientHeight
          that.fullHeight = window.fullHeight
        })()
      }
    },
    handleSelect(key, keyPath) {
      console.log(key, keyPath)
    },
    handleOpen(key, keyPath) {
      console.log(key, keyPath)
    },
    handleClose(key, keyPath) {
      console.log(key, keyPath)
    },
    handleRightSubMenu() {
      isRightSubMenuCollapse = !isRightSubMenuCollapse
    },
    toHomework(e) {
      this.$router.push({
        name: "Homework"
      })
    }
  },
  watch: {
    fullHeight(val) { //监控浏览器高度变化
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
  mounted() {
    this.get_bodyHeight()
  },
  data() {
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
      list1: [{
          id: 0,
          component: 'Files'
        },
        {
          id: 1,
          component: 'Timetable'
        },
        {
          id: 2,
          component: 'Allwork'
        },
        {
          id: 3,
          component: 'ScienceLecture'
        },
      ],
    }
  }
}
</script>
