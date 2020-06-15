<template>
    <div>
        <div style="display: flex;justify-content: space-between">
            <el-button icon="el-icon-plus" type="primary" @click="showAddSalaryView">添加工资账套</el-button>
            <el-button icon="el-icon-refresh" type="success" @click="initSalaries"></el-button>
        </div>
        <div style="margin-top: 10px">
            <el-table :data="salaries" border stripe>
                <el-table-column type="selection" width="55"></el-table-column>
                <el-table-column width="120" prop="name" label="账套名称"></el-table-column>
                <el-table-column width="70" prop="basicSalary" label="基本工资"></el-table-column>
                <el-table-column width="70" prop="trafficSalary" label="交通补助"></el-table-column>
                <el-table-column width="70" prop="lunchSalary" label="午餐补助"></el-table-column>
                <el-table-column width="70" prop="bonus" label="奖金"></el-table-column>
                <el-table-column width="100" prop="createDate" label="启用时间"></el-table-column>

                <el-table-column label="操作">
                    <template slot-scope="scope">
                        <el-button @click="showEditSalaryView(scope.row)">编辑</el-button>
                        <el-button type="danger" @click="deleteSalary(scope.row)">删除</el-button>
                    </template>
                </el-table-column>
            </el-table>
        </div>
        <div style="display: flex;justify-content: flex-end">
            <el-pagination
                    background
                    @size-change="sizeChange"
                    @current-change="currentChange"
                    :page-sizes="[6, 10, 20, 30]"
                    :page-size="6"
                    layout="sizes, prev, pager, next, jumper, ->, total, slot"
                    :total="total">
            </el-pagination>
        </div>
        <el-dialog
                :title="dialogTitle"
                :visible.sync="dialogVisible"
                width="50%">
            <div style="display: flex;justify-content: space-around;align-items: center">
                <el-steps direction="vertical" :active="activeItemIndex">
                    <el-step :title="itemName" v-for="(itemName,index) in salaryItemName" :key="index"></el-step>
                </el-steps>
                <el-input v-model="salary[title]" :placeholder="'请输入'+salaryItemName[index]+'...'"
                          v-for="(value,title,index) in salary"
                          :key="index" v-show="activeItemIndex==index" style="width: 200px"></el-input>
            </div>
            <span slot="footer" class="dialog-footer">
                <el-button @click="preStep">{{activeItemIndex==4?'取消':'上一步'}}</el-button>
                <el-button type="primary" @click="nextStep">{{activeItemIndex==4?'完成':'下一步'}}</el-button>
            </span>
        </el-dialog>
    </div>
</template>

<script>
    export default {
        name: "SalSob",
        data() {
            return {
                total:0,
                currentPage: 1,
                currentSize:6,
                page:1,
                size:6,
                dialogVisible: false,
                dialogTitle: '添加工资账套',
                salaries: [],
                activeItemIndex: 0,
                salaryItemName: [
                    '基本工资',
                    '交通补助',
                    '午餐补助',
                    '奖金',
                    '账套名称'
                ],
                salary: {
                    basicSalary: 0,
                    trafficSalary: 0,
                    lunchSalary: 0,
                    bonus: 0,
                    name: ''
                }
            }
        },
        mounted() {
            this.initSalaries();
        },
        methods: {

            sizeChange(size) {
                this.currentSize = size;
                this.initSalaries();
            },
            currentChange(page) {
                this.currentPage = page;
                this.initSalaries();
            },
            showEditSalaryView(data) {
                this.activeItemIndex = 0;

                this.dialogTitle = '修改工资账套';
                this.dialogVisible = true;
                this.salary.basicSalary = data.basicSalary;
                this.salary.trafficSalary = data.trafficSalary;
                this.salary.lunchSalary = data.lunchSalary;
                this.salary.bonus = data.bonus;

                this.salary.name = data.name;
                this.salary.id = data.id;
            },
            deleteSalary(data) {
                this.$confirm('此操作将删除【' + data.name + '】账套，是否继续？', '提示', {
                    cancelButtonText: '取消',
                    confirmButtonText: '确定'
                }).then(() => {
                    this.deleteRequest("/salary/sob/" + data.id).then(resp => {
                        if (resp) {
                            this.initSalaries();
                        }
                    })
                }).catch(() => {
                    this.$message.info("取消删除!");
                })
            },
            preStep() {
                if (this.activeItemIndex == 0) {
                    return;
                } else if (this.activeItemIndex == 5) {
                    //关闭对话框
                    this.dialogVisible = false;
                    return;
                }
                this.activeItemIndex--;
            },
            nextStep() {
                if (this.activeItemIndex == 4) {
                    if (this.salary.id) {
                        this.putRequest("/salary/sob/", this.salary).then(resp=>{
                            if (resp) {
                                this.initSalaries();
                                this.dialogVisible = false;
                            }
                        })
                    } else {
                        this.postRequest("/salary/sob/", this.salary).then(resp => {
                            if (resp) {
                                this.initSalaries();
                                this.dialogVisible = false;
                            }
                        });
                    }
                    return;
                }
                this.activeItemIndex++;
            },
            showAddSalaryView() {
                //数据初始化
                this.salary = {
                    basicSalary: 0,
                    trafficSalary: 0,
                    lunchSalary: 0,
                    bonus: 0,
                    name:0

                }
                this.dialogTitle = '添加工资账套';
                this.activeItemIndex = 0;
                this.dialogVisible = true;
            },
            initSalaries() {
                this.getRequest("/salary/sob/?page=" + this.currentPage + '&size=' + this.currentSize).then(resp => {
                    if (resp) {
                        this.salaries = resp.data;
                        this.total=resp.total;
                    }
                })
            }
        }
    }
</script>

<style scoped>

</style>
