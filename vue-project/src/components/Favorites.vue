<template>
  <div>
    <el-button
      @click="favorites = true"
      type="primary"
      style="margin-left: 16px;"
    >
      收藏夹
    </el-button>
    <el-drawer
      title="收藏夹"
      :visible.sync="favorites"
      size="30%"
      :direction="direction"
    >
    </el-drawer>
  </div>
</template>

<script>
export default {
  data() {
    return {
      favorites: false,
      direction: "ltr",
    };
  },
};
</script>
