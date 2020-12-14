<template>
  <el-container>
    <el-header><div>测试数据</div></el-header>
    <el-main>
      <el-row :gutter="20">
        <el-col :span="12">
          <el-input v-model="input" placeholder="请输入内容"></el-input>
          <el-button type="primary" @click="append" round>提交</el-button>

          <ul>
            <li v-for="item in todolist" v-bind:key="item.id">
              {{ item.title }}
              <el-button
                type="danger"
                icon="el-icon-delete"
                circle
                @click="remove(item.id)"
              ></el-button>
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
          console.log(this.todolist)
        },
        (res) => {
          console.log('请求处理失败')
        }
      )
    },
    remove (iid) {
      this.$http.delete(`/tasks/${iid}`).then(
        (res) => {
          console.log('请求处理成功')
          console.log(res)
          this.todolist = this.todolist.filter((task) => task.id !== iid)
        },
        (res) => {
          console.log(res)
          console.log('请求处理失败')
        }
      )
    },
    append () {
      //var uid = this.todolist[this.todolist.length - 1]["id"] + 1
      this.$http.post('/tasks', { title: this.input, done: false }).then(
        (res) => {
          this.fetch_all()
        },
        (res) => {
          console.log('请求处理失败')
        }
      )
    },
  },
  data () {
    return {
      input: '',
      todolist: null,
    }
  },
};
</script>
