<template>
  <v-app>
      <v-row justify="center" :span="1">
        <v-col>
          <v-date-picker
            elevation="3"
            v-model="date2"
            :event-color="(date) => (date[9] % 2 ? 'red' : 'yellow')"
            :events="functionEvents"
          ></v-date-picker>
        </v-col>
      </v-row>
  </v-app>
</template>

<style>
</style>

<script>
export default {
  data: () => ({
    date2: new Date().toISOString().substr(0, 10),
  }),

  mounted () {
  },

  methods: {
    functionEvents (date) {
      const [, , day] = date.split('-')
      if ([12, 17, 28].includes(parseInt(day, 10))) return true
      if ([1, 19, 22].includes(parseInt(day, 10))) return ['red', '#00f']
      return false
    },
  },
}
</script>
