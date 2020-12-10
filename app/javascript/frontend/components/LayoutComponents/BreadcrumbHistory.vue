<template>
  <div v-if="!excluded">
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item>首页</el-breadcrumb-item>
    </el-breadcrumb>
    <!-- <b-breadcrumb :items="tree"></b-breadcrumb> -->
  </div>
</template>
<script>
  export default {
    name: 'BreadcrumbHistory',
    props: {
      exclude: {type: Array, default: () => []}
    },
    computed: {
      excluded() {
        return this.exclude.indexOf(this.$route.path.split('/').pop()) > -1;
      },
      route_list() {
        return ['YOU ARE HERE']
          .concat(this.$route.path
            .split('/')
            .slice(1)
            .map(route => route
              .split('-')
              .map(word => word[0].toUpperCase() + word.slice(1))
              .join(' ')
            )
          );
      }
    }
  }
</script>
