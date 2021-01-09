<template>
  <v-app>
    <v-container fluid>
      <v-row class="calendar-main">
        <v-card class="box-card-cal">
          <Timetable />
        </v-card>
        </v-col>
        <v-col>
          <v-card class="box-card">
            <Minicalendar />
          </v-card>
        </v-col>
        <v-col>
          <v-card class="box-card">
            <Minitodo />
          </v-card>
      </v-row>
    </v-container>
  </v-app>
</template>

<style>
  .calendar-main {
    height: 850px;
  }

  .box-card-cal {
    height: 850px;
  }

  .calendar-header {
    background-color: #e9eef3;
    color: #333;
    text-align: center;
    line-height: 60px;
  }

  .box-card {
    height: 425px;
  }

</style>

<script>
  /* eslint-disable */
  import Minicalendar from '../components/Calendar/Minicalendar'
  import Minitodo from "../components/Todo/Minitodo"
  import Timetable from "../components/Calendar/Timetable"

  export default {
    components: {
      Minitodo,
      Minicalendar,
      Timetable
    },
    data() {
      return {}
    },

  };

</script>
