<template>
  <el-container>
    <el-header><div>测试数据</div></el-header>
    <el-main>
      <el-row :gutter="20">
        <el-col :span="12">
          <el-input v-model="input" placeholder="请输入内容"></el-input>
          <el-button type="primary" @click="fetch_all" round>提交</el-button>
          <ul>
            <li v-for="item in todolist" v-bind:key="item.id">
              {{ item.title }}
            </li>
          </ul>
        </el-col>
      </el-row>
    </el-main>
  </el-container>
</template>


<script>
export default {
  created: function () {
    this.fetch_all()
  },
  methods: {
    fetch_all () {
      this.$http.get('/tasks').then(
        (res) => {
          this.todolist = res.data
        },
        (res) => {
          console.log('请求处理失败')
        }
      )
    }
  },
  data () {
    return {
      input: '',
      todolist: null,
    }
  },
};
</script>
