/*菜单的请求和格式化
*1.从服务端请求数据
* 2.把数据格式化成对象
*3.把数据放到router里
* */
import {getRequest} from "./api";//因为要发送请求

export const initMenu=(router,store)=>{//格式化好之后要加到router，也要在store里面保存一份
    if(store.state.routes.length>0){//正常跳转，有菜单数据,就不用请求了。按了f5就走下面的
        return;
    }
    getRequest("/system/config/menu").then(data=>{
        if (data){
            let fmtRoutes = formatRoutes(data);//格式化后的数据
            router.addRoutes(fmtRoutes);
            store.commit('initRoutes',fmtRoutes);//初始化store中的state中的routes
        }
    })
}
export const formatRoutes=(routes)=>{ //格式化
    let fmRoutes = []
    routes.forEach(router=>{//遍历routes（router就是菜单中的每一项）
        let {
            path,
            component,
            name,
            meta,
            iconcls,
            children
        } = router;//ES6对象的解构赋值。用来定义多个变量(变量名必须完全相同)。相当于path=router.path,conponents=router.components
        if (children && children instanceof Array){//排除children为null，，并且如果children是数组，就说明他有chirdren，所以还要遍历他，所以进行递归调用
          children =formatRoutes(children);  //递归调用格式化children
        }
        let fmRouter= {
            path: path,
            name: name,
            iconCls: iconcls,
            meta: meta,
            children: children,
            component(resolve) {
                if (component.startsWith('Home')){
                    require(['../views/' + component + '.vue'], resolve);//运行时动态加载component 。es5里面的require动态加载的写法。require是赋值过程
                } else if (component.startsWith('Emp')) {
                    require(['../views/emp/' + component + '.vue'], resolve);
                } else if (component.startsWith('Per')) {
                    require(['../views/per/' + component + '.vue'], resolve);
                }else if (component.startsWith('Sal')) {
                    require(['../views/sal/' + component + '.vue'], resolve);
                } else if (component.startsWith('Sys')) {
                    require(['../views/sys/' + component + '.vue'], resolve);
                }else if (component.startsWith('IC')) {
                    require(['../views/ic/' + component + '.vue'], resolve);
                }
            }
        }
        fmRoutes.push(fmRouter);

    })
    return fmRoutes;
}
