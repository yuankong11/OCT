<template>
  <div>
    <div slot="header">
      <span>收藏</span>
    </div>
    <el-table :data="collecttedLesson" stripe style="width: 100%">
      <el-table-column prop="course" label="课程"> </el-table-column>
      <el-table-column prop="room" label="教室"> </el-table-column>
      <el-table-column fixed="right" label="观看" width="100">
        <template slot-scope="scope">
          <el-button @click="handleClick(scope.row)" type="text" size="small"
            >查看</el-button
          >
        </template>
      </el-table-column>
    </el-table>
  </div>
</template>

<script>
export default {
  methods: {
    handleClick (row) {
      console.log(row)
    }
  },
  data () {
    return {
      collecttedLesson: [
        {
          course: '高级人工智能',
          room: '404',
        },
        {
          course: '并行与分布式计算',
          room: '303',
        },
      ],
    }
  },
}
</script>
