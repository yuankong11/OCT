<template>
  <b-navbar class="header d-print-none app-header">
    <b-nav>
      <!-- <b-nav-item>
        <b-navbar-brand href="#">OCT</b-navbar-brand>
      </b-nav-item> -->
      <b-nav-item class="d-none d-md-block">
        <router-link to="/app/dashboard">
          <span class="px-2">我的课程</span></router-link
        >
      </b-nav-item>
      <b-nav-item class="d-none d-md-block">
        <router-link to="/app/dashboard">
          <span class="px-2">课后学习</span></router-link
        >
      </b-nav-item>
    </b-nav>
    <a class="navbarBrand d-md-none">
      <i class="fa fa-circle text-danger" />
      &nbsp;
      OCT
      &nbsp;
      <i class="fa fa-circle text-primary" />
    </a>
    <b-nav class="ml-auto">
      <b-nav-item-dropdown class="toolsDropdown d-none d-md-block" no-caret right>
        <template slot="button-content">
          <i class="el-icon-menu" />
        </template>
        <draggable class="list-group" :list="list1" group="cards">
            <b-dropdown-item
              class="list-group-item"
              v-for="element in list1"
              :key="element.component"
            >
              <span>{{ element.component }}</span>
            </b-dropdown-item>
        </draggable>
      </b-nav-item-dropdown>
      <b-nav-item class="d-none d-md-block">
        <a href="#" class="px-2">
          <i class="el-icon-refresh" />
        </a>
      </b-nav-item>
      <b-nav-item-dropdown
        class="notificationsMenu d-none d-md-block mr-2"
        menu-class="notificationsWrapper py-0 animate__animated animate__animated-fast animate__fadeIn"
        right>
        <template slot="button-content">
          <span class="avatar rounded-circle thumb-sm float-left mr-2">
            <img class="rounded-circle" :src="avatarUrl" alt="..." />
          </span>
          <span class="small">202028015059032</span>
          <span class="ml-1 mr-3 circle bg-primary text-white fw-bold">13</span>
        </template>
        <Notifications />
      </b-nav-item-dropdown>
      <b-nav-item-dropdown class="settingsDropdown" no-caret right>
        <template slot="button-content">
          <i class="el-icon-s-tools" />
        </template>
        <b-dropdown-item><i class="la la-user" /> My Account</b-dropdown-item>
        <b-dropdown-divider />
        <b-dropdown-item-button @click="logout">
          <i class="la la-sign-out" /> Log Out
        </b-dropdown-item-button>
      </b-nav-item-dropdown>
    </b-nav>
  </b-navbar>
</template>

<script>
import draggable from 'vuedraggable'
import Notifications from '../Notifications/Notifications'

export default {
  name: 'Header',
  components: {
    draggable,
    Notifications
  },
  data() {
    return{
      avatarUrl: "https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png"
    }
  },
  methods: {
    logout() {
      // window.localStorage.setItem('authenticated', false);
      this.$router.push('/login');
    }
  }
};
</script>

<style src="./Header.scss" lang="scss"></style>
