<template>
<v-app>
  <v-content>
    <v-row>
      <v-col>
        <v-btn outlined color="blue" v-show="!treeIsEmpty" @click="handleDownloadZip()">
          下载<v-icon>mdi-download</v-icon>
        </v-btn>
      </v-col>
      <v-col>
        <v-btn v-show="downloading">
          正在下载，请稍后...
          <v-icon @click="downloading = false" color="green">
            mdi-close
          </v-icon>
        </v-btn>
      </v-col>
      <v-col>
        <v-btn outlined color="green" @click="refresh()">
          刷新<v-icon>mdi-cached</v-icon>
        </v-btn>
      </v-col>
    </v-row>
    <v-row>
      <v-col>
        <v-sheet class="pa-4 primary lighten-2">
          <v-text-field v-model="filterText" label="输入关键字进行过滤" dark flat solo-inverted hide-details clearable></v-text-field>
        </v-sheet>
      </v-col>
    </v-row>
    <v-row>
      <v-col>
        <v-treeview dense class="text-left" v-loading="loading" selectable v-model="tree" :filter="filter" :search="filterText" :open="initiallyOpen" :items="resources" activatable item-key="address" open-on-click>
          <template v-slot:prepend="{ item, open }">
            <v-icon v-if="item.file == 'folder' || item.file == 'course'">
              {{ open ? 'mdi-folder-open' : 'mdi-folder' }}
            </v-icon>
            <v-icon v-else-if="files.hasOwnProperty(item.file)">
              {{ files[item.file] }}
            </v-icon>
            <v-icon v-else>
              {{ files["unknown"] }}
            </v-icon>
          </template>
          <template v-slot:append="{ item }">
            <v-btn color="indigo lighten-2" icon v-if="item.file != 'folder'" @click="handlePreview(item)">
              <v-icon>
                mdi-eye
              </v-icon>
            </v-btn>
            <v-btn color="blue" icon v-if="item.file != 'folder'" @click="handleDownload(item)">
              <v-icon>
                mdi-download
              </v-icon>
            </v-btn>
          </template>
        </v-treeview>
      </v-col>
    </v-row>
  </v-content>
</v-app>
</template>

<script>
export default {
  data() {
    return {
      initiallyOpen: ['public'],
      files: {
        html: 'mdi-language-html5',
        js: 'mdi-nodejs',
        json: 'mdi-code-json',
        md: 'mdi-language-markdown',
        pdf: 'mdi-file-pdf',
        png: 'mdi-file-image',
        txt: 'mdi-file-document',
        xls: 'mdi-file-excel',
        xlsx: 'mdi-file-excel',
        doc: 'mdi-file-word',
        docx: 'mdi-file-word',
        ppt: 'mdi-file-powerpoint',
        pptx: 'mdi-file-powerpoint',
        zip: 'mdi-folder-zip',
        rar: 'mdi-folder-zip',
        unknown: 'mdi-file-document',
      },
      tree: [],
      resources: [],
      filterText: '',
      loading: true,
      downloading: false,
    }
  },
  name: 'Resource',
  components: {},
  created() {
    this.getResources();
  },
  watch: {
    filterText(val) {
      this.$refs.resourceTree.filter(val);
    }
  },
  computed: {
    filter() {
      return (item, search, textKey) => item[textKey].indexOf(search) > -1;
    },
    treeIsEmpty() {
      return this.tree.length === 0;
    }
  },
  methods: {
    onScroll() {

    },
    handleDownloadZip() {
      const files = this.tree;
      console.log(files);
      this.downloading = true;
      this.$http.get("/api/files", {
        params: {
          address: files
        },
        responseType: 'arraybuffer',
      }).then(
        (res) => {
          this.downloadSuccess(res, 'tmp.zip');
        },
        (res) => {
          this.redirectToLogin();
        }
      )
    },
    handleNodeClick() {

    },
    filterNode(value, data) {
      if (!value) return true;
      return data.name.indexOf(value) !== -1;
    },
    getResources() {
      this.loading = true;
      this.$http.get("/api/resources").then(
        (res) => {
          console.log(res.data);
          this.resources = res.data;
          this.loading = false;
        },
        (res) => {
          this.redirectToLogin();
        }
      )
    },
    refresh() {
      this.loading = true;
      this.$http.get("/api/refresh_resources").then(
        (res) => {
          console.log(res.data);
          this.resources = res.data;
          this.loading = false;
        },
        (res) => {
          this.redirectToLogin();
        }
      )
    },
    // handleFavor () { },
    handleDownload(file) {
      this.downloading = true;
      this.$http.get("/api/file", {
        params: {
          name: file.name,
          address: file.address
        },
        responseType: 'arraybuffer',
      }).then(
        (res) => {
          this.downloadSuccess(res, file.name);
        },
        (res) => {
          this.redirectToLogin();
        }
      )
    },
    downloadSuccess(res, name) {
      const url = window.URL.createObjectURL(new Blob([res.data]));
      const link = document.createElement('a');
      link.style.display = 'none';
      link.href = url;
      link.setAttribute('download', name);
      document.body.appendChild(link);
      link.click();
      link.remove();
      this.downloading = false;
    },
    redirectToLogin() {
      this.$notify.error({
        title: "错误",
        message: "请重新登录",
      });
      this.$router.push('/login');
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
          this.redirectToLogin();
        }
      )
    },
  }
}
</script>
