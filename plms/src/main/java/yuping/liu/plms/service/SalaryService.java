package yuping.liu.plms.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import yuping.liu.plms.mapper.SalaryMapper;
import yuping.liu.plms.model.RespPageBean;
import yuping.liu.plms.model.Salary;

import java.util.Date;
import java.util.List;

@Service
public class SalaryService {
    @Autowired
    SalaryMapper salaryMapper;

    public RespPageBean getAllSalariesByPage(Integer page, Integer size) {
        if (page != null && size != null) {
            page = (page - 1) * size;
        }
        List<Salary> list =salaryMapper.getAllSalariesByPage(page, size);

        RespPageBean respPageBean = new RespPageBean();
        respPageBean.setData(list);
        respPageBean.setTotal(salaryMapper.getTotal(null));
        return respPageBean;
    }
    public Integer addSalary(Salary salary) {
        salary.setCreateDate(new Date());
        salary.setAllSalary();
        return salaryMapper.insertSelective(salary);
    }

    public Integer deleteSalaryById(Integer id) {
        return salaryMapper.deleteByPrimaryKey(id);
    }

    public Integer updateSalaryById(Salary salary) {

        salary.setAllSalary();


        return salaryMapper.updateByPrimaryKeySelective(salary);
    }

}
