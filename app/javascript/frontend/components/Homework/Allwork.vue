<template>
<el-table stripe :data="tableData" :default-sort="{ prop: 'ddl', order: 'descending' }" style="width: 100%">
  <el-table-column prop="workName" label="作业">
  </el-table-column>
  <el-table-column prop="courseName" label="课程" sortable>
  </el-table-column>
  <el-table-column prop="ddl" label="截止日期" sortable>
  </el-table-column>
  <el-table-column prop="status" label="提交状态" sortable>
  </el-table-column>
  <el-table-column label="操作">
    <template slot-scope="scope">
      <el-button size="mini" @click="handleEdit(scope.$index, scope.row)" icon="el-icon-edit">
      </el-button>
    </template>
  </el-table-column>
</el-table>
</template>

<script>
export default {
  name: "Allwork",
  props: {
    handleEdit: Function,
  },
  data() {
    return {
      dialogVisible: true,
      tableData: [{
          workName: "第一次作业",
          courseName: "软件工程",
          ddl: "2020-10-24",
          status: "未提交",
        },
        {
          workName: "第二次作业",
          courseName: "软件工程",
          ddl: "2020-12-20",
          status: "未提交",
        },
        {
          workName: "第三次作业",
          courseName: "软件工程",
          ddl: "2020-12-21",
          status: "未提交",
        },
        {
          workName: "第四次作业",
          courseName: "软件工程",
          ddl: "2020-12-22",
          status: "未提交",
        },
        {
          workName: "第一次作业",
          courseName: "椭圆曲线密码",
          ddl: "2020-11-26",
          status: "未提交",
        },
        {
          workName: "第二次作业",
          courseName: "椭圆曲线密码",
          ddl: "2020-12-10",
          status: "未提交",
        },
        {
          workName: "读书报告",
          courseName: "微观经济学",
          ddl: "2020-12-01",
          status: "未提交",
        },
      ],
    }
  },
  methods: {
    // handleEdit(index, row) {
    //   console.log(index, row);
    // },
  },
};
</script>
