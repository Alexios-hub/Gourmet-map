//
//  RecipeDetail.swift
//  eat
//
//  Created by 刘洪博 on 2021/12/9.
//

import SwiftUI
import AVKit
struct RecipeDetail: View {
    var recipe:recipe
    var user:user
    @ObservedObject var favoriterecipes:FavoriteRecipes

    init(recipe:recipe,user:user,favoriterecipes:FavoriteRecipes){
        self.recipe=recipe
        self.user=user
        self.favoriterecipes = favoriterecipes
    }

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
                    HStack{
                        Text(recipe.recipename).font(.title2)
                            .fontWeight(.bold)
                  
                        
                    }
                  
                    HStack{
                        Text(recipe.recipelocation)
                            
                    }.font(.subheadline)
                        .foregroundColor(.secondary)
                    }
                        Spacer()
                        if(self.favoriterecipes.ifinfavorite(recipe: recipe)){
                            Button( action: {

                               
                                favoriterecipes.removefavorite(recipe: recipe)

                                removeFavorite(user: user, recipe: recipe)

                            }){
                                Image(systemName: "heart")
                                Text("取消收藏")
                                    
                            }.frame(width: 120, height: 25)
                            .foregroundColor(.white)
                                .background(Color.red)
                                .cornerRadius(15)
                            
                        }
                        else{
                            Button( action: {

                              
                                favoriterecipes.addfavorite(recipe: recipe)

                               
                                addFavorite(user: user, recipe: recipe)

                               
                            }){
                                Image(systemName: "heart")
                                Text("收藏")
                                
                            }.frame(width: 90, height: 25)
                            .background(RoundedRectangle(cornerRadius: 15)
                                            .stroke(Color.red,lineWidth: 1))
                            .foregroundColor(.red)
                        }
                    }
                    Divider()
                    Text("简介").font(.title2)
                        .fontWeight(.bold)
            Text(recipe.recipedescription)
                    Divider()
                    Group{   Text("视频").font(.title2)
                            .fontWeight(.bold)
                 
            VideoPlayer(player: AVPlayer(url: URL(string: recipe.video)!)).frame(width: geo.size.width, height: geo.size.height/3)
                    Divider()
                    Text("做法").font(.title2)
                            .fontWeight(.bold)
                         Text(recipe.todo)
                    }
                    
                }
        } .background(Image("qiancaozhi")
                        .resizable()
                        .edgesIgnoringSafeArea(.all))
            }.navigationTitle(recipe.recipename)
    
        
    }
}
struct NotInFavorite:View{
    var body: some View{
    Button( action: {
        
    }){
        Image(systemName: "heart")
        Text("收藏")
        
    }.frame(width: 90, height: 20)
    .background(RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.red,lineWidth: 1))
    .foregroundColor(.red)
            
}
}
struct InFavorite:View{

    var body: some View{
        Button( action: {

        }){
            Image(systemName: "heart")
            Text("取消收藏")
                
        }.frame(width: 120, height: 20)
        .foregroundColor(.white)
            .background(Color.red)
            .cornerRadius(15)
        

    }
}
func getifinFavorite(user:user,recipe:recipe)->Bool{
    print("判断是否在收藏中")
    let urlstr = URL.init(string: "http://localhost:8088/Favorite/selectFavorite?user_id="+user.email+"&recipe_id="+String(recipe.recipeid))
    let req = URLRequest(url: urlstr!,cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,timeoutInterval: 10.0 )
    var ifinFavorite:Bool = false
    let semaphore = DispatchSemaphore(value: 0)
    URLSession.shared.dataTask(with: req){
        (data:Data?,response:URLResponse?,error:Error?)
        in
        if data != nil{
        let jsonData = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
            if jsonData != nil{
                print("lhb")
        ifinFavorite = jsonData as! Bool
                
        }
        }
        semaphore.signal()
    }.resume()
    semaphore.wait()
    print(ifinFavorite)
    return ifinFavorite
}

func addFavorite(user:user,recipe:recipe){
    let urlstr = URL.init(string: "http://localhost:8088/Favorite/addFavorite/"+user.email+"/"+String(recipe.recipeid))
    let req = URLRequest(url: urlstr!,cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,timeoutInterval: 10.0 )
    URLSession.shared.dataTask(with: req){
        (data:Data?,response:URLResponse?,error:Error?)
        in
        if data != nil{
            _ = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
            print("收藏")
            
        }
    }.resume()
}
func removeFavorite(user:user,recipe:recipe){
    let urlstr = URL.init(string: "http://localhost:8088/Favorite/removeFavorite/"+user.email+"/"+String(recipe.recipeid))
    let req = URLRequest(url: urlstr!,cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,timeoutInterval: 10.0 )
    URLSession.shared.dataTask(with: req){
        (data:Data?,response:URLResponse?,error:Error?)
        in
        if data != nil{
            _ = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
            print("取消收藏")
        }
    }.resume()
}




