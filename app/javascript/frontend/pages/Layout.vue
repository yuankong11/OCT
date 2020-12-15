<template>
  <!-- <el-container :style="'height:' + fullHeight + 'px;'"> -->
  <div :class="[{ root: true, sidebarClose, sidebarStatic }]">
    <Sidebar />
    <!-- <el-container class="content" :style="'height:' + fullHeight - 60 + 'px;'"> -->
    <el-container class="wrap">
      <!-- header必须和container在一个文件里，否则会布局错误。 -->
      <el-header class="layout-header" :height="'60'">
        <Header />
      </el-header>
      <el-main class="content">
        <BreadcrumbHistory />
        <transition name="router-animation">
          <router-view />
        </transition>
      </el-main>
      <el-footer class="contentFooter">
        2020 &copy; OCT: A Better SEP - Made by Hongbin Zeng, Lianwei Yu, Huimin
        Ye, Zhengyu Lei.
      </el-footer>
    </el-container>
  </div>
</template>

<script>
import { createNamespacedHelpers } from 'vuex'
const { mapState, mapActions } = createNamespacedHelpers('layout')

import Sidebar from '../components/LayoutComponents/Sidebar/Sidebar'
import Header from '../components/LayoutComponents/Header'
import BreadcrumbHistory from '../components/LayoutComponents/BreadcrumbHistory'


export default {
  name: 'Layout',
  components: { Sidebar, Header, BreadcrumbHistory },
  methods: {
    ...mapActions(['switchSidebar', 'handleSwipe', 'changeSidebarActive', 'toggleSidebar'],
    ),
    handleWindowResize () {
      const width = window.innerWidth

      if (width <= 768 && this.sidebarStatic) {
        this.toggleSidebar()
        this.changeSidebarActive(null)
      }
    },
  },
  computed: {
    ...mapState(["sidebarClose", "sidebarStatic"]),
  },
  created () {
    const staticSidebar = JSON.parse(localStorage.getItem('sidebarStatic'))

    if (staticSidebar) {
      this.$store.state.layout.sidebarStatic = true
    } else if (!this.sidebarClose) {
      setTimeout(() => {
        this.switchSidebar(true)
        this.changeSidebarActive(null)
      }, 2500)
    }

    this.handleWindowResize()
    window.addEventListener('resize', this.handleWindowResize)
  },
  beforeDestroy () {
    window.removeEventListener('resize', this.handleWindowResize)
  }
};
</script>

<style src="../styles/Layout.scss" lang="scss" />
