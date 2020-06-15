(window["webpackJsonp"]=window["webpackJsonp"]||[]).push([["chunk-3fe79b5a"],{"2bc5":function(t,e,a){"use strict";a.r(e);var i=function(){var t=this,e=t.$createElement,a=t._self._c||e;return a("div",[a("div",{staticStyle:{display:"flex","justify-content":"space-between"}},[a("el-button",{attrs:{icon:"el-icon-plus",type:"primary"},on:{click:t.showAddSalaryView}},[t._v("添加工资账套")]),a("el-button",{attrs:{icon:"el-icon-refresh",type:"success"},on:{click:t.initSalaries}})],1),a("div",{staticStyle:{"margin-top":"10px"}},[a("el-table",{attrs:{data:t.salaries,border:"",stripe:""}},[a("el-table-column",{attrs:{type:"selection",width:"55"}}),a("el-table-column",{attrs:{width:"120",prop:"name",label:"账套名称"}}),a("el-table-column",{attrs:{width:"70",prop:"basicSalary",label:"基本工资"}}),a("el-table-column",{attrs:{width:"70",prop:"trafficSalary",label:"交通补助"}}),a("el-table-column",{attrs:{width:"70",prop:"lunchSalary",label:"午餐补助"}}),a("el-table-column",{attrs:{width:"70",prop:"bonus",label:"奖金"}}),a("el-table-column",{attrs:{width:"100",prop:"createDate",label:"启用时间"}}),a("el-table-column",{attrs:{label:"操作"},scopedSlots:t._u([{key:"default",fn:function(e){return[a("el-button",{on:{click:function(a){return t.showEditSalaryView(e.row)}}},[t._v("编辑")]),a("el-button",{attrs:{type:"danger"},on:{click:function(a){return t.deleteSalary(e.row)}}},[t._v("删除")])]}}])})],1)],1),a("div",{staticStyle:{display:"flex","justify-content":"flex-end"}},[a("el-pagination",{attrs:{background:"","page-sizes":[6,10,20,30],"page-size":6,layout:"sizes, prev, pager, next, jumper, ->, total, slot",total:t.total},on:{"size-change":t.sizeChange,"current-change":t.currentChange}})],1),a("el-dialog",{attrs:{title:t.dialogTitle,visible:t.dialogVisible,width:"50%"},on:{"update:visible":function(e){t.dialogVisible=e}}},[a("div",{staticStyle:{display:"flex","justify-content":"space-around","align-items":"center"}},[a("el-steps",{attrs:{direction:"vertical",active:t.activeItemIndex}},t._l(t.salaryItemName,(function(t,e){return a("el-step",{key:e,attrs:{title:t}})})),1),t._l(t.salary,(function(e,i,l){return a("el-input",{directives:[{name:"show",rawName:"v-show",value:t.activeItemIndex==l,expression:"activeItemIndex==index"}],key:l,staticStyle:{width:"200px"},attrs:{placeholder:"请输入"+t.salaryItemName[l]+"..."},model:{value:t.salary[i],callback:function(e){t.$set(t.salary,i,e)},expression:"salary[title]"}})}))],2),a("span",{staticClass:"dialog-footer",attrs:{slot:"footer"},slot:"footer"},[a("el-button",{on:{click:t.preStep}},[t._v(t._s(4==t.activeItemIndex?"取消":"上一步"))]),a("el-button",{attrs:{type:"primary"},on:{click:t.nextStep}},[t._v(t._s(4==t.activeItemIndex?"完成":"下一步"))])],1)])],1)},l=[],n=(a("b0c0"),{name:"SalSob",data:function(){return{total:0,currentPage:1,currentSize:6,page:1,size:6,dialogVisible:!1,dialogTitle:"添加工资账套",salaries:[],activeItemIndex:0,salaryItemName:["基本工资","交通补助","午餐补助","奖金","账套名称"],salary:{basicSalary:0,trafficSalary:0,lunchSalary:0,bonus:0,name:""}}},mounted:function(){this.initSalaries()},methods:{sizeChange:function(t){this.currentSize=t,this.initSalaries()},currentChange:function(t){this.currentPage=t,this.initSalaries()},showEditSalaryView:function(t){this.activeItemIndex=0,this.dialogTitle="修改工资账套",this.dialogVisible=!0,this.salary.basicSalary=t.basicSalary,this.salary.trafficSalary=t.trafficSalary,this.salary.lunchSalary=t.lunchSalary,this.salary.bonus=t.bonus,this.salary.name=t.name,this.salary.id=t.id},deleteSalary:function(t){var e=this;this.$confirm("此操作将删除【"+t.name+"】账套，是否继续？","提示",{cancelButtonText:"取消",confirmButtonText:"确定"}).then((function(){e.deleteRequest("/salary/sob/"+t.id).then((function(t){t&&e.initSalaries()}))})).catch((function(){e.$message.info("取消删除!")}))},preStep:function(){0!=this.activeItemIndex&&(5!=this.activeItemIndex?this.activeItemIndex--:this.dialogVisible=!1)},nextStep:function(){var t=this;4!=this.activeItemIndex?this.activeItemIndex++:this.salary.id?this.putRequest("/salary/sob/",this.salary).then((function(e){e&&(t.initSalaries(),t.dialogVisible=!1)})):this.postRequest("/salary/sob/",this.salary).then((function(e){e&&(t.initSalaries(),t.dialogVisible=!1)}))},showAddSalaryView:function(){this.salary={basicSalary:0,trafficSalary:0,lunchSalary:0,bonus:0,name:0},this.dialogTitle="添加工资账套",this.activeItemIndex=0,this.dialogVisible=!0},initSalaries:function(){var t=this;this.getRequest("/salary/sob/?page="+this.currentPage+"&size="+this.currentSize).then((function(e){e&&(t.salaries=e.data,t.total=e.total)}))}}}),r=n,s=a("2877"),o=Object(s["a"])(r,i,l,!1,null,"b708d940",null);e["default"]=o.exports},"6ac98":function(t,e,a){"use strict";a.r(e);var i=function(){var t=this,e=t.$createElement,a=t._self._c||e;return a("div",[a("div",[a("el-table",{attrs:{data:t.emps,border:"",stripe:"",size:"mini"}},[a("el-table-column",{attrs:{type:"selection",align:"left",width:"55"}}),a("el-table-column",{attrs:{prop:"name",label:"姓名",fixed:"",width:"120",align:"left"}}),a("el-table-column",{attrs:{prop:"workID",label:"工号",width:"120",align:"left"}}),a("el-table-column",{attrs:{prop:"email",label:"电子邮件",width:"200",align:"left"}}),a("el-table-column",{attrs:{prop:"phone",label:"电话号码",width:"120",align:"left"}}),a("el-table-column",{attrs:{prop:"department.name",label:"所属部门",width:"130",align:"left"}}),a("el-table-column",{attrs:{label:"所属部门",align:"center"},scopedSlots:t._u([{key:"default",fn:function(e){return[e.row.salary?a("el-tooltip",{attrs:{placement:"right"}},[a("div",{attrs:{slot:"content"},slot:"content"},[a("table",[a("tr",[a("td",[t._v("基本工资")]),a("td",[t._v(t._s(e.row.salary.basicSalary))])]),a("tr",[a("td",[t._v("交通补助")]),a("td",[t._v(t._s(e.row.salary.trafficSalary))])]),a("tr",[a("td",[t._v("午餐补助")]),a("td",[t._v(t._s(e.row.salary.lunchSalary))])]),a("tr",[a("td",[t._v("奖金")]),a("td",[t._v(t._s(e.row.salary.bonus))])]),a("tr",[a("td",[t._v("启用时间")]),a("td",[t._v(t._s(e.row.salary.createDate))])]),a("hr"),a("tr",[a("td",[t._v("工资")]),a("td",[t._v(t._s(e.row.salary.allSalary))])])])]),a("el-tag",[t._v(t._s(e.row.salary.name))])],1):a("el-tag",[t._v("暂未设置")])]}}])}),a("el-table-column",{attrs:{width:"130",fixed:"right",label:"操作",align:"center"},scopedSlots:t._u([{key:"default",fn:function(e){return[a("el-popover",{attrs:{placement:"left",title:"修改工资账套",width:"80px",trigger:"click"},on:{show:function(a){return t.showPop(e.row.salary)},hide:function(a){return t.hidePop(e.row)}}},[a("div",[a("el-select",{attrs:{placeholder:"请选择",size:"mini"},model:{value:t.currentSalary,callback:function(e){t.currentSalary=e},expression:"currentSalary"}},t._l(t.salaries,(function(t){return a("el-option",{key:t.id,attrs:{label:t.name,value:t.id}})})),1)],1),a("el-button",{attrs:{slot:"reference",size:"mini",type:"danger"},slot:"reference"},[t._v("修改工资账套")])],1)]}}])})],1),a("div",{staticStyle:{display:"flex","justify-content":"flex-end"}},[a("el-pagination",{attrs:{background:"",layout:"sizes, prev, pager, next, jumper, ->, total, slot",total:t.total},on:{"size-change":t.sizeChange,"current-change":t.currentChange}})],1)],1)])},l=[],n={name:"SalSobCfg",data:function(){return{emps:[],total:0,currentPage:1,currentSize:10,currentSalary:null,salaries:[]}},mounted:function(){this.initEmps(),this.initSalaries()},methods:{sizeChange:function(t){this.currentSize=t,this.initEmps()},currentChange:function(t){this.currentPage=t,this.initEmps()},hidePop:function(t){var e=this;this.currentSalary&&this.putRequest("/salary/sobcfg/?eid="+t.id+"&sid="+this.currentSalary).then((function(t){t&&e.initEmps()}))},showPop:function(t){this.currentSalary=t?t.id:null},initSalaries:function(){var t=this;this.getRequest("/salary/sob/").then((function(e){e&&(t.salaries=e.data)}))},initEmps:function(){var t=this;this.getRequest("/salary/sobcfg/?page="+this.currentPage+"&size="+this.currentSize).then((function(e){e&&(t.emps=e.data,t.total=e.total)}))}}},r=n,s=a("2877"),o=Object(s["a"])(r,i,l,!1,null,"a0fc0eda",null);e["default"]=o.exports},d7e6:function(t,e,a){var i={"./SalSob.vue":"2bc5","./SalSobCfg.vue":"6ac98"};function l(t){var e=n(t);return a(e)}function n(t){if(!a.o(i,t)){var e=new Error("Cannot find module '"+t+"'");throw e.code="MODULE_NOT_FOUND",e}return i[t]}l.keys=function(){return Object.keys(i)},l.resolve=n,t.exports=l,l.id="d7e6"}}]);
//# sourceMappingURL=chunk-3fe79b5a.3e748ea0.js.map