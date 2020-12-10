import Vue from 'vue'
import Router from 'vue-router'
import Dashboard from '../components/Dashboard'
import Homework from '../components/Homework'
import Resource from '../components/Resource'
import LiveLesson from '../components/LiveLesson/LiveLesson.vue'
import LectureInfo from '../components/LectureInfo/LectureInfo.vue'
import Calendar from '../components/Calendar'
import Todo from '../components/Todo'

Vue.use(Router)

export default new Router({
  mode: "history",
  routes: [
    {
      path: '/frontend/dashboard',
      name: 'Dashboard',
      component: Dashboard
    },
    {
      path: '/frontend/homework',
      name: 'Homework',
      component: Homework
    },
    {
      path: '/frontend/resource',
      name: 'Resource',
      component: Resource
    },
    {
      path: '/frontend/live_lesson',
      name: 'LiveLesson',
      component: LiveLesson
    },
    {
      path: '/frontend/lecture_info',
      name: 'LectureInfo',
      component: LectureInfo
    },
    {
      path: '/frontend/calendar',
      name: 'Calendar',
      component: Calendar
    },
    {
      path: '/frontend/todo',
      name: 'Todo',
      component: Todo
    }
  ]
})
