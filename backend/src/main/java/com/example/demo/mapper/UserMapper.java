package com.example.demo.mapper;


import com.example.demo.entity.User;
import org.apache.ibatis.annotations.Result;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserMapper {
    //1.通过id查询用户信息
    User getUser(String userid);
    //2.通过id删除用户信息
    int delete(String userid);
    //3.更改用户信息
    int update(User user);
    //4.插入用户信息
    int save(User user);
    void add(String email,String password);
    //5.查询所有用户信息
    List<User> selectAll();
}

