<template>
    <div>
        <div style="display: flex;justify-content: space-between;margin-bottom: 10px;">
            <el-button icon="el-icon-plus" type="primary" @click="showAddEcView">添加奖惩资料</el-button>
            <el-button icon="el-icon-refresh" type="success" @click="initEcs"></el-button>
        </div>
        <div>
            <el-table
                    element-loading-text="正在加载..."
                    element-loading-spinner="el-icon-loading"
                    element-loading-background="rgba(0, 0, 0, 0.8)"
                    border stripe
                    :data="encourages"
                    style="margin-top: 2px"
                    size="medium">
                <el-table-column  width="55" fixed  type="selection"> </el-table-column>

                <el-table-column width="110" prop="eid" label="员工编号" align="center"></el-table-column>

                <el-table-column width="110" prop="ecDate" label="奖惩日期" align="center"></el-table-column>
                <el-table-column width="200" prop="ecReason" label="奖惩原因" align="center"></el-table-column>
                <el-table-column width="100" prop="ecPoint" label="奖惩分" align="center"></el-table-column>

                <el-table-column width="100" prop="ecType" label="奖惩类型 (0惩/1奖)" align="center"></el-table-column>


                <el-table-column width="250" prop="remark" label="备注" align="center"></el-table-column>
                <el-table-column label="操作" align="center">
                    <template slot-scope="scope">
                        <el-button @click="showEditEcView(scope.row)">编辑</el-button>
                        <el-button type="danger" @click="deleteEc(scope.row)">删除</el-button>
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
                :visible.sync="dialogVisible"
        >
            <el-form :model="encourage" :rules="rules" ref="ecForm">
                <el-row>
                    <el-col :span="8">
                        <el-form-item  label-width="100px" p label="工号:" prop="eid">
                            <el-input size="mini" refix-icon="el-icon-edit" v-model="encourage.eid"
                                      placeholder="请输入员工姓名"></el-input>
                        </el-form-item>
                    </el-col>
                    <el-col :span="9">
                        <el-form-item   label-width="150px" label="奖惩日期:" prop="ecDate">
                            <el-date-picker
                                    v-model="encourage.ecDate"
                                    size="mini"
                                    type="date"
                                    value-format="yyyy-MM-dd"
                                    style="width: 150px;"
                                    placeholder="奖惩日期">
                            </el-date-picker>
                        </el-form-item>
                    </el-col>
                </el-row>
                <el-row>
                    <el-col :span="8">
                        <el-form-item  label-width="100px"   label="奖惩原因:" prop="ecReason">
                            <el-input  :rows="1" type="textarea"  size="mini" style="width: 400px" prefix-icon="el-icon-edit" v-model="encourage.ecReason"
                                       placeholder=""></el-input>
                        </el-form-item>
                    </el-col>
                </el-row>
                <el-row>
                    <el-col :span="8">
                        <el-form-item  label-width="100px"  label="奖惩分:" prop="ecPoint">
                            <el-input    size="mini" prefix-icon="el-icon-edit" v-model="encourage.ecPoint"
                                       placeholder=""></el-input>
                        </el-form-item>
                    </el-col>
                    <el-col :span="11">
                        <el-form-item  label-width="150px"  label="奖惩类型:" prop="ecType">
                            <el-select size="mini" style="width:150px;" v-model="encourage.ecType" placeholder="0表示惩罚，1表示奖励">
                                <el-option label="1" value="1"></el-option>
                                <el-option label="0" value="0"></el-option>
                            </el-select>
                        </el-form-item>
                    </el-col>
                </el-row>
                <el-row style="padding-top: 10px;">
                    <el-col :span="7">
                        <el-form-item  label-width="100px"  label="备注:" prop="remark">
                            <el-input :rows="4"  type="textarea" size="mini" style="width: 400px" prefix-icon="el-icon-edit" v-model="encourage.remark"
                                      placeholder="请输入备注"></el-input>
                        </el-form-item>
                    </el-col>
                </el-row>
            </el-form>
            <span slot="footer" class="dialog-footer">
                <el-button @click="dialogVisible = false">取 消</el-button>
                <el-button type="primary" @click="doAddEc">确 定</el-button>
            </span>
        </el-dialog>

    </div>
</template>

<script>
    export default {
        name: "PerEc",
        data(){
            return{
                total:0,
                currentPage: 1,
                currentSize:6,
                title:"",
                dialogVisible:false,
                encourage:{
                    eid:"00000001",
                    ecDate:"",
                    ecReason:"",
                    ecPoint:"2",
                    ecType:"1",
                    remark:""
                },
                encourages:[],
                rules:{
                    eid: [{required: true, message: '请输入编号', trigger: 'blur'}],
                    ecDate: [{required: true, message: '请输入日期', trigger: 'blur'}],
                    ecReason:[{required: true, message: '请输入原因', trigger: 'blur'}],
                    ecPoint:[{required: true, message: '请输入奖惩分', trigger: 'blur'}],
                    ecType:[{required: true, message: '请输入奖惩类型0/1', trigger: 'blur'}]

                }
            }


        },
        mounted() {
            this.initEcs();
        },
        methods:{
            sizeChange(size) {
                this.currentSize = size;
                this.initEcs();
            },
            currentChange(page) {
                this.currentPage = page;
                this.initEcs();
            },
            showAddEcView() {
                this.title = "添加员工奖惩记录"
                this.encourage= {
                    eid:"00000001",
                    ecDate:"",
                    ecReason:"",
                    ecPoint:"",
                    ecType:"",
                    remark:""
                }
                this.dialogVisible = true
            },
            doAddEc() {
                if (this.encourage.id) {
                    this.$refs['ecForm'].validate(valid => {
                        if (valid) {
                            this.putRequest("/personnel/ec/", this.encourage).then(resp => {
                                if (resp) {
                                    this.dialogVisible = false;
                                    this.initEcs();
                                }
                            })
                        }
                    });
                } else {
                    this.$refs['ecForm'].validate(valid => {
                        if (valid) {
                            this.postRequest("/personnel/ec/",this.encourage).then(resp => {
                                if (resp) {
                                    this.dialogVisible = false;
                                    this.initEcs();
                                }
                            })
                        }
                    });
                }
            },
            showEditEcView(data){
                this.title = '编辑员工奖惩记录';
                this.encourage= data;
                this.dialogVisible = true;
            },
            deleteEc(data){
                this.$confirm('此操作将永久删除此条记录, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    this.deleteRequest("/personnel/ec/" + data.id).then(resp => {
                        if (resp) {
                            this.initEcs();
                        }
                    })
                }).catch(() => {
                    this.$message({
                        type: 'info',
                        message: '已取消删除'
                    });
                });
            },
            initEcs() {
                this.getRequest("/personnel/ec/?page=" + this.currentPage + '&size=' + this.currentSize).then(resp => {
                    if (resp) {
                        this.encourages = resp.data;
                        this.total=resp.total;

                    }
                })
            }
        }
    }
</script>

<style scoped>

</style>
