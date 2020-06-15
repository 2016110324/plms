/*nodejs里面的请求转发的代理*/
let proxyObj = {};
proxyObj['/']={
    ws:false,
    target:'http://localhost:8081',/*目标转发地址*/
    changeOrigin: true,
    pathRewrite:{
        '^/':''
    }
}
module.exports={
    devServer:{
        host:'localhost',
        port:8080,
        proxy:proxyObj
    }
}
