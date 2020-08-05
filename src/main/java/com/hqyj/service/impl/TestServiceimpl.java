package com.hqyj.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hqyj.dao.Customer1Mapper;
import com.hqyj.dao.House1Mapper;
import com.hqyj.dao.User1Mapper;
import com.hqyj.pojo.Customer1;
import com.hqyj.pojo.House1;
import com.hqyj.pojo.Login;
import com.hqyj.pojo.User1;
import com.hqyj.service.TestService;
import com.hqyj.utils.Encryption;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

@Service
public class TestServiceimpl implements TestService {
    @Autowired
    private User1Mapper um;
    @Autowired
    private Customer1Mapper cm;
    @Autowired
    private House1Mapper hm;
    public String checkLogin(Login loginer) {
        Subject sub = SecurityUtils.getSubject();
        if (!sub.isAuthenticated()) {
            //UsernamePasswordToken令牌类，稍后会把保存在里面账号密码和shiro的身份和凭证比对
            UsernamePasswordToken upt = new UsernamePasswordToken(loginer.getUserName(), loginer.getPassword());
            upt.setRememberMe(true);
            try {
                sub.login(upt);
                return "Success";
            } catch (AuthenticationException e) {
                //登录失败
                return "ERROR";
            }
        }
        return null;
    }

    public String userNameIsrePeat(String username) {
        Customer1 customer=cm.selectByPersonNameAndPersonPassword(username);
           if (customer!=null){
               return "Sorry";
           }else {
               return "ok";
           }
    }

    public String SignCustomer(Customer1 customer) {
        //将密码加密保存
          String cPassword= new Encryption().customerMd5IsEncryption(customer.getcAccount(),customer.getcPassword());
          customer.setcPassword(cPassword);
         if (cm.insertSelective(customer)){
             return "Success";
         }else {
             return "Failure";
         }
    }
    //房间分页查询
    public HashMap<String, Object> roomselectByPage(House1 house) {
        PageHelper.startPage(house.getPage(),house.getRow());
        //查询自定义sql
        List<House1> list=hm.houseselectByPage(house);
        //转换分页对象
        PageInfo<House1> pageInfo=new PageInfo<House1>(list);
        //构建数据类型
        HashMap<String,Object> map=new HashMap<String, Object>();
        map.put("list",pageInfo.getList());
        map.put("count",pageInfo.getTotal());
        map.put("prePage",pageInfo.getPrePage());
        map.put("nextPage",pageInfo.getNextPage());
        map.put("indexPage",pageInfo.getFirstPage());
        map.put("endPage",pageInfo.getLastPage());
        map.put("allPage",pageInfo.getPages());
        map.put("pageNum",pageInfo.getPageNum());
        map.put("ispro",pageInfo.isHasPreviousPage());
        map.put("isNextPage",pageInfo.isHasNextPage());
        return map;

    }
}
