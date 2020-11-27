<template>
  <el-container>
    <el-header class="calendar-header">日程管理</el-header>
    <el-main>
      <el-row :gutter="20">
        <el-col :span="17">
          <el-card class="box-card-cal">
            <div slot="header">
              <span>日程周视图</span>
            </div>
            <el-calendar v-model="dateValue"> </el-calendar>
          </el-card>
        </el-col>
        <el-col :span="6">
          <el-card class="box-card"
            ><Calendar
              ref="Calendar"
              :markDate="arr2"
              v-on:changeMonth="changeDate"
            ></Calendar>
          </el-card>
        </el-col>
        <el-col :span="6">
          <el-card class="box-card">
            <el-tabs v-model="activeName" @tab-click="handleClick">
              <el-tab-pane label="今日任务" name="first">
                <el-input
                  placeholder="回车添加待办事项"
                  class="todoinput"
                  @keyup.enter.native="add"
                  v-model="newtodo.content"
                ></el-input>
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
                      v-model="item.content"
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
              <el-tab-pane label="已计划日程" name="third"
                >已计划日程</el-tab-pane
              >
              <el-tab-pane label="自定义" name="fourth">自定义</el-tab-pane>
            </el-tabs>
          </el-card>
        </el-col>
      </el-row>
    </el-main>
  </el-container>
</template>

<style>
.box-card-cal {
  height: 820px;
}
.calendar-header {
  background-color: #e9eef3;
  color: #333;
  text-align: center;
  line-height: 60px;
}
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

.wh_container >>> .wh_content_all {
  background-color: #ffffff !important;
  border: 1px solid #dfe0e6;
  width: 600px;
  border-radius: 6px;
}
.wh_container {
  margin: 0px !important;
}

.wh_container >>> .wh_item_date {
  color: #211d48;
}
</style>

<script>
/* eslint-disable */
import Calendar from "vue-calendar-component"

components: {
  Calendar
}
export default {
  methods: {
    handleClick (tab, event) {
      console.log(tab, event)
    },
    add: function () {
      if (this.newtodo.content) {
        this.todolist.push(this.newtodo)
        this.newtodo = { content: "", done: false }
      }
    },
    del: function (index) {
      this.todolist.splice(index, 1)
    },
  },
  data () {
    return {
      activeName: "first",
      dateValue: new Date(),
      newtodo: {
        content: "",
        done: false,
      },
      todolist: [
        {
          content: "早上起床",
          done: true,
        },
        {
          content: "洗漱",
          done: true,
        },
        {
          content: "吃早饭",
          done: true,
        },
        {
          content: "上高级软件工程",
          done: false,
        },
        {
          content: "课后讨论",
          done: false,
        },
        {
          content: "完成作业",
          done: false,
        },
      ],
    }
  },
  components: {
    Calendar,
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
};
</script>
