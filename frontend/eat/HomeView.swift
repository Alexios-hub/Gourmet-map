//
//  HomeView.swift
//  eat
//
//  Created by 刘洪博 on 2021/12/8.
//

import SwiftUI
class FavoriteRecipes:ObservableObject{
    var ifchange : Bool
    var user :user
    @Published var favoriterecipes :[recipe]
    
    init(user:user){
        self.ifchange = false
        self.user = user
        print("初始化咯")
        print(user)
        self.favoriterecipes = getFavorate(user: user)
    }
    func removefavorite(recipe:recipe){
        print(recipe)
        print(favoriterecipes[0])
        for i in 0..<self.favoriterecipes.count{
            if(recipe.recipeid == self.favoriterecipes[i].recipeid){
                self.favoriterecipes.remove(at: i)
                print("取消咯")
                break
            }
        }
    }
    func addfavorite(recipe:recipe){
        print(recipe)
        self.favoriterecipes.append(recipe)
        print("新加咯")
    }
    func ifinfavorite(recipe:recipe)->Bool{
        for i in 0..<self.favoriterecipes.count{
            if(recipe.recipeid == self.favoriterecipes[i].recipeid){
                return true
            }
        }
        return false
    }
   
}

struct HomeView: View {
    
    let user:user
    @State var selection = 0
    @ObservedObject var favoriterecipes : FavoriteRecipes
    var recipes:[recipe]
    init(user:user,recipes:[recipe]){
        self.user = user
        self.recipes = recipes
        self.favoriterecipes = FavoriteRecipes(user: user)
    }
    var body: some View {
        TabView(selection:$selection){
            Recipes(user: user,favoriterecipes: favoriterecipes,recipes: recipes)
                .tabItem{
                Image(systemName: "book")
            }.navigationBarHidden(true)
               
                .tag(0)
            Videos(user: user,favoriterecipes: favoriterecipes,recipes: recipes).tabItem{
                Image(systemName: "play")
            }.navigationBarHidden(true)
            
                .tag(1)
            History(user: user,recipes: recipes,favoriterecipes: favoriterecipes).tabItem{
                Image(systemName: "text.book.closed")
            }.navigationBarHidden(true)
                
                .tag(2)
            personal(user:self.user,recipes: favoriterecipes).tabItem{
                Image(systemName: "person")
            }.navigationBarHidden(true)
                
                .tag(3)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}


