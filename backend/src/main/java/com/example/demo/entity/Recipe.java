package com.example.demo.entity;

public class Recipe {
    private int recipeid;
    private String recipename;
    private String video;
    private String recipehistory;
    private String todo;
    private String recipedescription;
    private String recipeimage;
    private String recipelocation;

    public String getRecipelocation() {
        return recipelocation;
    }

    public void setRecipelocation(String recipelocation) {
        this.recipelocation = recipelocation;
    }

    public int getRecipeid() {
        return recipeid;
    }

    public void setRecipeid(int recipeid) {
        this.recipeid = recipeid;
    }

    public String getRecipename() {
        return recipename;
    }

    public void setRecipename(String recipename) {
        this.recipename = recipename;
    }

    public String getVideo() {
        return video;
    }

    public void setVideo(String video) {
        this.video = video;
    }

    public String getRecipehistory() {
        return recipehistory;
    }

    public void setRecipehistory(String recipehistory) {
        this.recipehistory = recipehistory;
    }

    public String getTodo() {
        return todo;
    }

    public void setTodo(String todo) {
        this.todo = todo;
    }

    public String getRecipedescription() {
        return recipedescription;
    }

    public void setRecipedescription(String recipedescription) {
        this.recipedescription = recipedescription;
    }

    public String getRecipeimage() {
        return recipeimage;
    }

    public void setRecipeimage(String recipeimage) {
        this.recipeimage = recipeimage;
    }

    @Override
    public String toString() {
        return "Recipe{" +
                "recipeid=" + recipeid +
                ", recipename='" + recipename + '\'' +
                ", video='" + video + '\'' +
                ", recipehistory='" + recipehistory + '\'' +
                ", todo='" + todo + '\'' +
                ", recipedescription='" + recipedescription + '\'' +
                ", recipeimage='" + recipeimage + '\'' +
                ", recipelocation='" + recipelocation + '\'' +
                '}';
    }
}
