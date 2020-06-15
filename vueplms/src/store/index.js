//index.js导出vuex所有配置
import Vue from 'vue'
import Vuex from 'vuex'



Vue.use(Vuex)

const now = new Date();

const store = new Vuex.Store({
    state: {//相当于定义变量
        routes: [],//路由数组，从服务端加载的菜单项都放到这个数组里
    },
    mutations: {//类似于事件，变更状态
        /*你不能直接调用一个 mutation handler。这个选项更像是事件注册：“当触发一个类型为 increment 的 mutation 时，调用此函数。”
        要唤醒一个 mutation handler，你需要以相应的 type 调用 store.commit 方法：*/

        initRoutes(state, data) {//调用时候只用传一个参数data
            state.routes = data;
        },
     },
    actions: {//提交mutation,而不是直接变更状态，可包含异步操作
    }
})


export default store;
