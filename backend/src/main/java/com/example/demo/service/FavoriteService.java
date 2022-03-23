package com.example.demo.service;

import com.example.demo.entity.Favorite;
import com.example.demo.mapper.FavoriteMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class FavoriteService {
    @Autowired
    private FavoriteMapper favoriteMapper;
    public void addFavorite(String userid,String recipeid){
         favoriteMapper.addFavorite(userid,recipeid);
    }
    public void removeFavorite(String userid,String recipeid){
        favoriteMapper.removeFavorite(userid,recipeid);
    }
    public Favorite ifinFavorite(String userid, String recipeid){
        return favoriteMapper.ifinFavorite(userid,recipeid);
    }
}
