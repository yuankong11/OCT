<!-- 周视图 -->
<template>
  <div>
    <div slot="header">
      <span>日程周视图</span>
    </div>
    <v-calendar
      ref="calendar"
      v-model="value"
      :weekdays="weekday"
      :type="type"
      :events="events"
      :event-overlap-mode="mode"
      :event-overlap-threshold="30"
      :event-color="getEventColor"
      @change="getEvents"
    ></v-calendar>
    <!--<el-calendar v-model="value"> </el-calendar> -->
  </div>
</template>

<script>

export default {
  components: {
  },
  data () {
    return {
      value: new Date()
    }
  },
};
</script>
