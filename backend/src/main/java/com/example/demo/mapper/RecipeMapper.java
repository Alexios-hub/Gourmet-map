package com.example.demo.mapper;

import com.example.demo.entity.Recipe;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RecipeMapper {
    List<Recipe>getRecipe(String recipename);
    List<Recipe>getAllRecipe();
    List<Recipe>getFavorate(String email);
}
