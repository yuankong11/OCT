<template>
<el-container>
  <el-header>
    <el-card>
      <el-button type="success" icon="el-icon-refresh" @click="refresh">刷新</el-button>
    </el-card>
  </el-header>
  <el-main>
    <el-card>
      <el-input placeholder="输入关键字进行过滤" v-model="filterText">
      </el-input>
    </el-card>
    <el-card>
      <el-tree v-loading="loading" node-key="name" :expand-on-click-node="false" class="filter-tree" :filter-node-method="filterNode" ref="resourceTree" :data="resources" :props="defaultProps" @node-click="handleNodeClick">
        <span class="custom-tree-node" slot-scope="{ node, data }">
          <span>{{ node.label }}</span>
          <span>
            <!-- <el-link icon="el-icon-download" href="node.link" target="_blank"></el-link> -->
            <el-button size="mini" @click="handlePreview(data)" icon="el-icon-view"></el-button>
            <!-- <el-button
            size="mini"
            type="success"
            @click="handleFavor()"
            icon="el-icon-star-off"
          ></el-button> -->
            <el-button size="mini" type="primary" @click="handleDownload(data)" icon="el-icon-download"></el-button>
          </span>
          <span>
            XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
          </span>
        </span>
      </el-tree>
    </el-card>
  </el-main>
</el-container>
</template>

<script>
export default {
  name: 'Resource',
  components: {},
  created() {
    this.refresh();
  },
  watch: {
    filterText(val) {
      this.$refs.resourceTree.filter(val);
    }
  },
  data() {
    return {
      resources: [],
      filterText: '',
      defaultProps: {
        children: 'children',
        label: 'name'
      },
      loading: true
    }
  },
  computed: {},
  methods: {
    handleNodeClick() {

    },
    filterNode(value, data) {
      if (!value) return true;
      return data.name.indexOf(value) !== -1;
    },
    refresh() {
      this.loading = true;
      this.$http.get("/api/resources").then(
        (res) => {
          console.log(res.data);
          this.resources = res.data;
          this.loading = false;
        },
        (res) => {
          this.$notify.error({
            title: "错误",
            message: "请重新登录",
          });
          this.$router.push('/app/login');
        }
      )
    },
    // handleFavor () { },
    handleDownload(file) {
      this.$http.get("/api/file", {
        params: {
          name: file.name,
          address: file.address
        },
        responseType: 'arraybuffer',
      }).then(
        (res) => {
          const url = window.URL.createObjectURL(new Blob([res.data]));
          const link = document.createElement('a');
          link.style.display = 'none';
          link.href = url;
          link.setAttribute('download', file.name);
          document.body.appendChild(link);
          link.click();
          link.remove();
        },
        (res) => {
          this.$notify.error({
            title: "错误",
            message: "请重新登录",
          });
          this.$router.push('/app/login');
        }
      )
    },
    handlePreview(file) {
      this.$http.get("/api/file", {
        params: {
          name: file.name,
          address: file.address
        },
        responseType: 'arraybuffer',
      }).then(
        (res) => {
          const pdfUrl = window.URL.createObjectURL(new Blob([res.data], {
            type: 'application/pdf'
          }));
          window.open(pdfUrl);
        },
        (res) => {
          this.$notify.error({
            title: "错误",
            message: "请重新登录",
          });
          this.$router.push('/app/login');
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

.custom-tree-node {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: space-between;
  font-size: 14px;
  padding-right: 8px;
}
</style>
