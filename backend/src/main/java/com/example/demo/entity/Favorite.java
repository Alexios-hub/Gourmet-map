package com.example.demo.entity;

public class Favorite {
   private String userid;
   private String recipeid;

    public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }

    public String getRecipeid() {
        return recipeid;
    }

    public void setRecipeid(String recipeid) {
        this.recipeid = recipeid;
    }

    @Override
    public String toString() {
        return "Favorite{" +
                "user_id='" + userid + '\'' +
                ", recipe_id=" + recipeid +
                '}';
    }
}
