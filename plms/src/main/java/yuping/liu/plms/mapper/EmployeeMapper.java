package yuping.liu.plms.mapper;

import org.apache.ibatis.annotations.Param;
import yuping.liu.plms.model.Employee;

import java.util.Date;
import java.util.List;

public interface EmployeeMapper {


    int deleteByPrimaryKey(Integer id);

    int insert(Employee record);

    int insertSelective(Employee record);

    Employee selectByPrimaryKey(Integer  id);

    int updateByPrimaryKeySelective(Employee record);

    int updateByPrimaryKey(Employee record);


    List<Employee> getEmployeeByPage( @Param("page") Integer page, @Param("size") Integer size, @Param("emp") Employee employee, @Param("beginDateScope") Date[] beginDateScope);

    Long getTotal(@Param("emp") Employee employee,@Param("beginDateScope") Date[] beginDateScope);

    Employee getEmployeeById( Integer id);


    Integer maxWorkID();

    Integer addEmps(@Param("list") List<Employee> list);


    List<Employee> getEmployeeByPageWithSalary( @Param("page") Integer page, @Param("size") Integer size);

    Integer updateEmployeeSalaryById(@Param("eid") Integer eid, @Param("sid") Integer sid);

    List<Employee> getEmployeeByPageWithTax(@Param("page")Integer page, @Param("size") Integer size);

    List<Employee> checkLogin( @Param("workID") String workID, @Param("epwd") String epwd);


}