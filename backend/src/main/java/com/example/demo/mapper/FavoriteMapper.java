package com.example.demo.mapper;

import com.example.demo.entity.Favorite;
import org.springframework.stereotype.Repository;

@Repository
public interface FavoriteMapper {
    void addFavorite(String userid,String recipeid);
    void removeFavorite(String userid,String recipeid);
    Favorite ifinFavorite(String userid, String recipeid);
}
