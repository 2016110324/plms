<template>
    <div>

      <div class="msg">

             <div>
                 <p>年度个税信息采集</p>
                 <el-form style=" margin-top: 5px" :model="tax" :rules="rules"  ref="taxForm">
                     <i class="el-icon-cherry"> 基本信息</i>
                     <el-row class="row">
                         <el-col :span="7">
                             <el-form-item  prop="eid" size="mini" label-width="150px"  label="员工编号">
                                 <el-input v-model="tax.eid"></el-input>
                             </el-form-item>
                         </el-col>
                     </el-row>
                     <hr>
                     <i class="el-icon-cherry"> 收入及免税</i>
                     <el-row class="row">
                         <el-col :span="6">
                             <el-form-item  prop="salary" size="mini" label-width="150px"  label="收入额">
                                 <el-input    v-model.number="tax.salary"></el-input>
                             </el-form-item>
                         </el-col>
                         <el-col :span="6">
                             <el-form-item prop="otherSalary" size="mini" label-width="150px"  label="其他所得">
                                 <el-input v-model.number="tax.otherSalary"></el-input>
                             </el-form-item>
                         </el-col>
                     </el-row>
                     <hr>

                     <i class="el-icon-cherry"> 扣除及减除</i>
                     <el-row class="row">
                         <el-col :span="6" >


                             <el-form-item prop="insurance" size="mini" label-width="150px"  label="五险一金">
                                 <el-input  v-model.number="tax.insurance"></el-input>
                             </el-form-item>


                         </el-col>
                         <el-col :span="6">
                             <el-form-item prop="otherDeduct" size="mini" label-width="150px"  label="其他扣除">
                                 <el-input v-model.number="tax.otherDeduct"></el-input>
                             </el-form-item>
                         </el-col>
                     </el-row>
                     <hr>
                     <el-tooltip placement="right">
                         <div slot="content">
                             应纳税额=应纳税所得额*税率-速算扣除数<br/>
                         </div>
                         <i class="el-icon-cherry  compute" > 税款计算</i>
                     </el-tooltip>


                     <el-row class="row">
                         <el-col :span="7" >
                             <el-form-item  size="mini" label-width="150px"   label="应纳税所得额">
                                 <el-input disabled v-model.number="ownSalary"></el-input>
                             </el-form-item>
                         </el-col>

                         <el-col :span="7">
                             <el-tooltip placement="bottom">
                                 <div slot="content">
                                     不超过3000元：0.03<br/>
                                     超过3000至12000元的部分：0.1 <br>
                                     超过12000至25000元的部分：0.2 <br>
                                     超过25000至35000元的部分：0.25 <br>
                                     超过35000至55000元的部分：0.3 <br>
                                     超过55000至80000元的部分：0.35 <br>
                                     超过80000元的部分：0.45
                                 </div>
                                 <el-form-item  size="mini"   label-width="150px"  label="税率">
                                     <el-input disabled v-model.number="rate"></el-input>
                                 </el-form-item>
                             </el-tooltip>

                         </el-col>

                         <el-col :span="7">
                             <el-tooltip placement="top">
                                 <div slot="content">
                                     第1级数：0 <br>
                                     第2级数：3000*(0.1-0.03) <br>
                                     第3级数：12000*(0.2-0.1) <br>
                                     第4级数：25000*(0.25-0.2) <br>
                                     第5级数：35000*(0.3-0.25) <br>
                                     第6级数：55000*(0.35-0.3) <br>
                                     第7级数：80000*（0.45-0.35）<br>

                                 </div>
                                 <el-form-item size="mini"  label-width="150px"  label="速算扣除数">
                                     <el-input disabled v-model.number="deduction"></el-input>
                                 </el-form-item>
                             </el-tooltip>

                         </el-col>
                     </el-row>
                     <el-row class="row">
                         <el-col :span="6">
                             <el-form-item prop="taxPay" label-width="150px"  label="应纳税额">
                                 <el-input  disabled v-model.number="payTax"></el-input>
                             </el-form-item>
                         </el-col>
                     </el-row>
                 </el-form>
             </div>
          <div class="sub">
              <el-button @click="dialogVisible = false">取 消</el-button>
              <el-button type="primary" @click="doAndTax">确 定</el-button>
          </div>


          </div>





    </div>
</template>


<script>
    export default {
        name: "ICCollection",
        data() {
            return {
                s:0,//应纳税所得额
                r:0,//税率
                deduction:"",//速算扣除数

                tax: {
                    eid: "00000001",
                    salary: 0,
                    otherSalary: 0,
                    insurance: 5000,
                    otherDeduct:0,
                    taxPay: 0,
                    name:"",
                    idCard:""
                },
                rules: {
                    name: [{required: true, message: '请输入用户名', trigger: 'blur'}],
                    idCard: [{required: true, message: '请输入身份证号码', trigger: 'blur'}, {
                        pattern: /(^[1-9]\d{5}(18|19|([23]\d))\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\d{3}[0-9Xx]$)|(^[1-9]\d{5}\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\d{2}$)/,
                        message: '身份证号码格式不正确',
                        trigger: 'blur'
                    }],
                    eid: [{required: true, message: '请输入员工号', trigger: 'blur'}],
                    salary: [{required: true, message: '请输入工资',type:'number', trigger: 'blur'}],
                    otherSalary:[{required: true, message: '请输入其他所得额',type:'number',  trigger: 'blur'}],
                    insurance: [{required: true, message: '请输入五险一金额',type:'number',  trigger: 'blur'}],
                    otherDeduct:[{required: true, message: '请输入其他扣除额',type:'number',  trigger: 'blur'}],
                }

            }
        },

        methods:{
            emptyTax(){
                tax={
                    eid: "",
                    salary: 0,
                    otherSalary: 0,
                    insurance: 0,
                    otherDeduct:0,
                    threshold: 0,
                    taxPay: 0,

                }
            },
            doAndTax(){
                this.$refs['taxForm'].validate(valid => {
                    if (valid) {
                        this.postRequest("ic/collection/", this.tax).then(resp => {
                            if (resp) {
                            }
                        })
                    }
                })
            },
        },
        computed:{
           ownSalary(){//应纳税所得额
               this.s=this.tax.salary+this.tax.otherSalary-this.tax.insurance-this.tax.otherDeduct;
               return this.tax.salary+this.tax.otherSalary-this.tax.insurance-this.tax.otherDeduct;
           },
           rate(){//税率
               if(this.s <0){
                   this.r=0;
                   this.deduction = 0
                   return 0;
               }
               if(this.s < 3000  ){
                   this.r=0.03;
                   this.deduction = 0;
                   return 0.03;
               }else if (this.s <12000){
                   this.deduction = 210
                   this.r = 0.1;
                   return 0.1
               }else if(this.s  <25000){
                   this.deduction = 1410
                   this.r=0.2
                   return 0.2
               }else if(this.s <35000){
                   this.deduction = 2660
                   this.r=0.25
                   return 0.25
               }else if(this.s <55000 ){
                   this.deduction = 4410
                   this.r=0.3
                   return 0.3
               } else if(this.s  < 80000 ){
                   this.deduction = 7160
                   this.r=0.35
                   return 0.35
               }else{
                   this.deduction = 15160
                   this.r=0.45
                   return 0.45
               }
           },
           payTax(){//应纳税额
               console.log(this.s,this.r,this.deduction)
               this.tax.taxPay = this.s * this.r -this.deduction ;
               return this.s * this.r -this.deduction ;//年度应纳税额=应纳税所得额*税率-年度速算扣除数
           }

        }
    }
</script>

<style scoped>
    .row{

        margin-top: 20px;
    }
    .msg{
        margin: auto;
        width:900px;
        height:590px;
        padding: 2px 10px;
        box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.2);/*X偏移，Y偏移，阴影模糊半径，阴影扩散半径，和阴影颜色*/

    }
    .sub{
        float:right;
    }
    p{
        text-align: center;
        color: gray;
    }



</style>
