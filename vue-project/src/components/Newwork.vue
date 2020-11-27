<template>
  <el-container>
    <el-header><span>新的作业</span></el-header>
    <el-main>
      <el-table
        stripe
        :data="tableData"
        height="250"
        border
        :default-sort="{ prop: 'ddl', order: 'descending' }"
        style="width: 100%"
      >
        <el-table-column prop="workName" label="作业" width="180">
        </el-table-column>
        <el-table-column prop="courseName" label="课程" width="180">
        </el-table-column>
        <el-table-column prop="ddl" label="截止日期" witdth="180" sortable>
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
          workName: "第三次作业",
          courseName: "软件工程",
          ddl: "2020-12-21"
        },
        {
          workName: "第四次作业",
          courseName: "软件工程",
          ddl: "2020-12-22"
        },
      ],
    };
  },
};
</script>
