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
              <div class="doing" v-if="!item.done">{{ item.title }}</div>
              <div class="done" v-if="item.done">{{ item.title }}</div>
              <el-tooltip
                class="item"
                effect="dark"
                content="修改该事项"
                placement="right"
              >
                <el-button
                  type="primary"
                  icon="el-icon-edit"
                  circle
                  @click="edit(item.id)"
                ></el-button>
              </el-tooltip>
              <el-tooltip
                class="item"
                effect="dark"
                content="修改该事项"
                placement="right"
              >
                <el-button
                  type="success"
                  icon="el-icon-check"
                  circle
                  @click="update(item.id, !item.done, item.title)"
                ></el-button>
              </el-tooltip>
              <el-tooltip
                class="item"
                effect="dark"
                content="删除该事项"
                placement="right"
              >
                <el-button
                  type="danger"
                  icon="el-icon-delete"
                  circle
                  @click="remove(item.id)"
                ></el-button>
              </el-tooltip>
            </li>
          </ul>
        </el-col>
      </el-row>
    </el-main>
  </el-container>
</template>

<style>
.done {
  text-decoration: line-through;
  color: rgb(85, 90, 96);
}
</style>
<script>
export default {
  created: function () {
    this.fetchAll();
  },
  methods: {
    fetchAll() {
      this.$http.get("/tasks").then(
        (res) => {
          this.todolist = res.data;
          console.log(this.todolist);
        },
        (res) => {
          console.log("请求处理失败");
        }
      );
    },
    remove(iid) {
      this.$http.delete(`/tasks/${iid}`).then(
        (res) => {
          console.log("请求处理成功");
          console.log(res);
          // this.todolist = this.todolist.filter((task) => task.id !== iid)
          this.fetchAll();
        },
        (res) => {
          console.log(res);
          console.log("请求处理失败");
        }
      );
    },
    edit(iid, ddone) {
      this.$prompt("请输入新的任务名称", "编辑", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        inputPlaceholder: "例如：追番",
      })
        .then(({ value }) => {
          this.update(iid, ddone, title);
          this.$message({
            type: "success",
            message: "成功修改任务为: " + value,
          });
        })
        .catch(() => {
          this.$message({
            type: "info",
            message: "取消输入",
          });
        });
    },
    update(iid, ddone, titlename) {
      this.$http.put(`/tasks/${iid}`, { title: titlename, done: ddone }).then(
        (res) => {
          console.log("请求处理成功");
          console.log(res);
          // this.todolist = this.todolist.filter((task) => task.id !== iid)
          this.fetchAll();
        },
        (res) => {
          console.log(res);
          console.log("请求处理失败");
        }
      );
    },
    append() {
      //var uid = this.todolist[this.todolist.length - 1]["id"] + 1
      this.$http.post("/tasks", { title: this.input, done: false }).then(
        (res) => {
          this.fetchAll();
        },
        (res) => {
          console.log("请求处理失败");
        }
      );
    },
  },
  data() {
    return {
      input: "",
      todolist: null,
    };
  },
};
</script>
