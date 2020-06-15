package yuping.liu.plms.mapper;

import org.apache.ibatis.annotations.Param;
import yuping.liu.plms.model.MenuRole;

public interface MenuRoleMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(MenuRole record);

    int insertSelective(MenuRole record);

    MenuRole selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(MenuRole record);

    int updateByPrimaryKey(MenuRole record);

    //权限组
    Integer insertRecord(@Param("rid") Integer rid,@Param("mids") Integer[] mids);

    void deleteByRid(Integer rid);
}