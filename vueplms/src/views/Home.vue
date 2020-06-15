<template>
    <div>
        <el-container>
            <el-header class="homeHeader">
                <div class="title">人事劳资管理信息系统</div>
                <el-dropdown class="userInfo" @command="commandHandler"><!--command是elementui里面的dropdown Events-->
                  <span class="el-dropdown-link">
                    {{user.name}}<i> <img :src="user.userface" alt=""></i>
                  </span>
                    <el-dropdown-menu slot="dropdown">
                        <el-dropdown-item command="userInfo">个人中心</el-dropdown-item><!--给每个dropitem设置command属性作为标识--->
                        <el-dropdown-item command="setting">设置</el-dropdown-item>
                        <el-dropdown-item divided command="logout">注销登陆</el-dropdown-item>
                    </el-dropdown-menu>
                </el-dropdown>
            </el-header>
            <el-container>
                <el-aside width="200px">
                    <el-menu router unique-opened>
                        <el-submenu :index="index+''" v-for="(item,index) in routes" v-if="!item.hidden" :key="index"><!--这个routes就是计算属性里面的routes--><!--this.$router.options.routes拿到的就是router/index.js中的数组  v-if设置当hidden为false时才渲染-->
                            <template slot="title" >
                                <i :class="item.iconCls" style="color: #0aaeff;margin: 5px"></i>
                                <span>{{item.name}}</span>
                            </template>
                            <el-menu-item :index="child.path" v-for="(child,indexj) in item.children" :key="indexj">{{child.name}}</el-menu-item><!--index设置成想要去的路径，它是一个唯一标识-->

                        </el-submenu>

                    </el-menu>
                </el-aside>
                <el-main class="main">
                    <el-breadcrumb style="padding-bottom: 10px" separator-class="el-icon-arrow-right" v-if="this.$router.currentRoute.path !='/home'">
                        <el-breadcrumb-item :to="{ path: '/home' }">首页</el-breadcrumb-item>
                        <el-breadcrumb-item>{{this.$router.currentRoute.name}}</el-breadcrumb-item><!--当前路由对象的name属性-->

                    </el-breadcrumb>
                    <div class="homeWelcome" v-if="this.$router.currentRoute.path =='/home'">
                        欢迎使用人事劳资管理信息系统!
                    </div>
                    <router-view />

                </el-main>
            </el-container>
        </el-container>
    </div>

</template>

<script>
    export default {
        name: "Home",
        data(){
            return{
                user:JSON.parse(window.sessionStorage.getItem('user'))/*因为window....这样得到的是字符串而不是对象，所以用JSON.parse将他转为对象方便操作*/

            }
        },
        computed:{
            routes(){
                return this.$store.state.routes;////this.$store获取到store
            }

        },
        methods:{

            commandHandler(cmd){
                if(cmd == 'logout'){/*点击的是注销，做以下处理*/
                    this.$confirm('此操作将注销登陆, 是否继续?', '提示', {
                        confirmButtonText: '确定',
                        cancelButtonText: '取消',
                        type: 'warning'
                    }).then(() => {
                        this.getRequest('/logout');
                        window.sessionStorage.removeItem('user')/*清空登陆数据*/
                        this.$store.commit('initRoutes',[])
                        this.$router.replace('/')/*跳转到登录页*/

                    }).catch(() => {
                        this.$message({
                            type: 'info',
                            message: '操作取消'
                        });
                    });

                }

            }

        }
    }
</script>

<style scoped>
    .homeHeader{
        background-color: #029dff;
        display: flex;
        align-items: center;/*富裕空间（侧轴上的）：两边   （垂直居中）*/
        justify-content: space-between;/*富裕空间（主轴上的：项目之间  */
        padding: 0px 15px;/*防止两边离太久*/
        box-sizing: border-box;/*padding在框的里面*/

    }
    .homeHeader .title{
        font: 24px "华文行楷";
        color: white;
    }
    .userInfo{
        cursor: pointer;
    }
    .el-dropdown-link img{
        width: 42px;
        height: 42px;
        border-radius: 21px;
        margin-left: 8px;
    }
    .el-dropdown-link{
        display: flex;
        align-items: center;
    }

    .homeWelcome{
        text-align: center;
        font: 30px 华文行楷;
        color: #1295ff;
        padding-top: 50px;
    }




</style>
