//
//  HomeView.swift
//  under-stars
//
//  Created by Lami Qv on 19.03.2020.
//  Copyright © 2020 Lami Qv. All rights reserved.
//

import SwiftUI


struct HomeView: View {
    
    @State var search: Bool = false
    @State var explore: Bool = true
    @State var profile: Bool = false
    
    @EnvironmentObject var session: SessionStore
    
    @State var index = 2
    @State var offset : CGFloat = UIScreen.main.bounds.width
    var width = UIScreen.main.bounds.width
    
    var body: some View {
        
    VStack(spacing: 0) {
            
            AppBar(index: self.$index, offset: self.$offset)
            
            GeometryReader{g in
                
                HStack(spacing: 0){
                    
                    SearchView()
                        .frame(width: g.frame(in : .global).width)
                    
                    todoView()
                        .frame(width: g.frame(in : .global).width)
                    
                    ProfileView()
                        .frame(width: g.frame(in : .global).width)
                }
                .offset(x: self.offset)
                .highPriorityGesture(DragGesture()
                
                .onEnded({ (value) in
                
                    if value.translation.width > 50{// minimum drag...
                        
                        print("right")
                        self.changeView(left: false)
                    }
                    if -value.translation.width > 50{
                        
                        print("left")
                        self.changeView(left: true)
                    }
                }))
                
            }
        }
        .animation(.default)
//        .edgesIgnoringSafeArea(.all)
    }
    
    func changeView(left : Bool){
        
        if left{
            
            if self.index != 3{
                
                self.index += 1
            }
        }
        else{
            
            if self.index != 1{
                
                self.index -= 1
            }
        }
        
        if self.index == 1{
            
            self.offset = self.width
        }
        else if self.index == 2{
            
            self.offset = 0
        }
        else{
            
            self.offset = -self.width
        }
        // change the width based on the size of the tabs...
        
//        NavigationView {
//
//                VStack {
//                    HStack(alignment: .center) {
//
//                        Button(action: {
//                            self.search = true
//                            self.explore = false
//                            self.profile = false
//                        }){
//                            Image(systemName: "magnifyingglass.circle.fill")
//                                .foregroundColor(search ? .purple : Color("menuApp"))
//                                .font(.title)
//                        }
//
//                        Spacer()
//
//                        Button(action: {
//                            self.search = false
//                            self.explore = true
//                            self.profile = false
//                        }){
//                            Image(systemName: "circle.grid.hex.fill")
//                                .foregroundColor(explore ? .purple : Color("menuApp"))
//                                .font(.title)
//                        }
//
//                        Spacer()
//
//                        Button(action: {
//                            self.search = false
//                            self.explore = false
//                            self.profile = true
//                        }){
//                            Image(systemName: "person.crop.circle.fill")
//                                .foregroundColor(profile ? .purple : Color("menuApp"))
//                                .font(.title)
//                        }
//
//                    }.padding(.horizontal, 20)
//
//                    ScrollView {
//
//                        BannerSubscribe()
//
//                        if search {
//                            SearchView()
//                        }
//
//                        if explore {
//
//                            VStack {
//                                HStack {
//                                    Text("Last Visit")
//                                        .font(.headline)
//                                        .fontWeight(.bold)
//                                        .foregroundColor(Color.purple)
//                                    Spacer()
//                                }.padding(.horizontal,20)
//                                .padding(.vertical, 20)
//
//                                    ExploreMainView()
//                                    ExploreMainView()
//                                    ExploreMainView()
//
//                            }.padding(.vertical, 10)
//
//
//                            VStack {
//                            HStack {
//                                Text("Your TodoNotes")
//                                    .font(.headline)
//                                    .fontWeight(.bold)
//                                    .foregroundColor(Color.purple)
//                                Spacer()
//                            }.padding(.horizontal,20)
//                            .padding(.vertical, 20)
//
//                                ListTodoNoteView()
//
//                            }
//                        }
//
//                        if profile {
//                            ProfileView()
//                        }
//
//                    }.frame(width: UIScreen.main.bounds.width)
//                }.padding(.horizontal,20)
//                .padding(.top, 20)
//                .navigationBarTitle("")
//                .navigationBarHidden(true)
//
//        }

    }
}

struct todoView: View {
    
    var body: some View {
        
        GeometryReader{_ in

            VStack{

                VStack {
                        HStack {
                            Text("Last Visit")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(Color.purple)
                            Spacer()
                        }.padding(.horizontal,20)
                        .padding(.vertical, 20)

                    ExploreMainView().zIndex(2)
                            ExploreMainView().zIndex(2)
                            ExploreMainView().zIndex(2)

                    }.padding(.vertical, 10)


                    VStack {
                    HStack {
                        Text("Your TodoNotes")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(Color.purple)
                        Spacer()
                    }.padding(.horizontal,20)
                    .padding(.vertical, 20)

                        ListTodoNoteView().zIndex(2)

                    }
                }
            
            Spacer()
                
        }
        .background(Color("backgroundAllApp"))
            
            
    }
}

struct HomeView_Previews: PreviewProvider {
    
    static var previews: some View {
        HomeView()
    }
}


struct AppBar : View {
    
    @Binding var index : Int
    @Binding var offset : CGFloat
    var width = UIScreen.main.bounds.width
    
    var body: some View{
        
        VStack {
            
            VStack(alignment: .leading, content: {
                
                HStack{
                    
                    Button(action: {
                        
                        self.index = 1
                        self.offset = self.width
                    }) {
                        
                        VStack(spacing: 8){
                            
                            HStack(spacing: 12){
                                Image(systemName: "magnifyingglass.circle.fill")
                                    .foregroundColor(self.index == 1 ? Color.purple : Color.gray)
                                    .font(.title)
                            }
                            
                        }
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        
                        self.index = 2
                        self.offset = 0
                        
                    }) {
                        
                        VStack(spacing: 8){
                            
                            HStack(spacing: 12){
                                
                                Image(systemName: "circle.grid.hex.fill")
                                    .foregroundColor(self.index == 2 ? Color.purple : Color.gray)
                                    .font(.title)
                            }
                            
                        }
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        
                        self.index = 3
                        self.offset = -self.width
                        
                    }) {
                        
                        VStack(spacing: 8){
                            
                            HStack(spacing: 12){
                                
                                Image(systemName: "person.crop.circle.fill")
                                    .foregroundColor(self.index == 3 ? Color.purple : Color.gray)
                                    .font(.title)
                            }
                            
                        }
                    }

                }.padding(.horizontal, 20)
                    
            })
            .padding(.top, (UIApplication.shared.windows.first?.safeAreaInsets.top)! + 15)
            .padding(.horizontal)
            .padding(.bottom, 10)
            //.background(Color.red)
            
            if(self.index != 3) {
                        BannerSubscribe()
            }
            
        }
        
        
    }
}

struct ProfileView: View {
    
    @EnvironmentObject var session: SessionStore
    
    @State var showEdit:Bool = false
    
    func signOut () {
        let _ = session.signOut()
    }
    
    
    var body: some View {
        
        GeometryReader{_ in

            VStack{
                
                HStack(spacing: 10) {
                    
                    ImageView(withURL: "\(self.session.get().photoURL!)")
                        .scaledToFit()
                        .frame(width: 150)
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text(self.session.get().displayName ?? "NONE")
                            .font(.headline)
                            .fontWeight(.medium)
                        
                        HStack(spacing: 10) {
                            Button(action: {
                                 self.showEdit.toggle()
                             }){
                                 Text("Edit profile")
                                     .font(.caption)
                                     .fontWeight(.light)
                                     .padding(.vertical, 8)
                                     .padding(.horizontal, 10)
                                     .background(Color("AppAccent1"))
                                     .foregroundColor(.white)
                                     .clipShape(RoundedRectangle(cornerRadius: 5))
                             }
                             
                            Button(action: self.signOut) {
                                 Text("Log Out")
                                    .font(.caption)
                                    .fontWeight(.light)
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 10)
                                    .background(Color("AppAccent1"))
                                    .foregroundColor(.red)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                             }
                        }

                        
                    }
                    
                    Spacer()
                    
                }
                .padding(.vertical, 20)
                .background(Color("backgroundApp"))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal, 20)
                .padding(.vertical, 20)
                .sheet(isPresented: self.$showEdit) {
                    EditProfile(showEdit: self.$showEdit).environmentObject(self.session)
                }
                
                
                }
        Spacer()
        }
        .background(Color("backgroundAllApp"))
        

    }
}

struct ImageView: View {
    @ObservedObject var imageLoader:ImageLoader
    @State var image:UIImage = UIImage()

    init(withURL url:String) {
        imageLoader = ImageLoader(urlString:url)
    }

    var body: some View {
        VStack {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
//                .frame(width:100, height:100)
        }.onReceive(imageLoader.didChange) { data in
            self.image = UIImage(data: data) ?? UIImage()
        }
    }
}

struct ExploreMainView: View {
    var body: some View {
            
        NavigationLink(destination: Text("Japan"))  {
            
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Japan")
                        .font(.headline)
                        .fontWeight(.bold)
                    Text("25 07 2020")
                        .font(.caption)
                        .fontWeight(.light)
                }
                
                Spacer()
                
                Image("japan")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50)
                    .padding(10)
                    .background(Color("AppAccent1"))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
//                        .shadow(color: Color.gray.opacity(0.1), radius: 8, x: 0, y: 2)
                
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 5)

        }
        .background(Color("backgroundApp"))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding(.horizontal, 20)
        .padding(.vertical, 0)
        .frame(width: UIScreen.main.bounds.width)
        .buttonStyle(PlainButtonStyle())
        
    }
}


struct ListTodoNoteView: View {
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach (Project.all()) { project in
                    GeometryReader { geometry in
                        ExploreItemView(project: project)
                            .background(Color("backgroundApp"))
                            .frame(width: UIScreen.main.bounds.width-60)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .rotation3DEffect(Angle(degrees: (Double(geometry.frame(in: .global).minX) - 20) / 20),
                                              axis: (x: 0.0, y: 0.0, z: 0.0))

                    }
                }.frame(minWidth: UIScreen.main.bounds.width-60, minHeight: 140)
                
            }.padding(20)
            
            Spacer()
            
        }.frame(width: UIScreen.main.bounds.width, height: 120)
        
    }
}


struct ExploreItemView: View {
    
    @State var project: Project
    @State var isNavigationBarHidden: Bool = true
    
    var body: some View {
        
        NavigationLink(destination: ContentAppItemView(project: project))  {
            
            VStack {
                HStack(spacing: 15) {
                    
                    Image(project.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .padding(0)
                        .background(Color("AppAccent1"))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                    
                    HStack(spacing: 3) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text(project.title)
                                .font(.headline)
                                .padding(.bottom, 2)
                            
                            HStack(spacing: 5) {
                                Image(systemName: "list.bullet")
                                    .font(.caption)
                                    .padding(6)
                                    .background(Color("AppAccent1"))
                                    .clipShape(RoundedRectangle(cornerRadius: 3))
                                
                                Text("\(Project.all().count) списка").font(.caption)
                                
                            }
                        }
                        
                        Spacer()
                        if (project.date != nil) {
                            Text(project.date ?? "")
                                .font(.caption)
                                .padding(.vertical, 5)
                                .padding(.horizontal, 10)
                                .background(Color("AppAccent1"))
                                .clipShape(RoundedRectangle(cornerRadius: 3))
                        }
                        
                    }
                    
                    Spacer()
                    
                }
            }.padding()
            
//            VStack(alignment: .leading) {
//                HStack(alignment: .center) {
//                    VStack(alignment: .leading) {
//                        Text(project.title)
//                            .font(.title)
//                            .padding(.bottom, 2)
//
//                        if (project.subtitle != nil) {
//                            Text(project.subtitle ?? "")
//                                .font(.caption)
//                        }
//                    }
//
//                    Spacer()
//                }
//
//                Spacer()
//
//                if (project.image != "") {
//                    HStack(alignment: .center) {
//                        Image(project.image)
//                            .resizable()
//                            .scaledToFit()
//                            .padding(.vertical, 7)
//                    }
//                }
//
//                HStack(alignment: .center) {
//                    if (project.date != nil) {
//                        Text(project.date ?? "")
//                            .font(.caption)
//                            .padding(.horizontal, 20)
//                            .padding(.vertical, 7)
//                            .background(Color("AppAccent1").opacity(1))
//                            .clipShape(RoundedRectangle(cornerRadius: 7))
//
//                    }
//                }
//            }.padding()
        }.buttonStyle(PlainButtonStyle())
        
//        .shadow(color: Color.white.opacity(0.8), radius: 10, x: 0, y: 3)
    }
}

struct BannerSubscribe: View {
    var body: some View {
        
    ZStack {

        Image("")
            .resizable()
            .edgesIgnoringSafeArea(.vertical)
            .background(
                LinearGradient(gradient: Gradient(colors: [Color("BgGradientLeft"), Color("BgGradientRight")]),startPoint: .leading, endPoint: .trailing)
//                LinearGradient(gradient:  Gradient(colors: [Color("BgGradientLeft"), Color("BgGradientCenter")]))
            )
            .clipShape(RoundedRectangle(cornerRadius: 10))
        
        HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Get premium")
                        .font(.headline)
                        .fontWeight(.medium)
                    Text("Unlock all feauture, pay one month 2$ and get full access.")
                        .font(.caption)
                        .fontWeight(.light)
                    Button(action: {
                        
                    }){
                        Text("Buy premium for 1 month")
                            .font(.caption)
                            .fontWeight(.light)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 10)
                            .background(Color.purple)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                    }
                }
                
                Spacer()
                
                Image("bannerPay")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150)
                    .padding(.trailing, -25)
//                    .padding(0)
//                    .background(Color("AppAccent1"))
//                    .clipShape(RoundedRectangle(cornerRadius: 10))ырфвщц
                
            }.padding(.horizontal, 20)
                .padding(.vertical ,0)
                .foregroundColor(Color.white)

        
        }
        .padding(.horizontal, 20)
        .padding(.top, 30)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .frame(width: UIScreen.main.bounds.width, height: 180)
        
    }
}

