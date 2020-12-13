<template>
  <el-tabs v-model="activeName" @tab-click="handleClick">
    <el-tab-pane label="今日任务" name="first">
      <el-input
        placeholder="回车添加待办事项"
        class="todoinput"
        @keyup.enter.native="add"
        v-model="newtodo.title"
      ></el-input>
      <p>
        进行中：{{ ingnum }} 已完成：{{ donenum
        }}<el-progress :percentage="50"></el-progress>
      </p>
      <el-row
        v-for="(item, index) in todolist"
        class="list-row"
        v-bind:key="item.id"
      >
        <el-col
          :xs="2"
          :sm="1"
          :md="1"
          :lg="1"
          :xl="1"
          class="check"
          :class="{
            red: !todolist[index].done,
            green: todolist[index].done,
          }"
        >
          <el-checkbox size="mini" v-model="item.done"></el-checkbox>
        </el-col>
        <el-col :xs="20" :sm="22" :md="22" :lg="22" :xl="22">
          <input
            type="text"
            v-model="item.title"
            class="ipcont"
            :class="{ done: todolist[index].done }"
          />
        </el-col>
        <el-col :xs="2" :sm="1" :md="1" :lg="1" :xl="1" class="close">
          <i class="el-icon-close" @click="del(index)"></i>
        </el-col>
      </el-row>
    </el-tab-pane>
    <el-tab-pane label="重要" name="second">重要</el-tab-pane>
    <el-tab-pane label="已规划日程" name="third">已规划日程</el-tab-pane>
    <el-tab-pane label="已完成" name="fourth">已完成</el-tab-pane>
  </el-tabs>
</template>

<style>
.todoinput {
  margin-bottom: 40px;
}

.list-row {
  height: 40px;
  background-color: #fbfbfb;
  margin-bottom: 5px;
}

.check {
  text-align: center;
  line-height: 40px;
}

.red {
  border-left: #ef5f65 2px solid;
}

.green {
  border-left: #b9e1dc 2px solid;
}

.ipcont {
  width: 90%;
  margin-top: 8px;
  border: 0;
  line-height: 24px;
  background-color: transparent;
  font-size: 16px;
  color: #756c83;
}

.close {
  text-align: center;
  line-height: 40px;
}

.el-icon-close {
  cursor: pointer;
}

.el-icon-close:hover {
  color: #ef5f65;
}

.done {
  text-decoration: line-through;
}
</style>

<script>
export default {
  mounted: function () {
    //this.fetch_all()
  },
  methods: {
    handleClick (tab, event) {
      console.log(tab, event)
    },
    add: function () {
      if (this.newtodo.title) {
        this.todolist.push(this.newtodo)
        this.newtodo = { title: "", done: false }
      }
    },
    del: function (index) {
      this.todolist.splice(index, 1)
    },
  },
  data () {
    return {
      activeName: "first",
      newtodo: {
        title: "",
        done: false,
      },
      todolist: [],
      ingnum: 3,
      donenum: 3,
    }
  },
  watch: {
    todolist: {
      handler (items) {
        save(items)
      },
      // 深度监听：属性值的变化{{ todolist.length -  donenum}}  已完成：{{ donenum }}
      // 给所有属性添加监听器，开销较大
      deep: true,
    },
  },
}
</script>
