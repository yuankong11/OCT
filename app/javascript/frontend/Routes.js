import Vue from 'vue'
import Router from 'vue-router'

import Login from './pages/Login'
import ErrorPage from './pages/Error'
import Layout from './pages/Layout'
import Dashboard from './pages/Dashboard'
import Homework from './pages/Homework'
import Resource from './pages/Resource'
import LiveLesson from './pages/LiveLesson'
import LectureInfo from './pages/LectureInfo'
import Calendar from './pages/Calendar'
import Todo from './pages/Todo'
import Datatest from './pages/Datatest'
import AnotherCalendar from './pages/AnotherCalendar'

Vue.use(Router)

// 解决NavigationDuplicated: Avoided redundant navigation to current location错误
const originalPush = Router.prototype.push
Router.prototype.push = function push (location) {
  return originalPush.call(this, location).catch(err => err)
}

export default new Router({
  mode: "history",
  routes: [
    {
      path: '/login',
      name: 'Login',
      component: Login,
    },
    {
      path: '/error',
      name: 'Error',
      component: ErrorPage,
    },
    {
      path: '/app',
      name: 'Layout',
      component: Layout,
      children: [
        {
          path: 'dashboard',
          name: 'Dashboard',
          component: Dashboard,
        },
        {
          path: 'homework',
          name: 'Homework',
          component: Homework
        },
        {
          path: 'resource',
          name: 'Resource',
          component: Resource
        },
        {
          path: 'live-lesson',
          name: 'LiveLesson',
          component: LiveLesson
        },
        {
          path: 'lecture-info',
          name: 'LectureInfo',
          component: LectureInfo
        },
        {
          path: 'calendar',
          name: 'Calendar',
          component: Calendar
        },
        {
          path: 'todo',
          name: 'Todo',
          component: Todo
        },
        {
          path: 'datatest',
          name: 'Datatest',
          component: Datatest,
        },
        {
          path: 'anotherCalendar',
          name: 'AnotherCalendar',
          component: AnotherCalendar,
        },
      ],
    },
    {
      // 会匹配所有路径
      path: '*',
      component: ErrorPage
    }
  ]
})
