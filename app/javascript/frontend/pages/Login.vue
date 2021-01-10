<template>
  <div class="login-container">
    <h1 class="login-logo">OCT</h1>
    <el-form
      :model="loginForm"
      :rules="rules"
      status-icon
      ref="loginForm"
      label-position="left"
      label-width="0px"
      class="login-page"
    >
      <h2 class="login-title">登录</h2>
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
      <el-checkbox v-model="remember_me" class="remember-me">记住我</el-checkbox>
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
        username: localStorage.getItem("username"),
        password: localStorage.getItem("password")
      },
      rules: {
        username: [{ required: true, message: '请输入你的SEP账号', trigger: 'blur' }],
        password: [{ required: true, message: '请输入你的SEP密码', trigger: 'blur' }]
      },
      remember_me: true
    }
  },
  methods: {
    login () {
      let loginInfo = {username: this.loginForm.username, password: this.loginForm.password}
      this.$http.put("/api/login", loginInfo).then(
        (res) => {
          this.logining = false
          if(res.bodyText == "success") {
            this.$notify.info({
              title: "信息",
              message: "登录成功",
            })
            if (this.remember_me) {
              localStorage.setItem("username", loginInfo.username)
              localStorage.setItem("password", loginInfo.password)
            } else {
              localStorage.clear()
            }
            sessionStorage.setItem("logged", true)
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
/* TODO: 添加背景图片及透明效果 */
/* body{
  z-index: 0;
}

body::before {
   content: '';
   position: absolute;
   left: 0; right: 0; top: 0; bottom: 0;
   background: url('../../../assets/images/background.jpg') no-repeat cover;
   z-index: -1;
   opacity: .5;
} */

.login-logo{
  text-align: center;
    color: #409eff;
    padding-top: 50px;
    font-size: xxx-large;
}

.login-container {
  width: 100%;
  height: 100%;
}
.login-page {
  -webkit-border-radius: 5px;
  border-radius: 5px;
  margin: 50px auto;
  width: 700px;
  padding: 35px 35px 15px;
  background: #fff;
  border: 1px solid #eaeaea;
  box-shadow: 0 0 25px #cac6c6;
}
label.el-checkbox.remember-me {
  margin: 0px 0px 15px;
  text-align: left;
}
.login-title{
  text-align: center;
  padding-bottom: 20px;
}
</style>
