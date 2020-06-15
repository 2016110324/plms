package yuping.liu.plms.model;

public class Tax {
    private Integer id;
    private String eid;
    private Integer salary;
    private Integer otherSalary ;
    private Integer insurance;

    private double taxPay;
    private Integer otherDeduct;
    private double afterTax;

    public Double getAfterTax() {
        return afterTax;
    }

    public void setAfterTax() {
        this.afterTax = this.salary+this.otherSalary-this.insurance-this.otherDeduct-this.taxPay;
    }

    public Integer getOtherDeduct() {
        return otherDeduct;
    }

    public void setOtherDeduct(Integer otherDeduct) {
        this.otherDeduct = otherDeduct;
    }

    public Integer getSalary() {
        return salary;
    }

    public double getTaxPay() {
        return taxPay;
    }

    public void setSalary(Integer salary) {
        this.salary = salary;
    }

    public Integer getOtherSalary() {
        return otherSalary;
    }

    public void setOtherSalary(Integer otherSalary) {
        this.otherSalary = otherSalary;
    }

    public void setTaxPay(double taxPay) {
        this.taxPay = taxPay;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String  getEid() {
        return eid;
    }

    public void setEid(String eid) {
        this.eid = eid;
    }

    public Integer getInsurance() {
        return insurance;
    }

    public void setInsurance(Integer insurance) {
        this.insurance = insurance;
    }



}
