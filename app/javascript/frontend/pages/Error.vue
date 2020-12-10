<template>
  <div class="error-page">
    <el-container>
      <el-main class="errorContainer mx-auto">
        <h1 class="errorCode">404</h1>
        <p class="errorInfo">Opps, it seems that this page does not exist.</p>
      </el-main>
      <el-footer class="pageFooter">
        2020 &copy; OCT: A Better SEP - Made by Hongbin Zeng, Zhenyu Lei,
        Lianwei Yu, Huimin Ye.
      </el-footer>
    </el-container>
  </div>
</template>

<script>
import OCTFooter from '../components/LayoutComponents/OCTFooter'

export default {
  name: 'ErrorPage',
  components: { OCTFooter }
};
</script>
