<template>
<v-app>
  <v-btn icon color="green" elevation="2" @click="refresh">
    <v-icon>mdi-cached</v-icon>
  </v-btn>
  <v-sheet class="pa-4 primary lighten-2">
    <v-text-field v-model="search" label="Search Company Directory" dark flat solo-inverted hide-details clearable clear-icon="mdi-close-circle-outline"></v-text-field>
    <v-checkbox v-model="caseSensitive" dark hide-details label="Case sensitive search"></v-checkbox>
  </v-sheet>
  <v-treeview :items="resources" item-key="name" rounded hoverable selectable :search="search" :filter="filter"></v-treeview>
</v-app>
</template>

<script>
export default {
  name: 'Resource',
  components: {},
  created() {
    this.refresh();
  },
  data() {
    return {
      resources: [],
      search: null,
    }
  },
  computed: {
    filter() {
      return this.caseSensitive ?
        (item, search, textKey) => item[textKey].indexOf(search) > -1 :
        undefined
    },
  },
  methods: {
    refresh() {
      this.$http.get("/api/resources").then(
        (res) => {
          console.log(res.data);
          this.resources = res.data;
        },
        (res) => {
          //console.log("请求处理失败");
          this.$notify.error({
            title: "错误",
            message: "获取任务失败",
          });
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
</style>
