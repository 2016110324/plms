<!--根组件-->
<template>
  <div id="app">
    <router-view/>
    <!--
    router-view动态挂载路由匹配到的视图组件  rouer-link默认被渲染成一个a标签，to属性指定跳转链接
    相当于一个占位符至于他要显示什么，就要看他的路径是什么(他是不确定的，根据地址栏来显示），路径定义在路由表router/index.js.默认是/-->
  </div>
</template>

<style>

</style>
