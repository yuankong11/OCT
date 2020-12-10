<template>
  <div>
    <el-table
      ref="multipleTable"
      :data="tableData"
      style="width: 100%; margin-bottom: 20px"
      row-key="id"
      border
      default-expand-all
      :tree-props="{ children: 'children', hasChildren: 'hasChildren' }"
      @selection-change="handleSelectionChange"
    >
      <el-table-column type="selection" width="55"> </el-table-column>
      <el-table-column prop="fileName" label="文件名" sortable width="180">
      </el-table-column>
      <el-table-column prop="course" label="课程" sortable width="180">
      </el-table-column>
      <el-table-column prop="uploadDate" label="上传日期" sortable width="180">
      </el-table-column>
      <el-table-column prop="size" label="大小" sortable width="100">
      </el-table-column>
      <el-table-column label="操作">
        <template slot-scope="scope">
          <el-button
            size="mini"
            @click="handlePreview(scope.$index, scope.row)"
            icon="el-icon-view"
          ></el-button>
          <el-button
            size="mini"
            type="success"
            @click="handleFavor(scope.$index, scope.row)"
            icon="el-icon-star-off"
          ></el-button>
          <el-button
            size="mini"
            type="primary"
            @click="handleDownload(scope.$index, scope.row)"
            icon="el-icon-download"
          ></el-button>
        </template>
      </el-table-column>
    </el-table>
    <div style="margin-top: 20px">
      <el-button type="info" @click="toggleSelection()">取消选择</el-button>
      <el-button type="success">收藏</el-button>
      <el-button type="primary">下载</el-button>
    </div>
  </div>
</template>

<script>
export default {
  data () {
    return {
      tableData: [
        {
          id: 3,
          course: "课程B",
          fileName: "课外阅读资料",
          uploadDate: "2020-11-16",
          size: "20M",
          children: [
            {
              id: 31,
              course: "课程B",
              fileName: "论文1.pdf",
              uploadDate: "2020-11-16",
              size: "10M",
            },
            {
              id: 32,
              course: "课程B",
              fileName: "论文2.pdf",
              uploadDate: "2020-09-16",
              size: "10M",
            },
          ],
        },
      ],
      title: "文件",
      multipleSelection: [],
    }
  },
  methods: {
    toggleSelection (rows) {
      if (rows) {
        rows.forEach((row) => {
          this.$refs.multipleTable.toggleRowSelection(row)
        })
      } else {
        this.$refs.multipleTable.clearSelection()
      }
    },
    handleSelectionChange (val) {
      this.multipleSelection = val
    },
    handleFavor () { },
    handleDownload () { },
    handlePreview () { },
  },
};
</script>
