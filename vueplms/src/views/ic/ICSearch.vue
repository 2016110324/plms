<template>
    <div>
        <div class="content">
            <el-table
                    element-loading-text="正在加载..."
                    element-loading-spinner="el-icon-loading"
                    element-loading-background="rgba(0, 0, 0, 0.8)"
                    :data="emps" border stripe
                    style="margin-top: 2px"
                    size="medium">
                <el-table-column type="index" width="55" fixed > </el-table-column>
                <el-table-column width="90" prop="name"  label="姓名"></el-table-column>
                <el-table-column width="120" prop="workID" label="工号"></el-table-column>
                <el-table-column width="200" prop="idCard" label="身份证号"></el-table-column>
                <el-table-column width="110" prop="tax.salary" label="工资"></el-table-column>
                <el-table-column width="110" prop="tax.otherSalary" label="其他所得"></el-table-column>
                <el-table-column width="110" prop="tax.insurance" label="五险一金"></el-table-column>
                <el-table-column width="110" prop="tax.otherDeduct" label="其他扣除"></el-table-column>
                <el-table-column width="110" prop="tax.taxPay" label="应纳税额"></el-table-column>
                <el-table-column width="110" prop="tax.afterTax" label="税后工资"></el-table-column>

            </el-table>

        </div>
        <div style="display: flex;justify-content: flex-end">
            <el-pagination
                    background
                    @size-change="sizeChange"
                    @current-change="currentChange"
                    layout="sizes, prev, pager, next, jumper, ->, total, slot"
                    :total="total">
            </el-pagination>
        </div>
    </div>
</template>

<script>
    export default {
        name: "ICSearch",
        data(){
            return{
                total:0,
                emps:[],
                dialogTitle:"信息填写",
                dialogVisible:false,
                currentPage: 1,
                currentSize:10,
                currentTime:{
                },
                emp:{
                    name: "刘子陶",
                    idCard: "610122199001011256",
                    workID: "00000001",

                    tax: {
                        eid:"000001",
                        salary:90000,
                        otherSalary:2000,
                        insurance: 5000,
                        otherDeduct:0,
                        taxPay: 0,
                        afterTax:0
                    }
                }


            }
        },
        mounted(){
            this.initEmps();
        },
        methods: {

            sizeChange(size) {
                this.currentSize = size;
                this.initEmps();
            },
            currentChange(page) {
                this.currentPage = page;
                this.initEmps();
            },

            initEmps() {
                this.getRequest("ic/search/?page=" + this.currentPage + '&size=' + this.currentSize).then(resp => {
                    console.log(resp.total)
                    if (resp) {
                        this.emps = resp.data;
                        this.total = resp.total;

                    }
                })
            }

        }
    }
</script>

<style scoped>

</style>
