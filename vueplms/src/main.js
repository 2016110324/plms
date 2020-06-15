//webpack入口文件
/*引入全局vue对象，App组件，和vue router配置*/
import Vue from 'vue'
import App from './App.vue'

import router from './router' /*原本./router/index.js,js可省略，index也可以省略掉*/

import store from './store'
import 'font-awesome/css/font-awesome.min.css'
/*要使用elemnetui，先通过npm i element-ui –S 命令安装elemtui到生产环境，
* 然后import引入到项目*/

import ElementUI, {Message} from 'element-ui'

import 'element-ui/lib/theme-chalk/index.css'
import {postKeyValueRequest} from "./utils/api";
import {postRequest} from "./utils/api";
import {putRequest} from "./utils/api";
import {getRequest} from "./utils/api";
import {deleteRequest} from "./utils/api";



import {initMenu} from "./utils/menus";



import Router from 'vue-router'

const originalPush = Router.prototype.push
Router.prototype.push = function push(location, onResolve, onReject) {
  if (onResolve || onReject) return originalPush.call(this, location, onResolve, onReject)
  return originalPush.call(this, location).catch(err => err)
}
Vue.use(ElementUI);
Vue.config.productionTip = false
Vue.prototype.postKeyValueRequest=postKeyValueRequest
Vue.prototype.postRequest=postRequest
Vue.prototype.putRequest=putRequest
Vue.prototype.getRequest=getRequest
Vue.prototype.deleteRequest=deleteRequest

/*vue-router的全局前置导航守卫
作为一个浏览器应用，数据保存在vuex中实际上就是保存在内存里面。如果用户按了f5或者刷新按钮，所有菜单就没了。所以我们就是要保证按了刷新菜单还在。
要在每个页面按都能保证,所以我们使用路由导航守卫。

to 目标路由
from 源路由
next 跳转到下一个路由
*/
router.beforeEach((to,from,next) =>{//(有点像后端的过滤器)
  /*做判断*/
  if (to.path == '/'){
    next();//如果是登陆页面直接去
  } else{
    if (window.sessionStorage.getItem("user")){
      initMenu(router,store);//初始化菜单
      next();
    } else{
      Message.error("尚未登陆，请登陆");
      next('/?redirect=' +to.path);//重定向到to.path
    }
  }
})

/*
对vue项目的理解：
* 1.整个项目是一个vue的实例
*2.每个页面或者每个组件是一个vue component的实例
*3.Vue实例是Vue应用的启动器，Vue组件是Vue实例的扩展。

* Vue 的模块机制
　　Vue 是通过 webpack 实现的模块化，因此可以使用 import 来引入模块。
* */
new Vue({/*创建一个Vue实例  Vue是一个Vue.js提供的构造函数*/
  router,//router 实例注入到 vue 根实例
  store,//注册到实例
  render: h => h(App) /*渲染App组件，不用注册*/
}).$mount('#app')/*把App挂载到选择器为#app上面去(替换index.html中div元素)*/



//对于render的深入理解
/*
* 1.首先需要了解这是 es 6 的语法，表示 Vue 实例选项对象的 render 方法作为一个函数，接受传入的参数 h 函数，返回 h(App) 的函数调用结果。

* 2.其次，Vue 在创建 Vue 实例时，通过调用 render 方法来渲染实例的 DOM 树。

* 3.最后，Vue 在调用 render 方法时，会传入一个 createElement 函数作为参数，也就是这里的 h 的实参是 createElement 函数，
然后 createElement 会以 APP 为参数进行调用
*
* 官方文档代码：
 render: function (createElement) {
    return createElement(
      'h' + this.level,   // tag name 标签名称
       this.$slots.default // 子组件中的阵列
     )
   }
* */
