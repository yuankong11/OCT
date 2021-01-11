<template>
<el-table stripe
  :data="works"
  :default-sort="{ prop: 'due', order: 'descending' }"
  style="width: 100%"
  row-key="name"
  :tree-props="{children: 'children', hasChildren: 'hasChildren'}"
  default-expand-all>
  <!-- <el-table-column prop="name" label="作业">
  </el-table-column> -->
  <el-table-column prop="name" label="名称" sortable>
  </el-table-column>
  <el-table-column prop="due" label="截止日期" sortable>
  </el-table-column>
  <el-table-column prop="begin" label="开始日期" sortable>
  </el-table-column>
  <el-table-column prop="status" label="提交状态" sortable>
  </el-table-column>
  <!-- <el-table-column label="操作">
    <template slot-scope="scope">
      <el-button size="mini" @click="handleEdit(scope.$index, scope.row)" icon="el-icon-edit">
      </el-button>
    </template>
  </el-table-column> -->
</el-table>
</template>

<script>
export default {
  name: "Allwork",
  created() {
    this.refresh();
  },
  data() {
    return {
      dialogVisible: true,
      works: []
    }
  },
  methods: {
    refresh() {
      this.$http.get("/api/homework").then(
        (res) => {
          console.log(res.data);
          this.works = res.data;
        },
        (res) => {
          this.redirectToLogin();
        }
      )
    },
    redirectToLogin() {
      this.$notify.error({
        title: "错误",
        message: "请重新登录",
      });
      this.$router.push('/login');
    }
  }
};
</script>
