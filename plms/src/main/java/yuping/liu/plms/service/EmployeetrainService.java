package yuping.liu.plms.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import yuping.liu.plms.mapper.EmployeetrainMapper;
import yuping.liu.plms.model.Employeetrain;
import yuping.liu.plms.model.RespPageBean;

import java.util.List;

@Service
public class EmployeetrainService {
    @Autowired
    EmployeetrainMapper employeetrainMapper;
    public RespPageBean getAllTrainByPage(Integer page, Integer size) {
        if (page != null && size != null) {
            page = (page - 1) * size;
        }
        List<Employeetrain> list = employeetrainMapper.getAllTrainByPage(page, size);

        RespPageBean respPageBean = new RespPageBean();
        respPageBean.setData(list);
        respPageBean.setTotal(employeetrainMapper.getTotal(null));
        return respPageBean;
    }
    public int addEmpTrain(Employeetrain employeetrain) {
        return employeetrainMapper.insertSelective(employeetrain);
    }

    public int deleteEmpTrainById(Integer id) {
        return employeetrainMapper.deleteByPrimaryKey(id);
    }

    public int updateEmpTrainById(Employeetrain employeetrain) {
        return  employeetrainMapper.updateByPrimaryKeySelective(employeetrain);
    }
}
