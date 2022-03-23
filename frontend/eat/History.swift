//
//  History.swift
//  eat
//
//  Created by 刘洪博 on 2021/12/8.
//

import SwiftUI

struct History: View {
    let recipes: [recipe]
    var user:user
    @ObservedObject var favoriterecipes:FavoriteRecipes
    init(user:user,recipes:[recipe],favoriterecipes:FavoriteRecipes){
        self.user = user
        self.recipes = recipes
        self.favoriterecipes = favoriterecipes
        print(self.recipes)
    }
    var body: some View {
        List(self.recipes){
            recipe in
            NavigationLink( destination: HistoryDetail(recipe: recipe,user: user,favoriterecipes: favoriterecipes)){
                TableRow(recipe: recipe).navigationBarHidden(true)
            }.navigationBarHidden(true)
    }
    }
}


struct TableRow: View {
    let recipe: recipe
    var body: some View {
        
        HStack{
            AsyncImage(url:URL(string: recipe.recipeimage)){
                image in image
                    .resizable()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .shadow(radius: 30)
            }placeholder: {
                Spacer()
            }
            
            
            VStack(alignment: .leading){
                
                Text(recipe.recipename)
                    .font(.system(size: 17))
                    .fontWeight(.none)
                    .foregroundColor(Color.black)
                
                
                Text(recipe.recipelocation)
                    .font(.system(size: 12))
                    .padding(.top,2)
                
            }
            
        }
        .padding(5)
    }
}

