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
                  @click="dialogVisible = true"
                ></el-button>
              </el-tooltip>
              <el-dialog title="编辑" :visible.sync="dialogVisible">
                <el-form>
                  <el-form-item label="新的任务名称："
                    ><!-- :label-width="formLabelWidth"> -->
                    <el-input v-model="item.title" autocomplete="off"></el-input>
                  </el-form-item>
                </el-form>
                <div slot="footer" class="dialog-footer">
                  <el-button @click="dialogVisible = false">取 消</el-button>
                  <el-button
                    type="primary"
                    @click="update(item.id, item.done, item.title)"
                    >确 定</el-button
                  >
                </div>
              </el-dialog>
              <el-tooltip
                class="item"
                effect="dark"
                content="完成该事项"
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
  color: rgb(60, 114, 179);
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
    update(iid, ddone, titlename) {
      this.$http.put(`/tasks/${iid}`, { title: titlename, done: ddone }).then(
        (res) => {
          //console.log("请求处理成功");
          //console.log(res);
          // this.todolist = this.todolist.filter((task) => task.id !== iid)
          this.fetchAll();
          this.$notify({
            title: "成功",
            message: "成功修改任务为: " + titlename,
            type: "success",
          });
        },
        (res) => {
          //console.log(res);
          //onsole.log("请求处理失败");
          this.$notify.error({
            title: "错误",
            message: "任务修改失败",
          });
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
      dialogVisible: false,
      //formLabelWidth: "160px",
    };
  },
};
</script>
