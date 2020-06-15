//index.js导出路由配置
import Vue from 'vue'
import VueRouter from 'vue-router'
import Login from '../views/Login.vue'
import Home from '../views/Home.vue'


Vue.use(VueRouter)

const routes = [/*
定义路由规则，每一个路由规则映射一个视图组件。
创建的路由表，定义了请求路径是什么对应哪个组件
*/
    {
        path: '/',
        name: 'Login',
        component: Login,
        hidden:true
    },
    {
        path:'/home',/*路径为home时访问这个Home组件*/
        name:'Home',
        component:Home,
        hidden:true
    },
]

/*创建vueRouter实例，并传入routes配置*/
const router = new VueRouter({
    routes
})

export default router
