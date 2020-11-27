<template>
  <el-container>
    <el-header class="live-lesson">课程直播信息</el-header>
    <el-main>
      <el-row :gutter="20">
        <el-col :span="12">
          <el-card class="box-card">
            <div slot="header">
              <span>正在直播</span>
            </div>
            <el-table :data="tableData" stripe style="width: 100%">
              <el-table-column prop="course" label="课程"> </el-table-column>
              <el-table-column prop="room" label="教室"> </el-table-column>
              <el-table-column fixed="right" label="操作" width="100">
                <template slot-scope="scope">
                  <el-button
                    @click="handleClick(scope.row)"
                    type="text"
                    size="small"
                    >查看</el-button
                  >
                </template>
              </el-table-column>
            </el-table>
          </el-card>
        </el-col>
        <el-col :span="12">
          <el-card class="box-card">
            <div slot="header">
              <span>收藏</span>
            </div>
            <el-table :data="collectionData" stripe style="width: 100%">
              <el-table-column prop="course" label="课程"> </el-table-column>
              <el-table-column prop="room" label="教室"> </el-table-column>
              <el-table-column fixed="right" label="操作" width="100">
                <template slot-scope="scope">
                  <el-button
                    @click="handleClick(scope.row)"
                    type="text"
                    size="small"
                    >查看</el-button
                  >
                </template>
              </el-table-column>
            </el-table>
          </el-card>
        </el-col>
      </el-row>
    </el-main>
  </el-container>
</template>

<style>
.live-lesson {
  background-color: #e9eef3;
  color: #333;
  text-align: center;
  line-height: 60px;
}
</style>

<script>
export default {
  name: "LiveLesson",
  methods: {
    handleClick (row) {
      console.log(row)
    }
  },
  data () {
    return {
      tableData: [{
        course: 'AA',
        room: '101'
      }, {
        course: 'BB',
        room: '102'
      }, {
        course: 'CC',
        room: '201'
      }],
      collectionData: [{
        course: 'DD',
        room: '404'
      }, {
        course: 'XX',
        room: '303'
      }]
    }
  }
}
</script>
