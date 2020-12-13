<template>
  <div>
    <div slot="header">
      <span>正在直播</span>
    </div>
    <el-table :data="currentLesson" stripe style="width: 100%">
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
      currentLesson: [
        {
          course: '计算机算法分析与设计',
          room: '101',
        },
        {
          course: '高级软件工程',
          room: '102',
        },
        {
          course: '模式识别与机器学习',
          room: '201',
        },
      ],
      title: "正在直播",
    }
  }
}
</script>
