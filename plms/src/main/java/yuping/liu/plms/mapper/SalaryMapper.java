package yuping.liu.plms.mapper;

import org.apache.ibatis.annotations.Param;
import yuping.liu.plms.model.Salary;

import java.util.List;

public interface SalaryMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Salary record);

    int insertSelective(Salary record);

    Salary selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Salary record);

    int updateByPrimaryKey(Salary record);


    List<Salary> getAllSalariesByPage(@Param("page") Integer page,@Param("size") Integer size);

    Long getTotal(@Param("salary")Salary salary);

}