<template>
    <div>
        <div>

            <el-input
                    size="small"
                    class="addPosInput"
                    v-loading="loading"
                    element-loading-text="正在加载..."
                    element-loading-spinner="el-icon-loading"
                    element-loading-background="rgba(0, 0, 0, 0.8)"
                    placeholder="添加职位..."
                    prefix-icon="el-icon-plus"
                    @keydown.enter.native="addPosition"
                    v-model="pos.name">
            </el-input>
            <el-button icon="el-icon-plus" size="small" type="primary" @click="addPosition">添加</el-button>
        </div>
        <div class="posManaMain">
            <!--
           实现多选非常简单: 手动添加一个el-table-column，设type属性为selection即可；默认情况下若内容过多会折行显示，
           若需要单行显示可以使用show-overflow-tooltip属性， 它接受一个Boolean，为true时多余的内容会在 hover 时以 tooltip 的形式显示出来。
           -->
            <el-table
                    :data="positions"
                    border
                    @selection-change="handleSelectionChange"
                    size="small"
                    stripe
                    style="width: 70%">
                <el-table-column
                        type="selection"
                        width="55">
                </el-table-column>
                <el-table-column
                        prop="id"
                        label="编号"
                        width="55">
                </el-table-column>
                <el-table-column
                        prop="name"
                        label="职位名称"
                        width="180">
                </el-table-column>
                <el-table-column
                        prop="createDate"
                        width="150"
                        label="创建时间">
                </el-table-column>
                <el-table-column
                        label="是否启用">
                    <template slot-scope="scope">
                        <el-tag size="small" type="success" v-if="scope.row.enabled">已启用</el-tag>
                        <el-tag size="small" type="danger" v-else>未启用</el-tag>
                    </template>
                </el-table-column>
                <el-table-column label="操作">
                    <template slot-scope="scope"><!--slot-scope定义一个占位符-->
                        <el-button
                                size="mini"
                                @click="showEditView(scope.$index, scope.row)">编辑
                        </el-button><!--scope.$index是当前操作到第几行。scope.row是当前行json对象-->
                        <el-button
                                size="mini"
                                type="danger"
                                @click="handleDelete(scope.$index, scope.row)">删除
                        </el-button>
                    </template>
                </el-table-column>
            </el-table>
            <el-button @click="deleteMany" type="danger" size="small" style="margin-top: 8px"
                       :disabled="multipleSelection.length==0">批量删除
            </el-button>
        </div>

        <!--需要设置visible属性，它接收Boolean，当为true时显示 Dialog。
        Dialog 分为两个部分：body和footer，footer需要具名为footer的slot。title属性用于定义标题，它是可选的，默认值为空
        -->
        <el-dialog
                title="修改职位信息"
                :visible.sync="dialogVisible"
                width="30%">
            <div>
                <div style="margin-bottom: 3px;">
                    <el-tag>职位名称</el-tag>
                    <el-input class="updatePosInput" size="small" v-model="updatePos.name"></el-input>
                </div>
                <div>
                    <el-tag style="margin-right: 10px;">是否启用</el-tag>
                    <el-switch
                            v-model="updatePos.enabled"
                            active-text="启用"
                            inactive-text="禁用">
                    </el-switch>
                </div>
            </div>
            <span slot="footer" class="dialog-footer">
                <el-button size="small" @click="dialogVisible = false">取 消</el-button>
                <el-button size="small" type="primary" @click="doUpdate">确 定</el-button>
            </span>
        </el-dialog>
    </div>
</template>

<script>
    export default {
        name: "PosMana",
        data() {
            return {
                pos: {
                    name: ''
                },
                dialogVisible: false,
                loading: false,
                updatePos: {
                    name: '',
                    enabled: false
                },
                multipleSelection: [],//批量选择的项
                positions: []
            }
        },
        mounted() {
            this.initPositions();
        },
        methods: {
            //批量删除
            deleteMany() {
                this.$confirm('此操作将永久删除【' + this.multipleSelection.length + '】条记录, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    let ids = '?';
                    this.multipleSelection.forEach(item => {
                        ids += 'ids=' + item.id + '&';
                    })
                    console.log(ids)
                    this.deleteRequest("/system/basic/pos/" + ids).then(resp => {
                        if (resp) {
                            this.initPositions();
                        }
                    })
                }).catch(() => {
                    this.$message({
                        type: 'info',
                        message: '已取消删除'
                    });
                });
            },
            handleSelectionChange(val) {
                this.multipleSelection = val;//赋值当前选中的项
            },
            //添加
            addPosition() {
                if (this.pos.name) {//有输入值才去请求添加
                    this.postRequest("/system/basic/pos/", this.pos).then(resp => {
                        if (resp) {
                            this.initPositions();
                            this.pos.name = '';
                        }
                    })
                } else {
                    this.$message.error('职位名称不可以为空');
                }
            },

            //编辑
            showEditView(index, data) {
                Object.assign(this.updatePos, data);//将数据拷贝this.updatePos()，深拷贝。改变编辑的值，原数据不会改变
                this.dialogVisible = true;
            },
            doUpdate() {
                this.putRequest("/system/basic/pos/", this.updatePos).then(resp => {
                    if (resp) {
                        this.initPositions();
                        this.updatePos.name = '';
                        this.dialogVisible = false;
                    }
                })
            },
            //删除
            handleDelete(index, data) {
                this.$confirm('此操作将永久删除【' + data.name + '】职位, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    this.deleteRequest("/system/basic/pos/" + data.id).then(resp => {
                        if (resp) {
                            this.initPositions();
                        }
                    })
                }).catch(() => {
                    this.$message({
                        type: 'info',
                        message: '已取消删除'
                    });
                });
            },
            //初始化表格
            initPositions() {
                this.loading = true;
                this.getRequest("/system/basic/pos/").then(resp => {
                    this.loading = false;
                    if (resp) {
                        this.positions = resp;
                    }
                })
            }
        }
    }
</script>

<style>
    .addPosInput {
        width: 295px;
        margin-right: 8px;
    }

    .updatePosInput {
        width: 200px;
        margin-left: 8px;
    }

    .posManaMain {
        margin-top: 10px;
    }
</style>
