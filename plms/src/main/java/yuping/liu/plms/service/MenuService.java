package yuping.liu.plms.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import yuping.liu.plms.mapper.MenuMapper;
import yuping.liu.plms.mapper.MenuRoleMapper;
import yuping.liu.plms.model.Hr;
import yuping.liu.plms.model.Menu;

import java.util.List;
/*作用是用来查询数据库中url pattern和role的对应关系，查询结果是一个List集合，集合中是Menu类，Menu类有两个核心属性，
一个是url pattern，即匹配规则(比如/admin/**)，还有一个是List,即这种规则的路径需要哪些角色才能访问。*/

@Service
public class MenuService {
    @Autowired
    MenuMapper menuMapper;

    //权限组
    @Autowired
    MenuRoleMapper menuRoleMapper;

    public List<Menu> getMenusByHrId(){/*根据用户id来显示首页左侧菜单。但不能用前端传来的数据（前端的数据是不可信的）*/
        return menuMapper.getMenusByHrId(((Hr) SecurityContextHolder.getContext().getAuthentication().getPrincipal()).getId());
        /*这个SecurityContextHolder.getContext().getAuthentication().getPrincipal()就是保存了当前登陆的用户对象,强转为Hr，再获取其中id*/
    }

    @Cacheable

    public List<Menu> getAllMenusWithRole(){
        return menuMapper.getAllMenusWithRole();
    }



    //权限组
    public List<Menu> getAllMenus() {
        return menuMapper.getAllMenus();
    }

    public List<Integer> getMidsByRid(Integer rid) {
        return menuMapper.getMidsByRid(rid);
    }

    //权限组，先删除后添加
    @Transactional
    public boolean updateMenuRole(Integer rid, Integer[] mids) {
        menuRoleMapper.deleteByRid(rid);
        if (mids == null || mids.length == 0) {
            return true;
        }
        Integer result = menuRoleMapper.insertRecord(rid, mids);
        return result==mids.length;
    }
}
