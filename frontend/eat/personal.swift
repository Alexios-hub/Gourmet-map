//
//  personal.swift
//  eat
//
//  Created by 刘洪博 on 2021/12/8.
//

import SwiftUI

struct personal: View {
    let user:user
    @ObservedObject var recipes:FavoriteRecipes
    var body: some View {
        ScrollView{
        VStack{
            Spacer(minLength: 60)
            CircleImage(user: user,recipes: recipes.favoriterecipes)
            Spacer(minLength: 30)
            Divider()
            Text("个人收藏").font(.title2)
                .fontWeight(.bold)
                .frame(alignment: .leading)
                Spacer(minLength: 30)
 
        ScrollView(.horizontal, showsIndicators: false){
            HStack(spacing:80){
                ForEach(recipes.favoriterecipes, id: \.id) { recipe in
                    NavigationLink(destination: RecipeDetail(recipe: recipe, user: user, favoriterecipes: recipes)){
                        GeometryReader { geometry in
                            cardView(recipe: recipe).rotation3DEffect(Angle(degrees: Double(geometry.frame(in: .global).minX - 60) / -30), axis: (x: 0, y: 10, z: 0))
                        }
                    
                }.frame(width: 200, height: 300)
                }
            }
            .frame( height: 350)
            .padding(.horizontal)
        }
        }
        }.background(Image("back1")
                        .resizable()
                        .edgesIgnoringSafeArea(.all))
        }
    }

struct cardView:View{
    let recipe:recipe
    var body: some View{

        VStack{
            Text(recipe.recipename).fontWeight(.bold)
                .foregroundColor(.white)
                .font(.system(size: 30))
            Text(recipe.recipelocation).fontWeight(.bold)
                .foregroundColor(.white)
                .font(.system(size: 20))
        }.background(AsyncImage(url: URL(string: recipe.recipeimage)){
            image in image
                .resizable()
                .frame(width: 250, height: 300)
        }placeholder:{
            Spacer()
        }.cornerRadius(20))
    
    }
}

struct CircleImage: View {
    let user:user
    let recipes:[recipe]
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: user.head_portrait)){
                image in image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150, alignment: .top)
                    .cornerRadius(75)
            }placeholder:{
                Spacer()
            }
            
            
        }
    }
}
func getFavorate(user:user)->[recipe]{
    let urlstr = URL.init(string: "http://localhost:8088/Recipe/getFavorate/" + user.email)
    let req = URLRequest(url: urlstr!,cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,timeoutInterval: 10.0)
    var recipes = [recipe]()
    let semaphore = DispatchSemaphore(value: 0)
    URLSession.shared.dataTask(with: req){
        (data:Data?,response:URLResponse?,error:Error?)
        in
        if data != nil{
            let jsonData = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
            if jsonData != nil{
                let jsonDictionary = jsonData as! NSDictionary
                if (!(jsonDictionary.value(forKey: "msg") == nil) && jsonDictionary.value(forKey: "msg") as! String == "success"){
                    let jsonDics = jsonDictionary.value(forKey: "result")as! [NSDictionary]
                for jsonDic in jsonDics {
                    if jsonDic.value(forKey: "error") == nil{
                        let recipeid = jsonDic.value(forKey: "recipeid")as! Int
                        let recipename = jsonDic.value(forKey: "recipename")as! String
                        let video = jsonDic.value(forKey: "video")as! String
                        let recipehistory = jsonDic.value(forKey: "recipehistory")as! String
                        let todo = jsonDic.value(forKey: "todo")as! String
                        let recipedescription = jsonDic.value(forKey: "recipedescription")as! String
                        let recipeimage = jsonDic.value(forKey: "recipeimage")as! String
                        let recipelocation = jsonDic.value(forKey: "recipelocation")as! String
                        recipes.append(recipe(recipeid:recipeid,recipename: recipename, video: video, recipehistory: recipehistory, todo: todo, recipedescription: recipedescription, recipeimage: recipeimage, recipelocation: recipelocation))
                    }
                }
                }
                
            }
        }
        semaphore.signal()
        
    }.resume()
    semaphore.wait()
    return recipes
}


