package yuping.liu.plms.mapper;

import org.apache.ibatis.annotations.Param;
import yuping.liu.plms.model.Employeeec;

import java.util.List;

public interface EmployeeecMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Employeeec record);

    int insertSelective(Employeeec record);

    Employeeec selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Employeeec record);

    int updateByPrimaryKey(Employeeec record);

    List<Employeeec> getAllEcByPage( @Param("page") Integer page, @Param("size") Integer size);

    Long getTotal(@Param("ec") Employeeec employeeec);

}