//
//  Videos.swift
//  eat
//
//  Created by 刘洪博 on 2021/12/8.
//

import SwiftUI
import AVKit

struct Videos: View {
    let recipes: [recipe]
    var user:user
    @ObservedObject var favoriterecipes:FavoriteRecipes
    init(user:user,favoriterecipes:FavoriteRecipes,recipes:[recipe]){
        self.user = user
        self.favoriterecipes = favoriterecipes
        self.recipes = recipes
        print(self.recipes)
    }
    var body: some View {
        VStack(alignment: .leading){
            
        GeometryReader{
            geo in
        List(self.recipes){
            recipe in
            NavigationLink(destination: RecipeDetail(recipe: recipe,user:user,favoriterecipes: favoriterecipes)){
                VStack(alignment:.center){
                    VideoPlayer(player: AVPlayer(url: URL(string: recipe.video)!)).frame( height: geo.size.height*2/5, alignment: .center)
                    Text(recipe.recipename)
                }
            }
    }
        }
        }
    }
}


