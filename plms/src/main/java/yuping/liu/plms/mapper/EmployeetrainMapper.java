package yuping.liu.plms.mapper;

import org.apache.ibatis.annotations.Param;
import yuping.liu.plms.model.Employeetrain;

import java.util.List;

public interface EmployeetrainMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Employeetrain record);

    int insertSelective(Employeetrain record);

    Employeetrain selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Employeetrain record);

    int updateByPrimaryKey(Employeetrain record);

    List<Employeetrain> getAllTrainByPage(@Param("page") Integer page,@Param("size") Integer size);

    Long getTotal(@Param("train") Employeetrain employeetrain);
}