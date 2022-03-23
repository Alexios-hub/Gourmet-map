package com.example.demo.service;

import com.example.demo.entity.User;
import com.example.demo.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @description:	实现类，对进行相关的业务逻辑
 * @author: Fish_Vast
 * @Date: 2021/8/25
 * @version: 1.0
 */
@Service
public class UserService {
    @Autowired
    private UserMapper userMapper;

    public User getUser(String userid){
        return userMapper.getUser(userid);
    }

    public void add(String email , String password){
        userMapper.add(email,password);
    }

    public int delete(String userid){
        return userMapper.delete(userid);
    }

    public int update(User user){
        return userMapper.update(user);
    }

    public int save(User user){
        return userMapper.save(user);
    }

    public List<User>  selectAll(){
        return userMapper.selectAll();
    }
}

