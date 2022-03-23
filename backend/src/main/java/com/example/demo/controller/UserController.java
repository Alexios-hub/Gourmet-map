package com.example.demo.controller;

import com.example.demo.entity.User;
import com.example.demo.service.UserService;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @description:	控制器，接收并响应相关信息
 * @author: Fish_Vast
 * @Date: 2021/8/25
 * @version: 1.0
 */
//控制器类仅仅是一个交互和承上启下的作用
@RestController
@RequestMapping("/seven")
public class UserController {
    @Autowired
    private UserService userService;
    //通过id得到用户信息
    @RequestMapping(value = "/getUser/{userid}", method = RequestMethod.GET)
    public User getUser(@PathVariable String userid){
        return userService.getUser(userid);
    }
    //通过id删除用户信息
    @RequestMapping(value = "/delete", method = RequestMethod.GET)
    public String delete(String user_id){
        int result = userService.delete(user_id);
        if(result >= 1){
            return "删除成功！";
        }else{
            return "删除失败！";
        }
    }
    //更改用户信息
    @RequestMapping(value = "/update", method = RequestMethod.GET)
    public String update(User user){
        int result = userService.update(user);
        if(result >= 1){
            return "更新成功！";
        }else{
            return "更新失败！";
        }
    }
    @RequestMapping(value = "/add/{email}/{password}",method = RequestMethod.GET)
    public void add(@PathVariable String email,@PathVariable String password){
userService.add(email,password);
    }
    //插入用户信息
    @RequestMapping(value = "/insert", method = RequestMethod.GET)
    public int insert(User user){
        return userService.save(user);
    }
    //查询所有用户的信息
    @RequestMapping(value = "/selectAll")
    @ResponseBody   //理解为：单独作为响应体，这里不调用实体类的toString方法
    public List<User>  listUser(){
        return userService.selectAll();
    }
}

