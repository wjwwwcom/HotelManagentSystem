package com.hqyj.service;

import com.hqyj.pojo.Customer1;
import com.hqyj.pojo.House1;
import com.hqyj.pojo.Login;

import java.util.HashMap;

public interface TestService {
    String checkLogin(Login login);

    String userNameIsrePeat(String username);

    String SignCustomer(Customer1 customer);

    HashMap<String, Object> roomselectByPage(House1 house);
}
