<template>
  <el-collapse v-model="activeNames">
    <el-collapse-item title="人文讲座" name="all">
      <el-table :data="table" stripe border resizable style="width: 100%">
        <el-table-column prop="name" label="讲座名称" min-width="360"></el-table-column>
        <el-table-column prop="hour" label="学时" min-width="50"></el-table-column>
        <el-table-column prop="time" label="时间" min-width="180"></el-table-column>
        <el-table-column prop="speaker" label="主讲人" min-width="70"></el-table-column>
        <el-table-column prop="department" label="部门" min-width="80" ></el-table-column>
      </el-table>
    </el-collapse-item>
  </el-collapse>
</template>

<script>
export default {
  mounted: function() {
    this.getTable()
  },
  methods: {
    redirectToLogin() {
      this.$notify.error({
        title: "错误",
        message: "请重新登录",
      });
      this.$router.push('/login');
    },
    getTable () {
      this.$http.get("/api/lectures").then(
        (res) => {
          let t = res.body
          let i = 0
          this.table = []
          for(let j = 0; j < t[i].length; ++j) {
            this.table.push({
              name: t[i][j][0],
              hour: t[i][j][1],
              time: t[i][j][2],
              speaker: t[i][j][3],
              department: t[i][j][4],
            })
          }
        },
        (res) => { this.redirectToLogin() }
      )
    }
  },
  props: ['table'],
  data () {
    return {
      activeNames: ['all']
    }
  }
}
</script>
