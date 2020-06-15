package yuping.liu.plms.model;

import java.util.List;
//用于保存分页查询的结果，因为分页查询发很多地方都可能用到，
public class RespPageBean {
    private Long total;
    private List<?> data;

    public Long getTotal() {
        return total;
    }

    public void setTotal(Long total) {
        this.total = total;
    }

    public List<?> getData() {
        return data;
    }

    public void setData(List<?> data) {
        this.data = data;
    }
}
