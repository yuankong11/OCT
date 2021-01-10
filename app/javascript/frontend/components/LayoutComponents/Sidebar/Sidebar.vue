<template>
  <div class="sidebar-wrapper">
    <nav
      :class="{ sidebar: true, sidebarStatic, sidebarOpened }"
      @mouseenter="sidebarMouseEnter"
      @mouseleave="sidebarMouseLeave"
    >
      <header class="logo">
        <router-link
          :style="{ color: '#409eff', textDecoration: 'none' }"
          to="/app/dashboard"
          ><span class="primary-word">OCT</span>&nbsp;&nbsp;App</router-link
        >
      </header>
      <ul class="nav">
        <NavLink
          :activeItem="activeItem"
          header="作业"
          link="/app/homework"
          iconName="el-icon-edit"
          index="homework"
          isHeader
        />
        <NavLink
          :activeItem="activeItem"
          header="资源"
          link="/app/resource"
          iconName="el-icon-folder-opened"
          index="resource"
          isHeader
        />
        <NavLink
          :activeItem="activeItem"
          header="日程"
          link="/app/calendar"
          iconName="el-icon-date"
          index="calendar"
          isHeader
        />
        <NavLink
          :activeItem="activeItem"
          header="事项"
          link="/app/todo"
          iconName="el-icon-finished"
          index="todo"
          isHeader
        />
        <NavLink
          :activeItem="activeItem"
          header="讲座"
          link="/app/lecture-info"
          iconName="el-icon-data-analysis"
          index="leture-info"
          isHeader
        />
        <NavLink
          :activeItem="activeItem"
          header="直播"
          link="/app/live-lesson"
          iconName="el-icon-video-camera"
          index="live-lesson"
          isHeader
        />
      </ul>
      <h5 class="navTitle">
        我的收藏
        <a class="actionLink">
          <i class="la la-plus float-right" />
        </a>
      </h5>
      <ul class="sidebarLabels">
        <li>
          <a href="#">
            <i class="fa fa-circle text-danger mr-2" />
            <span class="labelName">My Recent</span>
          </a>
        </li>
        <li>
          <a href="#">
            <i class="fa fa-circle text-primary mr-2" />
            <span class="labelName">Starred</span>
          </a>
        </li>
        <li>
          <a href="#">
            <i class="fa fa-circle mr-2" />
            <span class="labelName">Background</span>
          </a>
        </li>
      </ul>
      <h5 class="navTitle"></h5>
      <div class="sidebarAdd">
        <el-button type="primary" icon="el-icon-circle-plus" circle></el-button>
      </div>
    </nav>
  </div>
</template>


<script>
import { mapState, mapActions } from 'vuex'
import isScreen from '../../../helpers/screenHelper'
import NavLink from './NavLink/NavLink'

export default {
  name: "Sidebar",
  components: {
    NavLink
  },
  methods: {
    ...mapActions('layout', ['changeSidebarActive', 'switchSidebar']),
    setActiveByRoute () {
      const paths = this.$route.fullPath.split('/')
      paths.pop()
      this.changeSidebarActive(paths.join('/'))
    },
    sidebarMouseEnter () {
      if (!this.sidebarStatic && (isScreen('lg') || isScreen('xl'))) {
        this.switchSidebar(false)
        this.setActiveByRoute()
      }
    },
    sidebarMouseLeave () {
      if (!this.sidebarStatic && (isScreen('lg') || isScreen('xl'))) {
        this.switchSidebar(true)
        this.changeSidebarActive(null)
      }
    },
  },
  created () {
    this.setActiveByRoute()
  },
  computed: {
    ...mapState('layout', {
      sidebarStatic: state => state.sidebarStatic,
      sidebarOpened: state => !state.sidebarClose,
      activeItem: state => state.sidebarActiveElement,
    }),
  }
}
</script>

<style src="./Sidebar.scss" lang="scss" scoped/>
