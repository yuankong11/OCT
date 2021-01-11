<template>
  <v-card>
    <v-toolbar
      flat
      color="primary"
      dark
    >
      <v-toolbar-title>任务清单 TodoList</v-toolbar-title>
    </v-toolbar>
    <v-tabs v-model="tab" vertical icons-and-text>
      <v-tab>
        <v-icon left>
          mdi-account
        </v-icon>
        Option 1
      </v-tab>
      <v-tab>
        <v-icon left>
          mdi-lock
        </v-icon>
        Option 2
      </v-tab>
      <v-tab>
        <v-icon left>
          mdi-access-point
        </v-icon>
        Option 3
      </v-tab>

      <v-tab-item>
        <v-card flat>
          <v-card-text>
            <p>
              Sed aliquam ultrices mauris. Donec posuere vulputate arcu. Morbi ac felis. Etiam feugiat lorem non metus. Sed a libero.
            </p>

            <p>
              Nam ipsum risus, rutrum vitae, vestibulum eu, molestie vel, lacus. Aenean tellus metus, bibendum sed, posuere ac, mattis non, nunc. Aliquam lobortis. Aliquam lobortis. Suspendisse non nisl sit amet velit hendrerit rutrum.
            </p>

            <p class="mb-0">
              Phasellus dolor. Fusce neque. Fusce fermentum odio nec arcu. Pellentesque libero tortor, tincidunt et, tincidunt eget, semper nec, quam. Phasellus blandit leo ut odio.
            </p>
          </v-card-text>
        </v-card>
      </v-tab-item>
      <v-tab-item>
        <v-card flat>
          <v-card-text>
            <p>
              Morbi nec metus. Suspendisse faucibus, nunc et pellentesque egestas, lacus ante convallis tellus, vitae iaculis lacus elit id tortor. Sed mollis, eros et ultrices tempus, mauris ipsum aliquam libero, non adipiscing dolor urna a orci. Curabitur ligula sapien, tincidunt non, euismod vitae, posuere imperdiet, leo. Nunc sed turpis.
            </p>

            <p>
              Suspendisse feugiat. Suspendisse faucibus, nunc et pellentesque egestas, lacus ante convallis tellus, vitae iaculis lacus elit id tortor. Proin viverra, ligula sit amet ultrices semper, ligula arcu tristique sapien, a accumsan nisi mauris ac eros. In hac habitasse platea dictumst. Fusce ac felis sit amet ligula pharetra condimentum.
            </p>

            <p>
              Sed consequat, leo eget bibendum sodales, augue velit cursus nunc, quis gravida magna mi a libero. Nam commodo suscipit quam. In consectetuer turpis ut velit. Sed cursus turpis vitae tortor. Aliquam eu nunc.
            </p>

            <p>
              Etiam ut purus mattis mauris sodales aliquam. Ut varius tincidunt libero. Aenean viverra rhoncus pede. Duis leo. Fusce fermentum odio nec arcu.
            </p>

            <p class="mb-0">
              Donec venenatis vulputate lorem. Aenean viverra rhoncus pede. In dui magna, posuere eget, vestibulum et, tempor auctor, justo. Fusce commodo aliquam arcu. Suspendisse enim turpis, dictum sed, iaculis a, condimentum nec, nisi.
            </p>
          </v-card-text>
        </v-card>
      </v-tab-item>
      <v-tab-item>
        <v-card flat>
          <v-card-text>
            <p>
              Fusce a quam. Phasellus nec sem in justo pellentesque facilisis. Nam eget dui. Proin viverra, ligula sit amet ultrices semper, ligula arcu tristique sapien, a accumsan nisi mauris ac eros. In dui magna, posuere eget, vestibulum et, tempor auctor, justo.
            </p>

            <p class="mb-0">
              Cras sagittis. Phasellus nec sem in justo pellentesque facilisis. Proin sapien ipsum, porta a, auctor quis, euismod ut, mi. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nam at tortor in tellus interdum sagittis.
            </p>
          </v-card-text>
        </v-card>
      </v-tab-item>
    </v-tabs>
  </v-card>
</template>

<script>
export default {
  data() {
    return {
      todolist: [
        {
          todolistName: "Study",
          todoItem: [
            {
              todoName: "看算法第7章ppt",
              uid: 593304528,
              done: false,
              duedate: new Date(`20210112T21:12:10`),
              flag: true,
            },
            {
              todoName: "模式识别课件复习",
              uid: 593304529,
              done: false,
              duedate: new Date(`20210110T21:12:10`),
              flag: false,
            },
            {
              todoName: "Mooc",
              uid: 593304530,
              done: false,
              flag: false,
            },
          ]
        },
        {
          todolistName: "Work",
          todoItem: [
            {
              todoName: "任务管理模块",
              uid: 593304528,
              done: false,
              flag: true,
            },
            {
              todoName: "讲座展示模块",
              uid: 593304529,
              done: false,
              flag: false,
            },
            {
              todoName: "Mooc",
              uid: 593304530,
              done: false,
              flag: false,
            },
          ]
        },
        {
          todolistName: "DailyLife",
          todoItem: [
            {
              todoName: "吃饭",
              uid: 593304528,
              done: false,
              flag: true,
            },
            {
              todoName: "b站签到",
              uid: 593304529,
              done: false,
              flag: false,
            },
            {
              todoName: "Mooc",
              uid: 593304530,
              done: false,
              flag: false,
            },
          ]
        }
      ],
      //formLabelWidth: "160px",
    };
  },
  methods: {
    fetchTodoList(){
      let todolist = []
        this.$http.get("/api/todolist").then(
          (res) => {
            let tem_list = res.data;
            for (let i = 0; i < tem_list.length; i++) {//每个list
              let tlist = {}
              tlist["todolistName"] = tem_list[i].todolistName
              tlist["todoItem"] = []
              for(let j = 0; j<tem_list.todoItem.length; j++)//每个todo
              {
                tlist["todoItem"].push(
                  {
                    todoName: tem_list[i].todoItem[j].todoName,
                    uid: tem_list[i].todoItem[j].uid,
                    done: tem_list[i].todoItem[j].done,
                    flag: tem_list[i].todoItem[j].flag,
                    duedate: new Date(`tem_list[i].todoItem[j].duedate`),
                  }
                )
              }
              todolist.push(tlist)
            }
            this.todolist = todolist
          },
          (res) => {
            this.$notify.error({
              title: "错误",
              message: "获取任务清单失败",
            });
          }
        );
    },
  }
}
</script>
