<template>
<v-app>
  <v-content>
    <v-btn icon @click="refresh()">
      <v-icon>mdi-cached</v-icon>
    </v-btn>
    <v-btn icon @click="handleDownloadZip()">
      <v-icon>mdi-download</v-icon>
    </v-btn>
    <v-sheet class="pa-4 primary lighten-2">
      <v-text-field v-model="filterText" label="输入关键字进行过滤" dark flat solo-inverted hide-details clearable clear-icon="mdi-close-circle-outline"></v-text-field>
    </v-sheet>
    <v-treeview v-loading="loading" selectable class="text-left" v-model="tree" :filter="filter" :search="filterText" :open="initiallyOpen" :items="resources" activatable item-key="address" open-on-click>
      <template v-slot:prepend="{ item, open }">
        <v-icon v-if="item.file == 'folder'">
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
        <v-btn v-if="item.file != 'folder'" icon @click="handlePreview(item)">
          <v-icon>
            mdi-eye
          </v-icon>
        </v-btn>
        <v-btn v-if="item.file != 'folder'" icon @click="handleDownload(item)">
          <v-icon>
            mdi-download
          </v-icon>
        </v-btn>
        <span>XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX</span>
      </template>
    </v-treeview>
  </v-content>
  <v-footer>
  </v-footer>
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
    }
  },
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
  computed: {
    filter() {
      return (item, search, textKey) => item[textKey].indexOf(search) > -1;
    },
  },
  methods: {
    handleDownloadZip() {
      const files = this.tree;
      console.log(files);
      if (files.length !== 0) {
        this.$http.get("/api/files", {
          params: {
            address: files
          },
          responseType: 'arraybuffer',
        }).then(
          (res) => {
            const url = window.URL.createObjectURL(new Blob([res.data]));
            const link = document.createElement('a');
            link.style.display = 'none';
            link.href = url;
            link.setAttribute('download', 'tmp.zip');
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
      }
    },
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
    },
  }
}
</script>
