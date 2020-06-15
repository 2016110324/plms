/*封装网络请求*/
import axios from 'axios'
/*为了方便，用elementui里面的message作为消息提示（如果出错了，直接弹出提示，不通过页面）*/
import { Message} from 'element-ui'
import router from'../router'
/*主要对响应信息中异常信息的封装，使用axios的响应拦截器*/
axios.interceptors.response.use(success=>{/*这个success就是服务端返回的数据*//*http响应码为200会进入，但是进到这里也不一定成功 服务端返回的json的status：500*/
    if (success.status && success.status == 200 && success.data.status == 500){/*前面那个是http的响应码，后面的是服务端返回的json的status(业务错误返回的http为200d，http)*/
        Message.error({message:success.data.msg})/*key是message,value是在后端写的respBean中set的message展示出来*/
        return;/*返回空，在请求调用的地方拿不到数据*/
    }
    if (success.data.msg){/*如果返回由msg就在前端返回一下*/
        Message.success({message:success.data.msg})
    }
    return success.data;/*如果没有问题，就把数据返回*/

},error => {/*http响应码为非2开头状态吗，一定失败*/
    if (error.response.status ==504 ||  error.response.status==404){
        Message.error({message:"服务器被吃了"})
    } else if(error.response.status == 403){
        Message.error({message:"权限不足，请联系管理员"})
    } else if(error.response.status == 401){
        Message.error({message:"尚未登陆，请登陆"})
        router.replace('/')//回到登录页
    }else{
        if (error.response.data.msg){
            Message.error({message:error.response.data.msg})
        } else{
            Message.error({message:"未知错误"})
        }
    }
    return;

})


/*封装请求*/
let base = "";/*定义一变量作为前缀如果想给请求加前缀，修改base就好了*/
export const  postKeyValueRequest = (url,params)=>{/*springSecurity登陆的请求默认使用key-value传参，不支持json(可以修改)。。以后的请求用json传参*/
    return axios({  //通过向 axios 传递相关配置来创建请求
        method: "post", // `method` 是创建请求时使用的方法
        url:`${base}${url}`, // `url` 是用于请求的服务器 URL
        data:params,/*如果只是这样写会以json的形式传，所以定义了下面的转换*/
        transformRequest:[function (data){  // `transformRequest` 允许在向服务器发送前，修改请求数据
            let ret =""
            for (let i in data){
                console.log(i)
                console.log(data[i])
                ret+=encodeURIComponent(i) +"="+ encodeURIComponent(data[i])+ "&" ;
            }
            return ret;
        }],
        headers:{// `headers` 是即将被发送的自定义请求头
            'Content-Type' :' application/x-www-form-urlencoded'
        }
    })
}

export const postRequest=(url,params)=>{/*以JSON格式传递*/
    return axios({
        method:'post',
        url:`${base}${url}`,
        data:params
    })
}
export const putRequest=(url,params)=>{/*以JSON格式传递*/
    return axios({
        method:'put',
        url:`${base}${url}`,
        data:params
    })
}

/*get和delete没有请求问题，放在地址栏就好*/
export const getRequest=(url,params)=>{/*以JSON格式传递*/
    return axios({
        method:'get',
        url:`${base}${url}`,
        data:params
    })
}
export const deleteRequest=(url,params)=>{/*以JSON格式传递*/
    return axios({
        method:'delete',
        url:`${base}${url}`,
        data:params
    })
}
