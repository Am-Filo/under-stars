//
//  ContentAppItemView.swift
//  under-stars
//
//  Created by Lami Qv on 05.03.2020.
//  Copyright © 2020 Lami Qv. All rights reserved.
//

import SwiftUI
import Combine
import Firebase

struct projectMenu: Identifiable,Hashable {
    var id = UUID()
    var title: String
    var icon: String
    var color: String
    var type: String
}

var projectMenuData: [projectMenu] = [
    projectMenu(title: "Поездка", icon: "bag.fill", color: "#fb8c7a", type: "timeline"),
    projectMenu(title: "Что поесть", icon: "cube.box.fill", color: "#c667fa", type: "check-list-double"),
    projectMenu(title: "Расходы", icon: "dollarsign.circle", color: "#bdcaef", type: "check-list-double"),
    projectMenu(title: "Отели", icon: "h.circle.fill", color: "#bde3ef", type: "check-list-double"),
    projectMenu(title: "Развлечения", icon: "e.circle.fill", color: "#efbdca", type: "check-list-double"),
    projectMenu(title: "Информация", icon: "exclamationmark.circle", color: "#e3efbd", type: "list-double")
]

//struct ContentAppItemView: View {
//    
//    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
//    
//    @State var project: Project
//    @State var projectMenuTitle = UserDefaults.standard.value(forKey: "menuTitle") as? String ?? ""
//    
//    var body: some View {
//        
//        ScrollView {
//            
//            VStack(spacing: 30) {
//                
//                ZStack(alignment: .leading) {
//
//                    HStack(alignment: .center){
//                        Image(project.image)
//                            .renderingMode(.original)
//                            .resizable()
//                            .scaledToFit()
//                            .frame(height: 200)
////                            .padding(.top)
//                    }
//                    .frame(width: UIScreen.main.bounds.width, height: 250)
//                    .background(Color(hex: "\(project.color!)"))
//                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .circular)).edgesIgnoringSafeArea(.all)
//                    
//                    Button(action: {
//                        self.presentationMode.wrappedValue.dismiss()
//                    }) {
//                        Image(systemName: "arrow.left.circle.fill")
//                            .foregroundColor(Color("AppAccent1"))
//                            .font(.title)
//                    }.padding(.top, -60)
//                    .padding(.leading, 20)
//                    
//                    HStack {
//                        Text(project.title)
//                            .font(.body)
//                            .fontWeight(.bold)
//                            .padding(.horizontal, 15)
//                            .padding(.vertical, 8)
//                            .background(Color.black.opacity(0.5))
//                            .cornerRadius(10)
//                          
//                    } .frame(height: 20)
//                    .padding(.top, 180)
//                    .padding(.leading, 20)
//  
//                    
//                    
//                }.padding(.top, 50)
//
//                
////                HStack(alignment: .bottom) {
////                   Text(project.title)
////                       .padding(.trailing,5)
////                       .font(.title)
////
////                   Text(project.subtitle ?? "")
////                       .padding(.trailing,10)
////                       .font(.subheadline)
////                       .foregroundColor(.gray)
////                       .padding(.bottom,5)
////               }
//                
//                ScrollView(.horizontal, showsIndicators: false) {
//                    HStack(spacing: 15) {
//                        ForEach (projectMenuData) { menu in
//                                
//                            VStack {
//                                Button(action: {
//                                    
//                                    UserDefaults.standard.set(menu.title, forKey: "menuTitle")
//                                    NotificationCenter.default.post(name: NSNotification.Name("menuTitleChange"), object: nil)
//                                    
//                                }) {
//                                    VStack(alignment: .center){
//                                        Image(systemName: "\(menu.icon)")
//                                            .foregroundColor(Color("TextAccent"))
//                                            .font(.title)
//                                    }
//                                    .frame(width: 60, height: 60)
//                                    .background(Color(hex: "\(menu.color)"))
//                                    .clipShape(RoundedRectangle(cornerRadius: 10))
//                                }
//                                
//                            }.frame(width: 60, height: 60)
//                                
//                            
//                        }
//                    }
//                }.frame(height: 60).padding(.horizontal, 20)
//           
////               HStack {
////
////                   ZStack(alignment: .leading){
////                       Image("stars")
////                               .resizable()
////                               .clipShape(RoundedRectangle(cornerRadius: 10))
////
////                       Text("информация о поездке")
////                           .font(.caption)
////                           .padding(.horizontal, 8)
////                           .padding(.vertical, 5)
////                           .zIndex(1)
////                           .foregroundColor(.black)
////                           .background(Color.white.opacity(0.9))
////                           .overlay(
////                               RoundedRectangle(cornerRadius: 5)
////                                   .stroke(Color.purple, lineWidth: 0)
////                           )
////                           .clipShape(RoundedRectangle(cornerRadius: 5))
////                           .offset(x: 10, y: 50)
////
////                   }.frame(width: UIScreen.main.bounds.width/2-20, height: 150)
////
////                   Spacer()
////
////                   VStack{
////
////                       TestWrappedLayout()
////
////                   }.frame(width: UIScreen.main.bounds.width/2-20, height: 150)
////
////
////               }
//           
//           
//               HStack(alignment: .bottom) {
//                   
//                   Text(self.projectMenuTitle)
//                       .padding(.trailing,10)
//                       .font(.headline)
//                       .onAppear {
//                           NotificationCenter.default.addObserver(forName: NSNotification.Name("menuTitleChange"), object: nil, queue: .main) { (_) in
//                               
//                               let projectMenuTitle = UserDefaults.standard.value(forKey: "menuTitle") as? String ?? ""
//                               self.projectMenuTitle = projectMenuTitle
//                               
//                           }
//                       }
//                   
//               }
//                
//                
//            }
//            
//            
// 
//            
////            VStack(alignment: .leading) {
////
////                HStack(alignment: .bottom) {
////                    Text(project.title)
////                        .padding(.trailing,5)
////                        .font(.title)
////
////                    Text(project.subtitle ?? "")
////                        .padding(.trailing,10)
////                        .font(.subheadline)
////                        .foregroundColor(.gray)
////                        .padding(.bottom,5)
////                }
////
////                HStack {
////
////                    ZStack(alignment: .leading){
////                        Image("stars")
////                                .resizable()
////                                .clipShape(RoundedRectangle(cornerRadius: 10))
////
////                        Text("информация о поездке")
////                            .font(.caption)
////                            .padding(.horizontal, 8)
////                            .padding(.vertical, 5)
////                            .zIndex(1)
////                            .foregroundColor(.black)
////                            .background(Color.white.opacity(0.9))
////                            .overlay(
////                                RoundedRectangle(cornerRadius: 5)
////                                    .stroke(Color.purple, lineWidth: 0)
////                            )
////                            .clipShape(RoundedRectangle(cornerRadius: 5))
////                            .offset(x: 10, y: 50)
////
////                    }.frame(width: UIScreen.main.bounds.width/2-20, height: 150)
////
////                    Spacer()
////
////                    VStack{
////
////                        TestWrappedLayout()
////
////                    }.frame(width: UIScreen.main.bounds.width/2-20, height: 150)
////
////
////                }
////
////
////                HStack(alignment: .bottom) {
////
////                    Text(self.projectMenuTitle)
////                        .padding(.trailing,10)
////                        .font(.headline)
////                        .onAppear {
////                            NotificationCenter.default.addObserver(forName: NSNotification.Name("menuTitleChange"), object: nil, queue: .main) { (_) in
////
////                                let projectMenuTitle = UserDefaults.standard.value(forKey: "menuTitle") as? String ?? ""
////                                self.projectMenuTitle = projectMenuTitle
////
////                            }
////                        }
////
////                }
////
////
////            }.padding()
//            
//        }
//            
//        
//    }
//}

//struct ContentAppItemView_Previews: PreviewProvider {
//    
//     var isNavigationBarHidden: Bool = false
//    
//    static var previews: some View {
//        ContentAppItemView(isNavigationBarHidden: self.$isNavigationBarHidden, project: Project.all()[0])
//    }
//}


struct TestWrappedLayout: View {
    
    var body: some View {
        GeometryReader { geometry in
            self.generateContent(in: geometry)
        }
    }

    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero

        return ZStack(alignment: .center) {
            
            ZStack(alignment: .topLeading) {
                
                ForEach(projectMenuData, id: \.self) { platform in
                    self.item(for: platform.icon,color: platform.color, title: platform.title)
                        .padding([.horizontal, .vertical], 4)
                        .alignmentGuide(.leading, computeValue: { d in
                            if (abs(width - d.width) > g.size.width)
                            {
                                width = 0
                                height -= d.height
                            }
                            let result = width
                            if platform == projectMenuData.last! {
                                width = 0 //last item
                            } else {
                                width -= d.width
                            }
                            return result
                        })
                        .alignmentGuide(.top, computeValue: {d in
                            let result = height
                            if platform == projectMenuData.last! {
                                height = 0 // last item
                            }
                            return result
                        })
                }
                
            }
            
        }.padding(.top,20)
    }

    func item(for icon: String, color: String, title: String) -> some View {
        
        Button(action: {
            
            UserDefaults.standard.set(title, forKey: "menuTitle")
            NotificationCenter.default.post(name: NSNotification.Name("menuTitleChange"), object: nil)
            
        }) {
            Image(systemName: icon)
                .padding(.all, 12)
                .font(.custom("semilarge", size: 25))
//                .background(Color.blue)
                .foregroundColor(Color(color))
                .cornerRadius(5)
        }

        
    }
}
