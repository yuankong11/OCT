<template>
  <el-dialog :visible.sync="dialogTableVisible">
    <el-row>
      <el-col :span="24"><span>（作业名称）</span></el-col>
    </el-row>
    <el-row>
      <el-col :span="12">作业要求：{{ specifications }}</el-col>
      <el-col :span="12"
        ><el-container>
          <el-main
            >附件列表：
            <el-table :data="files" style="width: 100%">
              <el-table-column prop="date" label="文件名" width="100">
              </el-table-column>
              <el-table-column prop="name" label="上传日期" width="100">
              </el-table-column>
              <el-table-column prop="size" label="大小" width="80">
              </el-table-column> </el-table
          ></el-main>
          <el-footer
            ><el-button type="primary">提交</el-button></el-footer
          ></el-container
        ></el-col
      >
    </el-row>
    <el-row>
      <el-tabs v-model="activeName" @tab-click="handleClick">
        <el-tab-pane label="在线编辑" name="first">
          <el-container>
            <el-main>
              <el-input
                type="textarea"
                :rows="8"
                placeholder="Markdown"
                v-model="textarea"
              >
              </el-input>
            </el-main>
            <el-footer>
              <el-button>预览</el-button>
              <el-button>保存</el-button>
              <el-button type="primary">上传为PDF</el-button>
            </el-footer>
          </el-container>
        </el-tab-pane>
        <el-tab-pane label="上传文件" name="second">
          <el-upload
            class="upload-demo"
            action="https://jsonplaceholder.typicode.com/posts/"
            :on-preview="handlePreview"
            :on-remove="handleRemove"
            :before-remove="beforeRemove"
            multiple
            :limit="10"
            :on-exceed="handleExceed"
            :file-list="fileList"
          >
            <el-button size="small" type="primary">上传</el-button>
            <div slot="tip" class="el-upload__tip">
              只能上传jpg/png文件，且不超过5M
            </div>
          </el-upload>
        </el-tab-pane>
      </el-tabs>
    </el-row>
    <el-row> </el-row>
  </el-dialog>
</template>

<script>
export default {
  name: 'Workpad',
  data() {
    return {
      dialogTableVisible: false,
      specifications: "完成课后习题1-100",
      files: [
        {
          date: "2020-01-01",
          name: "作业.pdf",
          size: "5M",
        },
      ],
      fileList: [],
      activeName: "first",
      textarea: "",
    };
  },
  methods: {
    handleClick(tab, event) {
      console.log(tab, event);
    },
    handleRemove(file, fileList) {
      console.log(file, fileList);
    },
    handlePreview(file) {
      console.log(file);
    },
    handleExceed(files, fileList) {
      this.$message.warning(
        `当前限制选择 10 个文件，本次选择了 ${
          files.length
        } 个文件，共选择了 ${files.length + fileList.length} 个文件`
      );
    },
    beforeRemove(file) {
      return this.$confirm(`确定移除 ${file.name}？`);
    },
  },
};
</script>
