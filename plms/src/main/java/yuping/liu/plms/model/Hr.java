package yuping.liu.plms.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
/*
* UserDetails接口默认有几个方法需要实现，这几个方法中，除了isEnabled返回了正常的enabled之外，其他的方法我都统一返回true，因为我这里的业务逻辑并不涉及到账户的锁定、密码的过期等等，只有账户是否被禁用，因此只处理了isEnabled方法，这一块小伙伴可以根据自己的实际情况来调整。另外，UserDetails中还有一个方法叫做getAuthorities，该方法用来获取当前用户所具有的角色，但是小伙伴也看到了，我的Hr中有一个roles属性用来描述当前用户的角色

* */
public class Hr implements UserDetails {/*要自定义登陆接口，就要实现UserDetails,实现它里面的方法*/
    private Integer id;

    private String name;

    private String phone;

    private String telephone;

    private String address;

    private Boolean enabled;

    private String username;

    private String password;

    private String userface;

    private String remark;

    private List<Role> roles;//一个hr对应多个角色

    public List<Role> getRoles() {
        return roles;
    }

    public void setRoles(List<Role> roles) {
        this.roles = roles;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone == null ? null : phone.trim();
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone == null ? null : telephone.trim();
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address == null ? null : address.trim();
    }

//    public Boolean getEnabled() {
//        return enabled;
//    }删掉原本的这个enabled方法,不然就有两个enabled获取方法

    public void setEnabled(Boolean enabled) {
        this.enabled = enabled;
    }

    public String getUsername() {
        return username;
    }

    @Override
    public boolean isAccountNonExpired() {/*账户是否没有过期*/
        return true;
    }//账户是否没有过期

    @Override
    public boolean isAccountNonLocked() {/*账户是否没有被锁定*/
        return true;
    }//账户是否没有被锁定

    @Override
    public boolean isCredentialsNonExpired() {/*密码是否没有过期*/
        return true;
    }//密码是否没有过期

    @Override
    public boolean isEnabled() {
        return enabled;/*返回自己的enabled*/
    }

    public void setUsername(String username) {
        this.username = username == null ? null : username.trim();
    }

    @Override
    @JsonIgnore // 生成json时候，authorities不用返回到前端
    public Collection<? extends GrantedAuthority> getAuthorities() {/*这个集合里面返回角色*/
        List<SimpleGrantedAuthority>  authorities = new ArrayList<>(roles.size());
        for (Role role :roles){
            authorities.add(new SimpleGrantedAuthority(role.getName()));
        }
        return authorities;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password == null ? null : password.trim();
    }

    public String getUserface() {
        return userface;
    }

    public void setUserface(String userface) {
        this.userface = userface == null ? null : userface.trim();
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
    }
}