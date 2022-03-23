package com.example.demo.service;

import com.example.demo.entity.Recipe;
import com.example.demo.mapper.RecipeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RecipeService {
    @Autowired
    private RecipeMapper recipeMapper;
    public List<Recipe>getRecipe(String recipename){
        return recipeMapper.getRecipe(recipename);
    }
    public List<Recipe>getAllrecipe(){
        return recipeMapper.getAllRecipe();
    }
    public List<Recipe>getFavorate(String email){
        return recipeMapper.getFavorate(email);
    }
}
