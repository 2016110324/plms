package yuping.liu.plms.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import yuping.liu.plms.mapper.HrMapper;
import yuping.liu.plms.mapper.HrRoleMapper;
import yuping.liu.plms.model.Hr;
import yuping.liu.plms.utils.HrUtils;

import java.util.List;
/*
* 这里最主要是实现了UserDetailsService接口中的loadUserByUsername方法，在执行登录的过程中，这个方法将根据用户名去查找用户，
* 如果用户不存在，则抛出UsernameNotFoundException异常，否则直接将查到的Hr返回。HrMapper用来执行数据库的查询操作

* */
@Service/*将这个类交给spring容器管理，spring容器要为他创建对象*//*业务类*/
public class HrService implements UserDetailsService {/*实现UserDetailsService接口*/
    @Autowired/*这个注解是spring可以自动帮你把bean里面引用的对象的setter/getter方法省略，会帮你自动set/get，*/
    HrMapper hrMapper;/*由系统底层创建这个变量的实例，并注入到这个类中*/

    @Autowired
    HrRoleMapper hrRoleMapper;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {/*这个方法可以根据用户名来加载hr里面的对象*/
        Hr hr = hrMapper.loadUserByUsername(username);/*username查询器*/
        /*查询之后可能是有问题的，hr为null就抛出一个用户名不存在的异常。如果hr不为null,就给hr赋予角色并返回hr,*/
        if(hr==null){
            throw new UsernameNotFoundException("用户名不存在");
        }

        hr.setRoles(hrMapper.getHrRolesById(hr.getId()));
        return hr;
    }


    public List<Hr> getAllHrs(String keywords) {
        return hrMapper.getAllHrs(HrUtils.getCurrentHr().getId(),keywords);
    }

    public Integer updateHr(Hr hr) {
        return hrMapper.updateByPrimaryKeySelective(hr);
    }

    @Transactional
    public boolean updateHrRole(Integer hrid, Integer[] rids) {
        hrRoleMapper.deleteByHrid(hrid);
        return hrRoleMapper.addRole(hrid, rids) == rids.length;
    }

    public Integer deleteHrById(Integer id) {
        return hrMapper.deleteByPrimaryKey(id);
    }

    public List<Hr> getAllHrsExceptCurrentHr() {
        return hrMapper.getAllHrsExceptCurrentHr(HrUtils.getCurrentHr().getId());
    }
}
