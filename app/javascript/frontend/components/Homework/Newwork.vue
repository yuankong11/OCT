<template>
<el-table stripe :data="tableData" :default-sort="{ prop: 'ddl', order: 'descending' }" style="width: 100%">
  <el-table-column prop="workName" label="作业">
  </el-table-column>
  <el-table-column prop="courseName" label="课程">
  </el-table-column>
  <el-table-column prop="ddl" label="截止日期" sortable>
  </el-table-column>
</el-table>
</template>

<script>
export default {
  name: 'Newwork',
  data() {
    return {
      tableData: [{
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
      title: '新的作业',
    }
  },
};
</script>
