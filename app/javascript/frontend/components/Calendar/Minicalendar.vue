<template>
  <Calendar ref="Calendar"></Calendar>
</template>

<style>
.wh_container >>> .wh_content_all {
  background-color: #ffffff !important;
  border: 1px solid #dfe0e6;
  width: 600px;
  border-radius: 6px;
}
.wh_container {
  margin: 0px !important;
}

.wh_container >>> .wh_item_date {
  color: #211d48;
}
</style>

<script>
import Calendar from "vue-calendar-component"

export default {
  components: {
    Calendar,
  },
  data () {
    return {
      dateValue: new Date(),
    }
  },
};
</script>
