package com.example.demo.controller;

import com.example.demo.entity.Recipe;
import com.example.demo.service.RecipeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.configurationprocessor.json.JSONArray;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;

@RestController
@RequestMapping("/Recipe")
public class RecipeController {
    @Autowired
    private RecipeService recipeService;

    @RequestMapping(value = "/getRecipe/{recipename}", method = RequestMethod.GET)
    public List<Recipe> getRecipe(@PathVariable String recipename) {
        return recipeService.getRecipe(recipename);
    }

    @RequestMapping(value = "/getAllRecipe", method = RequestMethod.GET)
    public List<Recipe> getAllRecipe() {
        return recipeService.getAllrecipe();
    }

    @RequestMapping(value = "/getFavorate/{email}", method = RequestMethod.GET)
    public HashMap<String,Object> getFavorate(@PathVariable String email) {
        List<Recipe> result = recipeService.getFavorate(email);
        HashMap<String,Object>resultData = new HashMap<>();
        System.out.println(email);
        if(result.size() == 0){
            resultData.put("msg","error");
        }
        else{
            resultData.put("msg","success");
            resultData.put("result", result);
        }
        return resultData;
    }
}