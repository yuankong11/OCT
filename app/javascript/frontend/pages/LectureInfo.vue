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
          <el-card><HumanityLecture v-bind:table="table[0]"></HumanityLecture></el-card>
        </el-col>
        <el-col :span="12">
          <el-card><ScienceLecture v-bind:table="table[1]"></ScienceLecture></el-card>
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
import ScienceLecture from '../components/LectureInfo/ScienceLecture'
import HumanityLecture from '../components/LectureInfo/HumanityLecture.vue'

export default {
  components: { ScienceLecture, HumanityLecture },
  methods: {
    redirectToLogin() {
      this.$notify.error({
        title: "错误",
        message: "请重新登录",
      });
      this.$router.push('/login');
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
      table: [[], []],
      loading: false
    }
  }
}
</script>
