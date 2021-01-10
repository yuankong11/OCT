<!-- 周视图 -->
<template>
  <v-app :class="card">
    <v-sheet height="64">
      <v-toolbar flat>
        <v-btn outlined class="mr-4" color="grey darken-2" @click="setToday">
          Today
        </v-btn>
        <v-btn fab text small color="grey darken-2" @click="prev">
          <v-icon small>
            mdi-chevron-left
          </v-icon>
        </v-btn>
        <v-btn fab text small color="grey darken-2" @click="next">
          <v-icon small>
            mdi-chevron-right
          </v-icon>
        </v-btn>
        <v-toolbar-title v-if="$refs.calendar">
          {{ $refs.calendar.title }}
        </v-toolbar-title>
        <v-spacer></v-spacer>
        <v-menu bottom right>
          <template v-slot:activator="{ on, attrs }">
            <v-btn outlined color="grey darken-2" v-bind="attrs" v-on="on">
              <span>{{ typeToLabel[type] }}</span>
              <v-icon right>
                mdi-menu-down
              </v-icon>
            </v-btn>
          </template>
          <v-list>
            <v-list-item @click="type = 'day'">
              <v-list-item-title>Day</v-list-item-title>
            </v-list-item>
            <v-list-item @click="type = 'week'">
              <v-list-item-title>Week</v-list-item-title>
            </v-list-item>
            <v-list-item @click="type = 'month'">
              <v-list-item-title>Month</v-list-item-title>
            </v-list-item>
            <v-list-item @click="type = '4day'">
              <v-list-item-title>4 days</v-list-item-title>
            </v-list-item>
          </v-list>
        </v-menu>
      </v-toolbar>
    </v-sheet>
    <v-sheet height="600">
      <v-calendar ref="calendar" v-model="focus" color="primary" :events="events" :event-color="getEventColor"
        :type="type" @click:event="showEvent" @click:more="viewDay" @click:date="viewDay" @change="getEvents">
        <div v-if="type!='month'"></div>
        <template v-slot:day-body="{ date, week }">
          <div class="v-current-time" :class="{ first: date === week[0].date }" :style="{ top: nowY }"></div>
        </template>
        </div>
      </v-calendar>
      <v-menu v-model="selectedOpen" :close-on-content-click="false" :activator="selectedElement" offset-x>
        <v-card color="grey lighten-4" min-width="350px" flat>
          <v-toolbar :color="selectedEvent.color" dark>
            <v-btn icon>
              <v-icon>mdi-pencil</v-icon>
            </v-btn>
            <v-toolbar-title v-html="selectedEvent.name"></v-toolbar-title>
            <v-spacer></v-spacer>
            <v-btn icon>
              <v-icon>mdi-heart</v-icon>
            </v-btn>
            <v-btn icon>
              <v-icon>mdi-dots-vertical</v-icon>
            </v-btn>
          </v-toolbar>
          <v-card-text>
            <!--<span v-html="selectedEvent.details"></span>-->
            <v-simple-table>
              <template v-slot:default>
                <thead>
                  <tr>
                    <th class="text-left">
                      日程属性
                    </th>
                    <th class="text-right">
                      具体信息
                    </th>
                  </tr>
                </thead>
                <tbody>
                  <tr>
                    <td>课程/日程名</td>
                    <td>{{ selectedEvent.name }}</td>
                  </tr>
                  <tr>
                    <td>地点</td>
                    <td>{{ selectedEvent.location }}</td>
                  </tr>
                  <tr>
                    <td>开始时间</td>
                    <td>{{ selectedEvent.start }}</td>
                  </tr>
                  <tr>
                    <td>结束时间</td>
                    <td>{{ selectedEvent.end }}</td>
                  </tr>
                </tbody>
              </template>
            </v-simple-table>

          </v-card-text>
          <v-card-actions>
            <v-btn text color="secondary" @click="selectedOpen = false">
              Cancel
            </v-btn>
          </v-card-actions>
        </v-card>
      </v-menu>
    </v-sheet>
    <!--<el-calendar v-model="value"> </el-calendar> -->
  </v-app>
</template>


<style lang="scss">
  .card {
    margin-top: 0px;
  }

  .v-current-time {
    height: 2px;
    background-color: #ea4335;
    position: absolute;
    left: -1px;
    right: 0;
    pointer-events: none;

    &.first::before {
      content: '';
      position: absolute;
      background-color: #ea4335;
      width: 12px;
      height: 12px;
      border-radius: 50%;
      margin-top: -5px;
      margin-left: -6.5px;
    }
  }

</style>
<script>
  export default {
    data: () => ({
      focus: '',
      type: 'week',
      typeToLabel: {
        month: 'Month',
        week: 'Week',
        day: 'Day',
        '4day': '4 Days',
      },
      value: '',
      ready: false,
      selectedEvent: {},
      selectedElement: null,
      selectedOpen: false,
      events: [],
      timetable: [],
      colors: ['blue', 'indigo', 'deep-purple', 'cyan', 'green', 'orange', 'grey darken-1'],
      names: ['Meeting', 'Holiday', 'PTO', 'Travel', 'Event', 'Birthday', 'Conference', 'Party'],
    }),
    computed: {
      cal() {
        return this.ready ? this.$refs.calendar : null
      },
      nowY() {
        return this.cal ? this.cal.timeToY(this.cal.times.now) + 'px' : '-10px'
      },
    },
    mounted() {
      this.getEvents(null, null)
      this.ready = true
      this.scrollToTime()
      this.updateTime()
    },
    methods: {
      getCurrentTime() {
        return this.cal ? this.cal.times.now.hour * 60 + this.cal.times.now.minute : 0
      },
      scrollToTime() {
        const time = this.getCurrentTime()
        const first = Math.max(0, time - (time % 30) - 30)

        this.cal.scrollToTime(first)
      },
      updateTime() {
        setInterval(() => this.cal.updateTimes(), 60 * 1000)
      },
      viewDay({
        date
      }) {
        this.focus = date
        this.type = 'day'
      },
      getEventColor(event) {
        return event.color
      },
      setToday() {
        this.focus = ''
      },
      prev() {
        this.$refs.calendar.prev()
      },
      next() {
        this.$refs.calendar.next()
      },
      showEvent({
        nativeEvent,
        event
      }) {
        const open = () => {
          this.selectedEvent = event
          this.selectedElement = nativeEvent.target
          setTimeout(() => {
            this.selectedOpen = true
          }, 10)
        }

        if (this.selectedOpen) {
          this.selectedOpen = false
          setTimeout(open, 10)
        } else {
          open()
        }

        nativeEvent.stopPropagation()
      },
      getEvents({
        start,
        end
      }) {
        const events = []

        this.$http.get("/api/timetable").then(
          (res) => {
            this.timetable = res.data; //正常
            //console.log(this.timetable)
            for (let i = 0; i < this.timetable.length; i++) {
              let tem_event = {
                name: this.timetable[i].name,
                start: new Date(this.timetable[i].start),
                end: new Date(this.timetable[i].end),
                location: this.timetable[i].location,
                color: this.colors[this.rnd(0, this.colors.length - 1)],
                timed: true,
                uid: this.timetable[i].uid,
              }
              //console.log(tem_event)
              events.push(tem_event)
              tem_event = {}
            }
            this.events = events
          },
          (res) => {
            this.$notify.error({
              title: "错误",
              message: "获取课程表失败",
            });
          }
        );
        // const min = new Date(`${start.date}T00:00:00`)
        // const max = new Date(`${end.date}T23:59:59`)
        // const days = (max.getTime() - min.getTime()) / 86400000
        // const eventCount = this.rnd(days, days + 20)

        // for (let i = 0; i < eventCount; i++) {
        //   const allDay = this.rnd(0, 3) === 0
        //   const firstTimestamp = this.rnd(min.getTime(), max.getTime())
        //   const first = new Date(firstTimestamp - (firstTimestamp % 900000))
        //   const secondTimestamp = this.rnd(2, allDay ? 288 : 8) * 900000
        //   const second = new Date(first.getTime() + secondTimestamp)
        //   let tmp = {
        //     name: this.names[this.rnd(0, this.names.length - 1)],
        //     start: first,
        //     end: second,
        //     location: "somewhere",
        //     color: this.colors[this.rnd(0, this.colors.length - 1)],
        //     timed: !allDay,
        //   }
        //   events.push(tmp)
        // }
      },
      rnd(a, b) {
        return Math.floor((b - a + 1) * Math.random()) + a
      },
    },
  }

</script>
