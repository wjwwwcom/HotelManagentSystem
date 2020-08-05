package com.hqyj.dao;

import com.hqyj.pojo.House1;

import java.util.List;

public interface House1Mapper {
    int deleteByPrimaryKey(Integer hId);

    int insert(House1 record);

    int insertSelective(House1 record);

    House1 selectByPrimaryKey(Integer hId);

    int updateByPrimaryKeySelective(House1 record);

    int updateByPrimaryKey(House1 record);
    //房间分页查询
    List<House1> houseselectByPage(House1 house);
}