<template>
<v-app>
  <v-btn color="primary" elevation="2" @click="refresh">点我刷新</v-btn>
  <v-treeview :items="courses" item-key="name"></v-treeview>
</v-app>
</template>

<script>

export default {
  name: 'Resource',
  components: {
  },
  created() {
    this.refresh();
  },
  data() {
    return {
      courses: []
    }
  },
  methods: {
    refresh() {
      this.$http.get("/api/courses").then(
        (res) => {
          console.log(res.data);
          this.courses = res.data.map((x) => {
            // x['name'] = x['title'];
            return x;
          });
        },
        (res) => {
          //console.log("请求处理失败");
          this.$notify.error({
            title: "错误",
            message: "获取任务失败",
          });
        }
      )
    }
  }
}
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}

.resource-header {
  background-color: #e9eef3;
  color: #333;
  text-align: center;
  line-height: 60px;
}
</style>
