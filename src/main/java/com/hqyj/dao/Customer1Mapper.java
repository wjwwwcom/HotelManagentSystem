package com.hqyj.dao;

import com.hqyj.pojo.Customer1;
import org.apache.ibatis.annotations.Select;

public interface Customer1Mapper {
    int deleteByPrimaryKey(Integer cId);

    int insert(Customer1 record);

    boolean insertSelective(Customer1 record);

    Customer1 selectByPrimaryKey(Integer cId);

    int updateByPrimaryKeySelective(Customer1 record);

    int updateByPrimaryKey(Customer1 record);
     //@Select("select * from customer1 where c_account = #{username}")
    Customer1 selectByPersonNameAndPersonPassword(String username);
}