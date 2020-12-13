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
          ><span class="primary-word">OCT</span> App</router-link
        >
      </header>
      <ul class="nav">
        <!-- <el-menu
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
        </el-menu> -->
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
          link="/app/leture-info"
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
      <h5 class="navTitle">--------------------</h5>
      <div class="sidebarAdd">
        <el-button type="primary" icon="el-icon-circle-plus" circle></el-button>
      </div>
    </nav>
  </div>
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
