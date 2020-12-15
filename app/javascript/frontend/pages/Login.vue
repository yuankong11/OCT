<template>
  <div class="login-container">
    <el-form
      :model="loginForm"
      :rules="rules"
      status-icon
      ref="loginForm"
      label-position="left"
      label-width="0px"
      class="login-page"
    >
      <h3 class="title">登录</h3>
      <el-form-item prop="username">
        <el-input
          type="text"
          v-model="loginForm.username"
          auto-complete="off"
          placeholder="用户名"
        ></el-input>
      </el-form-item>
      <el-form-item prop="password">
        <el-input
          type="password"
          v-model="loginForm.password"
          auto-complete="off"
          placeholder="密码"
        ></el-input>
      </el-form-item>
      <el-checkbox v-model="checked" class="rememberme">记住密码</el-checkbox>
      <el-form-item style="width: 100%">
        <el-button
          type="primary"
          style="width: 100%"
          @click="handleSubmit"
          :loading="logining"
          >登录</el-button
        >
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
export default {
  data () {
    return {
      logining: false,
      loginForm: {
        username: 'leizhengyu16@mails.ucas.ac.cn',
        password: 'lzy19980424',
      },
      rules: {
        username: [{ required: true, message: '请输入你的SEP账号', trigger: 'blur' }],
        password: [{ required: true, message: '请输入你的SEP密码', trigger: 'blur' }]
      },
      checked: false
    }
  },
  methods: {
    login () {
      var loginInfo = {username: this.loginForm.username, password: this.loginForm.password}
      this.$http.put("/api/login", loginInfo).then(
        (res) => {
          this.logining = false
          if(res.bodyText == "success") {
            sessionStorage.setItem('user', this.loginForm.username)
            this.$notify.info({
              title: "信息",
              message: "登录成功",
            })
            this.$router.push({ name: 'Dashboard' })
          } else {
            this.$notify.error({
              title: "错误",
              message: "用户名或密码错误",
            })
          }
        },
        (res) => {
          this.$notify.error({
            title: "错误",
            message: "登录遇到错误",
          })
          this.logining = false
        }
      )
    },
    handleSubmit (event) {
      this.$refs.loginForm.validate((valid) => {
        if (valid) {
          this.logining = true
          this.login()
        }
      })
    }
  }
};
</script>

<style>
.login-container {
  width: 100%;
  height: 100%;
}
.login-page {
  -webkit-border-radius: 5px;
  border-radius: 5px;
  margin: 180px auto;
  width: 700px;
  padding: 35px 35px 15px;
  background: #fff;
  border: 1px solid #eaeaea;
  box-shadow: 0 0 25px #cac6c6;
}
label.el-checkbox.rememberme {
  margin: 0px 0px 15px;
  text-align: left;
}
</style>
