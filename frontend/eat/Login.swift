//
//  ContentView.swift
//  eat
//
//  Created by 刘洪博 on 2021/12/7.
//

import SwiftUI

struct user:Identifiable{
    var id = UUID()
    var email = String()
    var name = String()
    var password = String()
    var head_portrait = String()
}

struct originalLogin:View{
    let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)
    @State var email: String = ""
    @State var password: String = ""
    @State var ul: String = ""
    @State var usr = user()
    var recipes:[recipe] = getrecipe()
    var body: some View{
        NavigationView{
            VStack{
                TitleText()
                AsyncImage(url:URL(string: self.ul)){
                    image in image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 150)
                    .clipped()
                    .cornerRadius(150)
                    .padding(.bottom, 75)
                }placeholder: {
                    Spacer()
                }.frame(width: 150, height: 150)

                TextField("Useremail",text:$email)
                    .padding()
                    .background(lightGreyColor)
                    .cornerRadius(5.0)
                    .padding(.bottom,20)
                    .onChange(of: email){newValue in
                        self.usr = getuser(useremail: newValue)
                        self.ul = usr.head_portrait
                    }
                SecureField("Password",text: $password)
                    .padding()
                    .background(lightGreyColor)
                    .cornerRadius(5.0)
                    .padding(.bottom,20)
                Button(action:{
                    print("login tapped")
                }){
                    NavigationLink(destination: HomeView(user: usr,recipes:recipes)){
                        LoginButtonContent()
                    }
                }
        }
            .background(Image("food")
                       
                            .edgesIgnoringSafeArea(.all))
            
    }
       
    }
    
}

struct ContentView: View {

    var body: some View {
  
    
            
       Home()
        
    }
}

struct TitleText:View{
    var body:some View{
        Text("User Login")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .padding(.bottom,20)
            .padding(.top,20)
}
}

struct TitleImage: View {
    @State var ul: String
    init(ul:String){
        self.ul = ul
    }
    var body: some View {
        AsyncImage(url:URL(string: ul)){
            image in image
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 150, height: 150)
            .clipped()
            .cornerRadius(150)
            .padding(.bottom, 75)
        }placeholder: {
            Spacer()
        }.frame(width: 150, height: 150)
    }
}
struct LoginButtonContent: View {
    var body: some View {
        Text("LOGIN")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 50)
            .background(Color.green)
            .cornerRadius(15.0)
    }
}
func getuser(useremail:String)->user{
//    let urlstr = URL.init(string: "http://150.158.47.16:8088/seven/getUser/" + username)
    let urlstr = URL.init(string: "http://localhost:8088/seven/getUser/" + useremail)
    let req = URLRequest(url: urlstr!,cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,timeoutInterval: 10.0 )
    var user = user()
    print("urlsession")
    let semaphore = DispatchSemaphore(value: 0)
    URLSession.shared.dataTask(with: req){
        (data:Data?,response:URLResponse?,error:Error?)
        in
        if data != nil{
        let jsonData = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
            if jsonData != nil{
        let jsonDic = jsonData as! NSDictionary
        if jsonDic.value(forKey: "error") == nil{
            print("getit")
        let email = jsonDic.value(forKey: "userid")as! String
        let password = jsonDic.value(forKey: "password")as! String
        let headportrait = jsonDic.value(forKey: "headportrait")as! String
            user.email = email
            user.head_portrait = headportrait
            user.password = password
        }
            }
        }
        semaphore.signal()
    }.resume()
    semaphore.wait()
    return user
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CShape:Shape{
    func path(in rect:CGRect) -> Path{
        return Path{
            path in
            path.move(to: CGPoint(x:rect.width,y:100))
            path.addLine(to: CGPoint(x:rect.width,y:rect.height))
            path.addLine(to: CGPoint(x:0,y:rect.height))
            path.addLine(to: CGPoint(x:0,y:0))
        }
    }
}





struct CShape1:Shape{
    func path(in rect:CGRect) -> Path{
        return Path{
            path in
            path.move(to: CGPoint(x:0,y:100))
            path.addLine(to: CGPoint(x:0,y:rect.height))
            path.addLine(to: CGPoint(x:rect.width,y:rect.height))
            path.addLine(to: CGPoint(x:rect.width,y:0))
        }
    }
}

class imgurl:ObservableObject{
    @Published var ul = String()
}

struct Login:View{
    @State var email = ""
    @State var pass = ""
    @Binding var index : Int
    @ObservedObject var ul:imgurl
    @State var usr = user()
    @State var ifpassright = false
    @State var iftapped = false
    var recipes:[recipe] = getrecipe()
    var body: some View{

        ZStack(alignment: .bottom){
            VStack{
                HStack{
                    VStack(spacing:10){
                        Text("Login")
                            .foregroundColor(self.index == 0 ? .white : .gray)
                            .font(.title)
                            .fontWeight(.bold)
                        Capsule()
                            .fill(self.index == 0 ? Color.blue : Color.clear)
                            .frame(width: 100, height: 5)
                    }
                    Spacer(minLength: 0)
                }.padding(.top,40)
                VStack{
                    HStack(spacing:15){
                        Image(systemName: "envelope.fill")
                            .foregroundColor(Color.blue)
                        TextField("Email Address",text: self.$email).disableAutocorrection(true)
                            .onChange(of: email){
                                newValue in
                                    self.usr = getuser(useremail: newValue)
                                self.ul.ul = usr.head_portrait
                            }
                    }
                    Divider().background(Color.white.opacity(0.5))
                }
                .padding(.horizontal)
                .padding(.top,30)
                VStack{
                    HStack(spacing:15){
                        Image(systemName: "eye.slash.fill")
                            .foregroundColor(Color.blue)
                        SecureField("Password",text: $pass)
                        if(iftapped == true && ifpassright == false){
                            Image(systemName: "xmark.octagon")
                                .foregroundColor(.red)
                        }

                            
                    }
                    Divider().background(Color.white.opacity(0.5))
                }
                .padding(.horizontal)
                .padding(.top,30)
                HStack{
                    Spacer(minLength: 0)
                    Button(action: {
                        
                    }){
                        Text("Forget Password?")
                            .foregroundColor(Color.white.opacity(0.6))
                    }
                    .padding(.horizontal)
                    .padding(.top,30)
                }
            }
            .padding()
            .padding(.bottom,65)
            .background(Color.gray)
            .clipShape(CShape())
            .contentShape(CShape())
            .cornerRadius(35)
            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: -5)
            .onTapGesture {
                self.index = 0
            }
            .padding(.horizontal,20)
            
            Button(action: {
                iftapped = true
                if pass == usr.password{
                    ifpassright = true
                }
                else {
                    ifpassright = false
                }
            }){
              
                Text("LOGIN")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .padding(.horizontal,50)
                    .background(.blue)
                    .clipShape(Capsule())
                    .shadow(color: Color.white.opacity(0.1), radius: 5, x: 0, y: 5)
                
            }
            .background( NavigationLink(destination: HomeView(user: usr,recipes:recipes),isActive: $ifpassright){
                EmptyView()})
            .offset(y:25)
            .opacity(self.index == 0 ? 1 : 0)
          
        }
    
    }
}



struct Signup:View{
    @State var email = ""
    @State var pass = ""
    @State var Repass = ""
    @Binding var index : Int
    @State var ifshow1 = false
    @State var ifshow2 = false
    @State var signtext = "SignUp"
    @State var ifsignup = false
    var body: some View{
        ZStack(alignment: .bottom){
            VStack{
                HStack{
                    Spacer(minLength: 0)
                    VStack(spacing:10){
                        Text("SIGNUP")
                            .foregroundColor(self.index == 1 ? .white : .gray)
                            .font(.title)
                            .fontWeight(.bold)
                        Capsule().fill(self.index == 1 ? Color.blue : Color.clear)
                            .frame(width: 100, height: 5)
                    }
                   
                   
                }.padding(.top,30)
                VStack{
                    HStack(spacing:15){
                        Image(systemName: "envelope.fill")
                            .foregroundColor(Color.blue)
                        TextField("Email Address",text: self.$email)
                        if(ifshow1){
                        Image(systemName: "xmark.octagon")
                            .foregroundColor(Color.red)
                        }
                    }
                    Divider().background(Color.white.opacity(0.5))
                }
                .padding(.horizontal)
                .padding(.top,40)
                VStack{
                    HStack(spacing:15){
                        Image(systemName: "eye.slash.fill")
                            .foregroundColor(Color.blue)
                        SecureField("Password",text: self.$pass)
                        if(ifshow2){
                        Image(systemName: "xmark.octagon")
                            .foregroundColor(Color.red)
                        }
                    }
                    Divider().background(Color.white.opacity(0.5))
                }
                .padding(.horizontal)
                .padding(.top,30)
                VStack{
                    HStack(spacing:15){
                        Image(systemName: "eye.slash.fill")
                            .foregroundColor(Color.blue)
                        SecureField("Password",text: self.$Repass)
                        if(ifshow2){
                            
                        Image(systemName: "xmark.octagon")
                            .foregroundColor(Color.red)
                        }
                    }
                    Divider().background(Color.white.opacity(0.5))
                }
                .padding(.horizontal)
                .padding(.top,30)
            }
            .padding()
            .padding(.bottom,65)
            .background(Color.gray)
            .clipShape(CShape1())
            .contentShape(CShape1())
            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: -5)
            .onTapGesture {
                self.index = 1
            }
            .cornerRadius(35)
            .padding(.horizontal,20)
            
            Button(action: {
                let ifsame = checkpassword(pass: pass, passagain: Repass)
                if(email == ""){
                    ifshow1 = true
                }
               else if( ifsame == false){
                  ifshow2 = true
                }
                else{
                    ifshow1 = false
                    ifshow2 = false
                    adduser(email: email, password: pass)
                    signtext = "Complete!"
                    ifsignup = true
                }
                
            }){
                HStack{
                Text(signtext)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .padding(.horizontal,50)
                    .background(.blue)
                    .clipShape(Capsule())
                    .shadow(color: Color.white.opacity(0.1), radius: 5, x: 0, y: 5)
                }
            }
            .offset(y:25)
            .opacity(self.index == 1 ? 1 : 0)
            .disabled(ifsignup)
        }
    }
}
func adduser(email:String,password:String){
    let urlstr = URL.init(string: "http://localhost:8088/seven/add/" + email + "/" + password)
    let req = URLRequest(url: urlstr!,cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,timeoutInterval: 10.0 )
    URLSession.shared.dataTask(with: req){
        (data:Data?,response:URLResponse?,error:Error?)
        in
    }.resume()

}

func checkpassword(pass:String,passagain:String)->Bool{
    if pass == passagain{
        return true
    }
    else {
        return false
    }
}

struct Home:View{
    @State var index = 0
   @ObservedObject var imgul = imgurl()
    var body: some View{
        NavigationView{
        GeometryReader{
            _ in
            VStack{
                Text("中国非遗美食图鉴").font(.title)
                    .fontWeight(.bold)
                    .opacity(0.9)
                Spacer()
                AsyncImage(url:URL(string: self.imgul.ul)){
                    image in image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 150)
                    .clipped()
                    .cornerRadius(150)
                    .padding(.bottom, 75)
                }placeholder: {
                    Spacer()
                }.frame(width: 150, height: 150)
                ZStack{
                    Signup(index: self.$index)
                        .zIndex(Double(self.index))
                    Login(index: self.$index,ul:imgul)
                        
                }
                
            }
            }.background(Image("food").edgesIgnoringSafeArea(.all))
        }
        
    }
}
