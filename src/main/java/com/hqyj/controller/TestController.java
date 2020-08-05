package com.hqyj.controller;

import com.hqyj.pojo.Customer1;
import com.hqyj.pojo.House1;
import com.hqyj.pojo.Login;
import com.hqyj.service.TestService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;


/**
 * author  Jayoung
 * createDate  2020/7/27 0027 11:27
 * version 1.0
 */
@Controller
@RequestMapping("tc")
public class TestController {
  @Autowired
  private TestService tservice;

   //登录开始
    //跳转登录页面
    @RequestMapping("firstShiro.do")
    public String firsShiro(){
        return "login";
    }
    //进行登录认证
    @RequestMapping("liginAuthentication.ajax")
    @ResponseBody
    public String login(String userName, String Password, String Role, Login login, HttpServletRequest request){
        login.setUserName(userName);
        login.setPassword(Password);
        request.getSession().setAttribute("Role",Role);
       // System.out.println(username+"***"+password);
        return tservice.checkLogin(login);
    }
    //验证成功后跳转页面
    @RequestMapping("success.ajax")
    public String SuccessPage(){
        return "index";
    }
    //登录结束

    //退出登录
    @RequestMapping("loginout.ajax")
    public String Exitlogin(){
        Subject currentUser = SecurityUtils.getSubject();
        currentUser.logout();
        return "";
    }

    //注册开始
    //跳转注册页面
    @RequestMapping("register.do")
    public String registerPage(){
        return "register";
    }
    //判断用户名是否重复
    @RequestMapping("usernameIsrepeat.ajax")
    @ResponseBody
    public String usernameIsrepeat(String username){
        return tservice.userNameIsrePeat(username);
    }
    //注册操作
    @RequestMapping("Sign.ajax")
    @ResponseBody
    public String SignCustomer(Customer1 customer)
    {
        return tservice.SignCustomer(customer);
    }
    //注册结束

    //客房查询开始
    @RequestMapping("roomSelectPage.do")
    public String list(String factor,String keywords,House1 house, ModelMap map){
        if ("hAmount".equals(factor)){
            if ("大床房".equals(keywords)){
                house.sethAmount(1);
            }
            if ("双床房".equals(keywords)){
                house.sethAmount(2);
            }
        }
        if ("hPrice".equals(factor)){
            double value=Double.parseDouble(keywords);
            house.sethPrice(value);
        }
        HashMap<String,Object> listmap=tservice.roomselectByPage(house);
        map.addAttribute("data",listmap);
        map.addAttribute("factor",factor);
        map.addAttribute("keywords",keywords);
        //定义访问的页面
        return "customer/roomSelectPage";
    }
    //客房查询结束

}
