package yuping.liu.plms.mapper;

import yuping.liu.plms.model.Hr;
import yuping.liu.plms.model.Role;

import java.util.List;

public interface HrMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Hr record);

    int insertSelective(Hr record);

    Hr selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Hr record);

    int updateByPrimaryKey(Hr record);

    Hr loadUserByUsername(String username);/*创建这个方法才可以直接使用在HrService.java里面*/

    List<Role> getHrRolesById(Integer id);

    List<Hr> getAllHrs(Integer id, String keywords);

    List<Hr> getAllHrsExceptCurrentHr(Integer id);
}