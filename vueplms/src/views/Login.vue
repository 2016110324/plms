<template>
    <div id= "bac">
        <!-- 强制数据绑定 v-bind:xxx="yyy" 可以简写为:xxx="yyy" 功能：指定变化的属性值
             绑定事件监听 v-on:click="xxx"  简写为@click="xxx" 功能：绑定事件的回调函数
             双括号表达式 {{}} 功能：向页面输出数据
             双向数据绑定 v-model="xxx"  (表单数据绑定) 它在内部为不同输入元素使用不同的属性并抛出不同事件


vue里很少查找组件，自定义的方法ref。这里相当于表单的名字。
         -->
        <el-header>
            <span class="title">人事劳资管理信息系统</span>
        </el-header>


                <el-form
                        :rules="rules"
                        ref="loginForm"
                        v-loading="loading"
                        element-loading-text="正在登陆..."
                        element-loading-spinner="el-icon-loading"
                        element-loading-background="rgba(0, 0, 0, 0.4)"
                        :model="loginForm"
                        class="loginContainer"><!--Form 组件提供了表单验证的功能，只需要通过 rules 属性传入约定的验证规则，并将 Form-Item 的 prop 属性设置为需校验的字段名即可。-->
                    <h3 class="loginTitle">系统登陆</h3>
                    <el-form-item prop="username"><!--这里必须要给一个prop属性，才能完成表单验证-->
                        <el-input type="text" v-model="loginForm.username" auto-complete="off" placeholder="请输入用户名"></el-input>
                    </el-form-item>
                    <el-form-item prop="password">
                        <el-input type="password" v-model="loginForm.password" auto-complete="off" placeholder="请输入密码" @keydown.enter.native="submitLogin"></el-input>
                    </el-form-item>
                    <el-checkbox v-model="checked" class="loginRemember">记住密码</el-checkbox>
                    <el-button type="primary" style="width: 100%;" @click="submitLogin">登陆</el-button>
                </el-form>





        <el-footer style="text-align: center;font:19px 华文行楷;  color: #1295ff;">
           @copyright 四川师范大学  2016110324 刘玉萍
        </el-footer>



    </div>
</template>

<script>
/*因为在main.js中有：
import App from ‘./App.vue’
所以，我们必须在当前组件中写入export default。*/

    export default {
        name: "Login",
        data(){ // 必须写函数,相当于function data(){}
            return{
                loading:false,//设置loading加载框关闭和开启
                loginForm:{
                    username:"admin",
                    password:"123",
                },
                checked:true,
                rules:{/*form表单校验规则*/
                    username:[{required:true,message:"请输入用户名",trigger: 'blur' }], //required规则属性表示该字段必须存在于源对象被验证。trigger: 'blur' 失去焦点
                    password:[{required:true,message:"请输入密码",trigger: 'blur' }],

                },


            }
        },

        methods:{
            //操作员登陆
            submitLogin() {
                /*关于ref的介绍
                在Vue中一般很少会用到直接操作DOM，但不可避免有时候需要用到，这时我们可以通过ref和$refs这两个来实现。
                ref 被用来给元素或子组件注册引用信息， 引用信息将会注册在父组件的 $refs 对象上，
            如果是在普通的DOM元素上使用，引用指向的就是 DOM 元素，如果是在子组件上，引用就指向组件的实例。
                $refs 是一个对象，持有已注册过 ref 的所有的子组件或者dom元素。
                */
                this.$refs.loginForm.validate((valid) => {/*  this.$refs可以获取到当前页面所有的ref   上面的校验成功才执行，不成功就不执行*/
                    if (valid) {
                        this.loading=true

                        this.postKeyValueRequest('/doLogin', this.loginForm).then(resp => {
                            this.loading=false
                            if (resp) {/*保存用户数据保存在sessionstorage,关闭页面就没了*/
                                window.sessionStorage.setItem("user",JSON.stringify(resp.obj))/*转为字符串*/

                                //前置守卫保留了用户想要去的页面
                                let path = this.$route.query.redirect;
                                /*this.$router获取当前vue对象的router对象。从main.js的new实例中的router来的*/
                                this.$router.replace(path=='/' || path==undefined ?'/home' :path)/*跳转的方法。一个是push(网站里面去压，后退按钮是可用点击的),一个是replace（替换，后退按钮不可点击）.*/

                            }
                        })
                    } else {

                        this.$message.error('请输入所有字段');
                        return false;
                    }
                });
            }
        }
    }
</script>

<style scoped>


    #bac{
    background:url("../assets/bac.jpg") no-repeat;
    background-size:100% 100%;

    }
    .loginContainer{
        opacity: 0.8;
        width: 350px;
        margin: 180px auto;
        padding: 10px 35px 15px 35px;
        border-radius: 15px;
        background: white;
        box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.2);/*X偏移，Y偏移，阴影模糊半径，阴影扩散半径，和阴影颜色*/

    }
    .loginTitle{
       text-align: center;
    }
    .loginRemember{
        margin-bottom: 15px;
    }
    .title{
        display: inline-block;
        padding-top: 10px;
        font: 25px 华文行楷;
        color: #1295ff;
    }
</style>

<!--
script 标签中内容为vue组件，template标签中内容为组件的dom结构，style标签中内容为样式表
scoped属性表示作用域仅限在当前组件

export 和import是es6里用于模块化管理的两个关键字。这里export用于导出vue组件以供外部调用。
-->
