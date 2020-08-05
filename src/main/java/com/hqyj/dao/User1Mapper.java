package com.hqyj.dao;

import com.hqyj.pojo.User1;
import org.apache.ibatis.annotations.Select;

public interface User1Mapper {
    int deleteByPrimaryKey(Integer uId);

    int insert(User1 record);

    int insertSelective(User1 record);

    User1 selectByPrimaryKey(Integer uId);

    int updateByPrimaryKeySelective(User1 record);

    int updateByPrimaryKey(User1 record);
      //@Select("select * from user1 where u_account = #{username}")
    User1 selectByPersonNameAndPersonPassword(String username);
}