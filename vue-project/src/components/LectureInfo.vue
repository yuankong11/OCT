<template>
  <el-container>
    <el-header
      style="text-align: center;"
      class="lecture-info-header">
      <div>讲座信息</div>
    </el-header>
    <el-main>
      <el-row :gutter="20">
        <el-col :span="12">
          <el-card>
            <div slot="header">
              <el-row>
                <el-col style="text-align: left;" :span="12">人文讲座</el-col>
                <el-col :span="6">已参与的讲座：{{ num_1 }}</el-col>
                <el-col :span="6">已获得的学时：{{ hour_1 }}</el-col>
              </el-row>
            </div>
            <el-collapse v-model="activeNames" @change="handleChange">
              <el-collapse-item title="最新" name="New_1">
                <el-table
                  :data="table_1_1"
                  stripe
                  style="width: 100%">
                  <el-table-column
                    prop="name"
                    label="讲座名称">
                  </el-table-column>
                  <el-table-column
                    prop="hour"
                    label="学时">
                  </el-table-column>
                  <el-table-column
                    prop="time"
                    label="时间">
                  </el-table-column>
                  <el-table-column
                    fixed="right"
                    label="报名"
                    width="100">
                    <template slot-scope="scope">
                      <el-button @click="handleClick(scope.row)" type="text" size="small">报名</el-button>
                    </template>
                  </el-table-column>
                </el-table>
              </el-collapse-item>
              <el-collapse-item title="全部" name="All_1">
                <el-table
                  :data="table_1_2"
                  stripe
                  style="width: 100%">
                  <el-table-column
                    prop="name"
                    label="讲座名称">
                  </el-table-column>
                  <el-table-column
                    prop="hour"
                    label="学时">
                  </el-table-column>
                  <el-table-column
                    prop="time"
                    label="时间">
                  </el-table-column>
                  <el-table-column
                    fixed="right"
                    label="报名"
                    width="100">
                    <template slot-scope="scope">
                      <el-button @click="handleClick(scope.row)" type="text" size="small">报名</el-button>
                    </template>
                  </el-table-column>
                </el-table>
              </el-collapse-item>
            </el-collapse>
          </el-card>
        </el-col>
        <el-col :span="12">
          <el-card>
            <div slot="header">
              <el-row>
                <el-col style="text-align: left;" :span="12">科学前沿讲座</el-col>
                <el-col :span="6">已参与的讲座：{{ num_2 }}</el-col>
                <el-col :span="6">已获得的学时：{{ hour_2 }}</el-col>
              </el-row>
            </div>
            <el-collapse v-model="activeNames" @change="handleChange">
              <el-collapse-item title="最新" name="New_2">
                <el-table
                  :data="table_2_1"
                  stripe
                  style="width: 100%">
                  <el-table-column
                    prop="name"
                    label="讲座名称">
                  </el-table-column>
                  <el-table-column
                    prop="hour"
                    label="学时">
                  </el-table-column>
                  <el-table-column
                    prop="time"
                    label="时间">
                  </el-table-column>
                  <el-table-column
                    fixed="right"
                    label="报名"
                    width="100">
                    <template slot-scope="scope">
                      <el-button @click="handleClick(scope.row)" type="text" size="small">报名</el-button>
                    </template>
                  </el-table-column>
                </el-table>
              </el-collapse-item>
              <el-collapse-item title="全部" name="All_2">
                <el-table
                  :data="table_2_2"
                  stripe
                  style="width: 100%">
                  <el-table-column
                    prop="name"
                    label="讲座名称">
                  </el-table-column>
                  <el-table-column
                    prop="hour"
                    label="学时">
                  </el-table-column>
                  <el-table-column
                    prop="time"
                    label="时间">
                  </el-table-column>
                  <el-table-column
                    fixed="right"
                    label="报名"
                    width="100">
                    <template slot-scope="scope">
                      <el-button @click="handleClick(scope.row)" type="text" size="small">报名</el-button>
                    </template>
                  </el-table-column>
                </el-table>
              </el-collapse-item>
            </el-collapse>
          </el-card>
        </el-col>
      </el-row>
    </el-main>
  </el-container>
</template>

<style>
  .lecture-info-header {
    background-color: #E9EEF3;
    color: #333;
    line-height: 60px;
  }
</style>

<script>
export default {
  name: "LectureInfo",
  methods: {
    handleClick (row) {
      console.log(row)
    },
    handleChange (val) {
      console.log(val)
    }
  },
  data () {
    return {
      hour_1: '2',
      num_1: '1',
      hour_2: '4',
      num_2: '2',
      activeNames: ['New_1', 'New_2'],
      table_1_1: [{
        name: '现代地球-生命系统的形成',
        hour: '2',
        time: '2020-12-23 19:00-20:50'
      }],
      table_1_2: [{
        name: '现代地球-生命系统的形成',
        hour: '2',
        time: '2020-12-23 19:00-20:50'
      }, {
        name: '东北老工业基地城镇化与城市发展',
        hour: '2',
        time: '2020-12-19 19:00-21:00'
      }, {
        name: '青藏高原隆升与环境效应',
        hour: '2',
        time: '2020-12-16 19:00-20:50'
      }],
      table_2_1: [{
        name: '现代地球-生命系统的形成',
        hour: '2',
        time: '2020-12-23 19:00-20:50'
      }],
      table_2_2: [{
        name: '现代地球-生命系统的形成',
        hour: '2',
        time: '2020-12-23 19:00-20:50'
      }, {
        name: '东北老工业基地城镇化与城市发展',
        hour: '2',
        time: '2020-12-19 19:00-21:00'
      }, {
        name: '青藏高原隆升与环境效应',
        hour: '2',
        time: '2020-12-16 19:00-20:50'
      }, {
        name: '地幔柱与生物大灭绝',
        hour: '2',
        time: '2020-12-09 19:00-20:50'
      }]
    }
  }
}
</script>
