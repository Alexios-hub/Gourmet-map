//
//  HistoryDetail.swift
//  eat
//
//  Created by 刘洪博 on 2021/12/12.
//

import SwiftUI

struct HistoryDetail: View {
    let recipe:recipe
    var user:user
    @ObservedObject var favoriterecipes:FavoriteRecipes
    var body: some View {
        GeometryReader{
            geo in
        ScrollView{
            VStack(alignment: .leading){
                AsyncImage(url:URL(string: recipe.recipeimage)){
                    image in image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width:geo.size.width)
                }placeholder: {
                    Spacer()
                }.frame(width: geo.size.width)
                HStack{
                VStack(alignment: .leading){
                    
                
                Text(recipe.recipename).font(.system(.title2, design: .rounded))
                        .fontWeight(.bold)
                Text(recipe.recipelocation).font(.subheadline)
                    .foregroundColor(.secondary)
                }
                    Spacer()
                    NavigationLink(destination: RecipeDetail(recipe: recipe, user: user, favoriterecipes: favoriterecipes)){
                        
                        Text("查看详情")
                        Image(systemName: "chevron.forward")
                    }.frame(width: 120, height: 35)
                        .foregroundColor(.black)
                        .background(.yellow)
                            .cornerRadius(15)
                            .opacity(0.8)
                }
                Divider()
                Text("历史").font(.title2)
                    .fontWeight(.bold)
        Text(recipe.recipehistory)
            }
        }
        .background(Image("caozhi")
                        .resizable()
                        .edgesIgnoringSafeArea(.all))
        }.navigationTitle(recipe.recipename)
    }
}

