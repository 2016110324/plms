<template>
    <div style="width: 500px;">
        <el-input
                placeholder="请输入部门名称进行搜索..."
                prefix-icon="el-icon-search"
                v-model="filterText">
        </el-input>
<!--属性方式添加了搜索图标-->
        <!--:expand-on-click-node="false"设置点击的时候不展开-->
        <el-tree
                :data="deps"
                :props="defaultProps"
                :expand-on-click-node="false"
                :filter-node-method="filterNode"
                ref="tree">
            <span class="custom-tree-node" style="display: flex;justify-content: space-between;width: 100%;"
                  slot-scope="{ node, data }">

            <!--可以通过两种方法进行树节点内容的自定义：render-content和 scoped slot
            用 scoped slot 会传入两个参数node和data，分别表示当前节点的 Node 对象和当前节点的数据。-->
                <span>{{data.name }}</span>
            <span>

            <el-button
                  type="primary"
                  size="mini"
                  class="depBtn"
                  @click="() => showAddDepView(data)">
            添加部门
            </el-button>
            <el-button
                  type="danger"
                  size="mini"
                  class="depBtn"
                  @click="() => deleteDep(data)">
            删除部门
            </el-button>
        </span>
       </span>
        </el-tree>
        <el-dialog
                title="添加部门"
                :visible.sync="dialogVisible"
                width="30%">
            <div>
                <table>
                    <tr>
                        <td>
                            <el-tag>上级部门</el-tag>
                        </td>
                        <td>{{pname}}</td>
                    </tr>
                    <tr>
                        <td>
                            <el-tag>部门名称</el-tag>
                        </td>
                        <td>
                            <el-input size="small" v-model="dep.name" placeholder="请输入部门名称..."></el-input>
                        </td>
                    </tr>
                </table>
            </div>
            <span slot="footer" class="dialog-footer">
                <el-button @click="dialogVisible = false">取 消</el-button>
                <el-button type="primary" @click="doAddDep">确 定</el-button>
            </span>
        </el-dialog>
    </div>
</template>

<script>
    export default {
        name: "DepMana",
        data() {
            return {
                dialogVisible: false,
                filterText: '',
                dep: {//添加的对象
                    name: '',
                    parentid: -1
                },
                pname: '',//做展示
                deps: [],
                defaultProps: {
                    children: 'children',//指定子树为节点对象的某个属性值
                    label: 'name' //指定节点标签为节点对象的某个属性值
                }
            }
        },
        watch: {//监控。当filterTex这个变量发生变化的时候，这个方法就会被调用
            filterText(val) {
                this.$refs.tree.filter(val);//获取树形控件，然后调用过滤的方法 。这个方法就是变迁中配的属性:filter-node-method的值
            }
        },
        mounted() {
            this.initDeps();
        },
        methods: {
            initDep() {
                this.dep = {
                    name: '',
                    parentid: -1
                }
                this.pname = '';
            },
            addDep2Deps(deps, dep) {
                for (let i = 0; i < deps.length; i++) {
                    let d = deps[i];
                    if (d.id == dep.parentid) {
                        d.children = d.children.concat(dep);
                        if (d.children.length > 0) {
                            d.parent = true;
                        }
                        return;
                    } else {
                        this.addDep2Deps(d.children, dep);
                        this.dialogVisible = false;
                    }
                }
            },
            doAddDep() {
                if (this.dep.name == ''){
                    this.$message("请输入部门")
                    return
                }
                this.postRequest("/system/basic/department/", this.dep).then(resp => {
                    if (resp) {
                        this.addDep2Deps(this.deps, resp.obj);//把返回的obj，动态加到deps
                        this.dialogVisible = false;
                        //初始化变量
                        this.initDep();
                    }
                })
            },
            removeDepFromDeps(p,deps, id) {
                for(let i=0;i<deps.length;i++){
                    let d = deps[i];
                    if (d.id == id) {
                        deps.splice(i, 1);
                        if (deps.length == 0) {
                            p.parent = false;
                        }
                        return;
                    }else{
                        this.removeDepFromDeps(d,d.children, id);
                    }
                }
            },
            deleteDep(data) {
                if (data.parent) {
                    this.$message.error("父部门删除失败");
                } else {
                    this.$confirm('此操作将永久删除【' + data.name + '】部门, 是否继续?', '提示', {
                        confirmButtonText: '确定',
                        cancelButtonText: '取消',
                        type: 'warning'
                    }).then(() => {
                       this.deleteRequest("/system/basic/department/"+data.id).then(resp=>{
                           if (resp) {
                               this.removeDepFromDeps(null,this.deps,data.id);
                           }
                       })
                    }).catch(() => {
                        this.$message({
                            type: 'info',
                            message: '已取消删除'
                        });
                    });
                }
            },
            showAddDepView(data) {
                this.pname = data.name;
                this.dep.parentid = data.id;
                this.dialogVisible = true;
            },

            //初始化数据，（在mounted调用）
            initDeps() {
                this.getRequest("/system/basic/department/").then(resp => {
                    if (resp) {
                        this.deps = resp;
                    }
                })
            },
            //
            filterNode(value, data) {//value就是传进来的最新的 filterText值，data是JSON数组中的每一项（是一个json对象）
                if (!value) return true;//就是当前data留的
                return data.name.indexOf(value) !== -1;//不等于-1说明是有这个value值的，就返回true..等于-1说明value在当前data中不存在就返回false
            }
        }
    }
</script>

<style>
    .depBtn {
        padding: 2px;
    }
</style>
