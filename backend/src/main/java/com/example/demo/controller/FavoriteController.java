package com.example.demo.controller;

import com.example.demo.entity.Favorite;
import com.example.demo.service.FavoriteService;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/Favorite")
public class FavoriteController {
    @Autowired
private FavoriteService favoriteService;
    @RequestMapping(value = "/addFavorite/{userid}/{recipeid}",method = RequestMethod.GET)
    public void addFavorite(@PathVariable String userid, @PathVariable String recipeid){
        favoriteService.addFavorite(userid, recipeid);
    }
    @RequestMapping(value = "/removeFavorite/{userid}/{recipeid}",method = RequestMethod.GET)
    public void removeFavorite(@PathVariable String userid, @PathVariable String recipeid){
        favoriteService.removeFavorite(userid, recipeid);
    }
    @RequestMapping(value = "/selectFavorite",method = RequestMethod.GET)
    public Boolean ifinFavorite(@Param("userid") String user_id, @Param("recipeid") String recipe_id){
        System.out.println(user_id+recipe_id);
        Favorite out = favoriteService.ifinFavorite(user_id,recipe_id);
       if (out == null)return false;
       else return true;
    }
}
