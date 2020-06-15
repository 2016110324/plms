package yuping.liu.plms.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import yuping.liu.plms.mapper.EmployeeecMapper;
import yuping.liu.plms.model.Employeeec;
import yuping.liu.plms.model.RespPageBean;

import java.util.List;

@Service
public class EmployeeecService {
    @Autowired
    EmployeeecMapper employeeecMapper;

    public RespPageBean getAllEcByPage(Integer page, Integer size) {
        if (page != null && size != null) {
            page = (page - 1) * size;
        }
        List<Employeeec> list = employeeecMapper.getAllEcByPage(page, size);

        RespPageBean respPageBean = new RespPageBean();
        respPageBean.setData(list);
        respPageBean.setTotal(employeeecMapper.getTotal(null));
        return respPageBean;
    }

    public int addEc(Employeeec employeeec) {
        return employeeecMapper.insertSelective(employeeec);
    }

    public int deleteEcById(Integer id) {
        return employeeecMapper.deleteByPrimaryKey(id);
    }

    public int updateEmpEcById(Employeeec employeeec) {
        return employeeecMapper.updateByPrimaryKeySelective(employeeec);
    }
}
