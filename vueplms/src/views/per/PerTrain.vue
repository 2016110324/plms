<template>
    <div>
        <div style="display: flex;justify-content: space-between;margin-bottom: 10px;">
            <el-button icon="el-icon-plus" type="primary" @click="showAddTrainView">添加培训资料</el-button>
            <el-button icon="el-icon-refresh" type="success" @click="initTrains"></el-button>
        </div>
        <div>
            <el-table
                    element-loading-text="正在加载..."
                    element-loading-spinner="el-icon-loading"
                    element-loading-background="rgba(0, 0, 0, 0.8)"
                    border stripe
                    :data="trains"
                    style="margin-top: 2px"
                    size="medium">
                <el-table-column  width="55" fixed  type="selection"> </el-table-column>

                <el-table-column width="110" prop="eid" label="员工编号" align="center"></el-table-column>

                <el-table-column width="110" prop="trainDate" label="培训日期" align="center"></el-table-column>
                <el-table-column width="250" prop="trainContent" label="培训内容" align="center"></el-table-column>
                <el-table-column width="250" prop="remark" label="备注" align="center"></el-table-column>
                <el-table-column label="操作" align="center">
                    <template slot-scope="scope">
                        <el-button @click="showEditTrainView(scope.row)">编辑</el-button>
                        <el-button type="danger" @click="deleteTrain(scope.row)">删除</el-button>
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
                :title="title"
                width="50%"
                :visible.sync="dialogVisible"
                >
            <el-form :model="train" :rules="rules" ref="trainForm">
                <el-row>
                    <el-col :span="8">
                        <el-form-item  label-width="120px"  label="工号:" prop="eid">
                            <el-input size="mini"  prefix-icon="el-icon-edit" v-model="train.eid"
                                      placeholder="请输入员工姓名"></el-input>
                        </el-form-item>
                    </el-col>
                    <el-col :span="6">
                        <el-form-item  label-width="100px"  label="培训日期:" prop="trainDate">
                            <el-date-picker
                                    v-model="train.trainDate"
                                    size="mini"
                                    type="date"
                                    value-format="yyyy-MM-dd"
                                    style="width: 150px;"
                                    placeholder="培训日期">
                            </el-date-picker>
                        </el-form-item>
                    </el-col>
                </el-row>
                <el-row>
                    <el-col :span="7">
                    <el-form-item  label-width="120px"  label="内容:" prop="trainContent">
                        <el-input  :rows="4" type="textarea"  size="mini" style="width: 340px" prefix-icon="el-icon-edit" v-model="train.trainContent"
                                  placeholder="请输入培训内容"></el-input>
                    </el-form-item>
                    </el-col>
                </el-row>
                <el-row style="padding-top: 10px;">
                    <el-col :span="7">
                        <el-form-item  label-width="120px"  label="备注:" prop="remark">
                            <el-input :rows="4"  type="textarea" size="mini" style="width: 340px" prefix-icon="el-icon-edit" v-model="train.remark"
                                      placeholder="请输入备注"></el-input>
                        </el-form-item>
                    </el-col>
                </el-row>
            </el-form>
            <span slot="footer" class="dialog-footer">
                <el-button @click="dialogVisible = false">取 消</el-button>
                <el-button type="primary" @click="doAddEmp">确 定</el-button>
            </span>
        </el-dialog>

    </div>
</template>

<script>
    export default {
        name: "PerTrain",
        data(){
            return{
                total:0,
                currentPage: 1,
                currentSize:8,
                title:"",
                trains:[],
                dialogVisible:false,
                train:{
                    eid:"00000001",
                    trainDate:"",
                    trainContent:"",
                    remark:""
                },
                rules:{
                    eid: [{required: true, message: '请输入编号', trigger: 'blur'}],
                    trainDate: [{required: true, message: '请输入日期', trigger: 'blur'}],
                    trainContent:[{required: true, message: '请输入内容', trigger: 'blur'}]

                }
            }


        },
        mounted() {
            this.initTrains();
        },
        methods:{
            sizeChange(size) {
                this.currentSize = size;
                this.initTrains() ;
            },
            currentChange(page) {
                this.currentPage = page;
                this.initTrains() ;
            },
            showAddTrainView() {
                this.title = "添加员工培训记录"
                this.train = {
                    eid:"00000001",
                    trainDate:"",
                    trainContent:"",
                    remark:""
                }
                this.dialogVisible = true
            },
            doAddEmp() {
                if (this.train.id) {
                    this.$refs['trainForm'].validate(valid => {
                        if (valid) {
                            this.putRequest("/personnel/train/", this.train).then(resp => {
                                if (resp) {
                                    this.dialogVisible = false;
                                    this.initTrains();
                                }
                            })
                        }
                    });
                } else {
                    this.$refs['trainForm'].validate(valid => {
                        if (valid) {
                            this.postRequest("/personnel/train/", this.train).then(resp => {
                                if (resp) {
                                    this.dialogVisible = false;
                                    this.initTrains();
                                }
                            })
                        }
                    });
                }

            },
            showEditTrainView(data){
                this.title = '编辑员工培训记录';
                this.train = data;
                this.dialogVisible = true;
            },
            deleteTrain(data){
                this.$confirm('此操作将永久删除此条记录, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    this.deleteRequest("/personnel/train/" + data.id).then(resp => {
                        if (resp) {
                            this.initTrains();
                        }
                    })
                }).catch(() => {
                    this.$message({
                        type: 'info',
                        message: '已取消删除'
                    });
                });
            },
            initTrains() {
                this.getRequest("/personnel/train/?page=" + this.currentPage + '&size=' + this.currentSize).then(resp => {
                    if (resp) {
                        this.trains = resp.data;
                        this.total=resp.total;

                    }
                })
            }
        }
    }
</script>

<style scoped>

</style>
