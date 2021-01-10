<template>
  <div>
    <!-- <div slot="header">
      <el-row>
        <el-col style="text-align: left" :span="12">人文讲座</el-col>
        <el-col :span="6">已参与的讲座：{{ num }}</el-col>
        <el-col :span="6">已获得的学时：{{ hour }}</el-col>
      </el-row>
    </div> -->
    <el-collapse v-model="activeNames">
      <!-- <el-collapse-item title="最新" name="new">
        <el-table :data="tableNew" stripe style="width: 100%">
          <el-table-column prop="name" label="讲座名称"> </el-table-column>
          <el-table-column prop="hour" label="学时"> </el-table-column>
          <el-table-column prop="time" label="时间"> </el-table-column>
          <el-table-column fixed="right" label="报名" width="100">
            <template slot-scope="scope">
              <el-button
                @click="handleClick(scope.row)"
                type="text"
                size="small"
                >报名</el-button
              >
            </template>
          </el-table-column>
        </el-table>
      </el-collapse-item> -->
      <el-collapse-item title="人文讲座" name="all">
        <el-table :data="tableAll" stripe border resizable style="width: 100%">
          <el-table-column prop="name" label="讲座名称" min-width="370"> </el-table-column>
          <el-table-column prop="hour" label="学时" min-width="50"> </el-table-column>
          <el-table-column prop="time" label="时间" min-width="180"> </el-table-column>
          <el-table-column prop="speaker" label="主讲人" min-width="70"> </el-table-column>
          <el-table-column prop="department" label="部门" min-width="80"> </el-table-column>
          <!-- <el-table-column fixed="right" label="报名" width="100">
            <template slot-scope="scope">
              <el-button
                @click="handleClick(scope.row)"
                type="text"
                size="small"
                >报名</el-button
              >
            </template>
          </el-table-column> -->
        </el-table>
      </el-collapse-item>
    </el-collapse>
  </div>
</template>

<script>
export default {
  methods: {
    handleClick (row) {

    },
    redirectToLogin() {
      this.$notify.error({
        title: "错误",
        message: "请重新登录",
      });
      this.$router.push('/login');
    },
    getTableAll () {
      this.$http.get("/api/humanity_lectures").then(
        (res) => {
          let table = res.body
          for(let i = 0; i < table.length; ++i) {
            this.tableAll.push({
              name: table[i][0],
              hour: table[i][1],
              time: table[i][2],
              speaker: table[i][3],
              department: table[i][4],
            })
          }
        },
        (res) => { this.redirectToLogin() }
      )
      return []
    },
    getTableNew () {
      return []
    }
  },
  data () {
    return {
      // hour: '4',
      // num: '2',
      activeNames: ['all'],
      // tableNew: this.getTableNew(),
      tableAll: this.getTableAll(),
    }
  },
}
</script>
