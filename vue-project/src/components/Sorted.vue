<template>
  <el-container>
    <el-header><span>未完成的作业</span></el-header>
    <el-main>
      <el-table
        stripe
        :data="tableData"
        height="500"
        border
        :default-sort="{ prop: 'ddl', order: 'descending' }"
        style="width: 100%"
      >
        <el-table-column prop="workName" label="作业" width="180">
        </el-table-column>
        <el-table-column prop="courseName" label="课程" width="180" sortable>
        </el-table-column>
        <el-table-column prop="ddl" label="截止日期" witdth="180" sortable>
        </el-table-column>
        <el-table-column label="操作">
          <template slot-scope="scope">
            <el-button size="mini" @click="handleEdit(scope.$index, scope.row)" icon="el-icon-edit">
            </el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-main>
  </el-container>
</template>

<script>
export default {
  data() {
    return {
      tableData: [
        {
          workName: "第一次作业",
          courseName: "软件工程",
          ddl: "2020-10-24",
        },
        {
          workName: "第二次作业",
          courseName: "软件工程",
          ddl: "2020-12-20",
        },
        {
          workName: "第三次作业",
          courseName: "软件工程",
          ddl: "2020-12-21",
        },
        {
          workName: "第四次作业",
          courseName: "软件工程",
          ddl: "2020-12-22",
        },
        {
          workName: "第一次作业",
          courseName: "椭圆曲线密码",
          ddl: "2020-11-26",
        },
        {
          workName: "第二次作业",
          courseName: "椭圆曲线密码",
          ddl: "2020-12-10",
        },
        {
          workName: "读书报告",
          courseName: "微观经济学",
          ddl: "2020-12-01",
        },
      ],
    };
  },
  props: {
    handleEdit: Function
  }
};
</script>
