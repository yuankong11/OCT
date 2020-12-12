<!-- 周视图 -->
<template>
  <div>
    <div slot="header">
      <span>日程周视图</span>
    </div>
    <el-calendar v-model="value"> </el-calendar>
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
