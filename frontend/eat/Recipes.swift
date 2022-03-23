//
//  Recipes.swift
//  eat
//
//  Created by 刘洪博 on 2021/12/8.
//

import SwiftUI


 struct recipe: Identifiable{
    var id = UUID()
     var recipeid = Int()
     var recipename = String()
     var video = String()
     var recipehistory = String()
     var todo = String()
     var recipedescription = String()
     var recipeimage = String()
     var recipelocation = String()

}
class buttonchanged:ObservableObject{
    var ifchange : Bool
    init()
    {
        self.ifchange = false
    }
}

struct Recipes: View {
    let recipes: [recipe]
    @ObservedObject var favoriterecipes:FavoriteRecipes
    var user:user
    init(user:user,favoriterecipes:FavoriteRecipes,recipes:[recipe]){
        self.user = user
        self.favoriterecipes = favoriterecipes
        self.recipes = recipes
        print(self.recipes)
    }
    var body: some View {
        
        VStack(alignment: .leading){
          
            List(self.recipes){
                
                recipe in
                NavigationLink(destination:RecipeDetail(recipe: recipe,user: user,favoriterecipes: favoriterecipes)){
                    VStack(alignment:.leading){
                        AsyncImage(url: URL(string: recipe.recipeimage)){
                            image in image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .cornerRadius(10)
                            Text(recipe.recipename)
                                .font(.system(size:15))
                        }placeholder:{
                            Spacer()
                        }
                    }
                }
            }
        }
    }
}

func getrecipe()->[recipe]{
//    let urlstr = URL.init(string: "http://150.158.47.16:8088/seven/getUser/" + username)
    let urlstr = URL.init(string: "http://localhost:8088/Recipe/getAllRecipe")
    let req = URLRequest(url: urlstr!,cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,timeoutInterval: 10.0 )
    var recipes = [recipe]()
    let semaphore = DispatchSemaphore(value: 0)
    URLSession.shared.dataTask(with: req){
        (data:Data?,response:URLResponse?,error:Error?)
        in
        if data != nil{
        let jsonData = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
            if jsonData != nil{
                print("jsondata2\(String(describing: jsonData))")
        let jsonDics = jsonData as! [NSDictionary]
                for jsonDic in jsonDics {
        if jsonDic.value(forKey: "error") == nil{
            print("getit")
            print(jsonDic)
            let recipeid = jsonDic.value(forKey: "recipeid")as! Int
            print("recipeid\(recipeid)")
        let recipename = jsonDic.value(forKey: "recipename")as! String
        let video = jsonDic.value(forKey: "video")as! String
        let recipehistory = jsonDic.value(forKey: "recipehistory")as! String
        let todo = jsonDic.value(forKey: "todo")as! String
        let recipedescription = jsonDic.value(forKey: "recipedescription") as! String
        let recipeimage = jsonDic.value(forKey: "recipeimage")as! String
        let recipelocation = jsonDic.value(forKey: "recipelocation")as! String
           
            recipes.append(recipe(recipeid:recipeid, recipename: recipename, video: video, recipehistory: recipehistory, todo: todo, recipedescription: recipedescription, recipeimage: recipeimage,
                                  recipelocation: recipelocation))
        }
        }
        }
        }
        semaphore.signal()
    }.resume()
    semaphore.wait()
    print(recipes)
    return recipes
}


