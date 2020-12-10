<template>
  <el-container :style="'height:' + fullHeight + 'px;'">
    <Sidebar />
    <el-container class="content" :style="'height:' + fullHeight - 60 + 'px;'">
      <!-- header必须和container在一个文件里，否则会布局错误。 -->
      <el-header :height="'60'">
        <Header />
      </el-header>
      <BreadcrumbHistory />
      <transition name="router-animation">
        <router-view />
      </transition>
      <el-footer class="pageFooter">
        2020 &copy; OCT: A Better SEP - Made by Hongbin Zeng, Zhenyu Lei,
        Lianwei Yu, Huimin Ye.
      </el-footer>
    </el-container>
  </el-container>
</template>

<script>
// import { createNamespacedHelpers } from 'vuex'
// const { mapState, mapActions } = createNamespacedHelpers('layout')

import Sidebar from '../components/LayoutComponents/Sidebar'
import Header from '../components/LayoutComponents/Header'
import BreadcrumbHistory from '../components/LayoutComponents/BreadcrumbHistory'


export default {
  name: 'Layout',
  components: { Sidebar, Header, BreadcrumbHistory },
  // methods: {
  //   ...mapActions(['switchSidebar', 'handleSwipe', 'changeSidebarActive', 'toggleSidebar'],
  //   ),
  //   handleWindowResize () {
  //     const width = window.innerWidth

  //     if (width <= 768 && this.sidebarStatic) {
  //       this.toggleSidebar()
  //       this.changeSidebarActive(null)
  //     }
  //   },
  // },
  // computed: {
  //   ...mapState(["sidebarClose", "sidebarStatic"]),
  // },
  // created () {
  //   const staticSidebar = JSON.parse(localStorage.getItem('sidebarStatic'))

  //   if (staticSidebar) {
  //     this.$store.state.layout.sidebarStatic = true
  //   } else if (!this.sidebarClose) {
  //     setTimeout(() => {
  //       this.switchSidebar(true)
  //       this.changeSidebarActive(null)
  //     }, 2500)
  //   }

  //   this.handleWindowResize()
  //   window.addEventListener('resize', this.handleWindowResize)
  // },
  // beforeDestroy () {
  //   window.removeEventListener('resize', this.handleWindowResize)
  // }
};
</script>

<style>
.el-header {
  text-align: center;
  padding: 0px;
  min-width: 900px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.12), 0 0 6px rgba(0, 0, 0, 0.04);
}
</style>
