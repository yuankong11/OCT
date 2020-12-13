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

export default new Router({
  mode: "history",
  routes: [
    {
      path: '/app',
      name: 'Layout',
      component: Layout,
      children: [
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
          path: 'live_lesson',
          name: 'LiveLesson',
          component: LiveLesson
        },
        {
          path: 'lecture_info',
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
