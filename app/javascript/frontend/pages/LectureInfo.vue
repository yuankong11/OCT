<template>
  <el-card>
  <el-container>
    <el-header style="text-align: center" class="lecture-info-header">
      <el-row :gutter="20">
        <el-col :span="22"><span style="font-size: 28px; font-weight:bold; color: #79BBFF">讲座信息</span></el-col>
        <el-col :span="2">
          <el-button type="primary" :loading="loading" @click="refresh()">刷新</el-button>
        </el-col>
      </el-row>
    </el-header>
    <el-main>
      <el-row :gutter="20">
        <el-col :span="12">
          <el-card>
            <el-collapse v-model="activeNames0">
              <el-collapse-item title="人文讲座" name="all0">
                <el-table :data="table[0]" stripe border resizable style="width: 100%">
                  <el-table-column prop="name" label="讲座名称" min-width="360"></el-table-column>
                  <el-table-column prop="hour" label="学时" min-width="50"></el-table-column>
                  <el-table-column prop="time" label="时间" min-width="180"></el-table-column>
                  <el-table-column prop="speaker" label="主讲人" min-width="70"></el-table-column>
                  <el-table-column prop="department" label="部门" min-width="80" ></el-table-column>
                </el-table>
              </el-collapse-item>
            </el-collapse>
          </el-card>
        </el-col>
        <el-col :span="12">
          <el-card>
            <el-collapse v-model="activeNames1">
              <el-collapse-item title="人文讲座" name="all1">
                <el-table :data="table[1]" stripe border resizable style="width: 100%">
                  <el-table-column prop="name" label="讲座名称" min-width="360"></el-table-column>
                  <el-table-column prop="hour" label="学时" min-width="50"></el-table-column>
                  <el-table-column prop="time" label="时间" min-width="180"></el-table-column>
                  <el-table-column prop="speaker" label="主讲人" min-width="70"></el-table-column>
                  <el-table-column prop="department" label="部门" min-width="80" ></el-table-column>
                </el-table>
              </el-collapse-item>
            </el-collapse>
          </el-card>
        </el-col>
      </el-row>
    </el-main>
  </el-container>
  </el-card>
</template>

<style>
.lecture-info-header {
  background-color: #f4f7fa;
  color: #333;
  line-height: 60px;
}
</style>

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
          for(let i = 0; i < 2; ++i) {
            for(let j = 0; j < t[i].length; ++j) {
              this.table[i].push({
                name: t[i][j][0],
                hour: t[i][j][1],
                time: t[i][j][2],
                speaker: t[i][j][3],
                department: t[i][j][4],
              })
            }
          }
        },
        (res) => { this.redirectToLogin() }
      )
    },
    refresh() {
      this.loading = true
      this.$http.get("/api/refresh_lectures").then(
        (res) => {
          this.table = [[], []]
          let t = res.body
          for(let i = 0; i < 2; ++i) {
            for(let j = 0; j < t[i].length; ++j) {
              this.table[i].push({
                name: t[i][j][0],
                hour: t[i][j][1],
                time: t[i][j][2],
                speaker: t[i][j][3],
                department: t[i][j][4],
              })
            }
          }
          this.loading = false
        },
        (res) => { this.redirectToLogin(); this.loading = false }
      )
    }
  },
  data () {
    return {
      activeNames0: ['all0'],
      activeNames1: ['all1'],
      table: [[], []],
      loading: false
    }
  }
}
</script>
