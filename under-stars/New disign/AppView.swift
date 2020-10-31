//
//  AppView.swift
//  under-stars
//
//  Created by Lami Qv on 30.04.2020.
//  Copyright © 2020 Lami Qv. All rights reserved.
//

import SwiftUI
import AVKit

extension Color {
    init(hex string: String) {
        var string: String = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if string.hasPrefix("#") {
            _ = string.removeFirst()
        }

        // Double the last value if incomplete hex
        if !string.count.isMultiple(of: 2), let last = string.last {
            string.append(last)
        }

        // Fix invalid values
        if string.count > 8 {
            string = String(string.prefix(8))
        }

        // Scanner creation
        let scanner = Scanner(string: string)

        var color: UInt64 = 0
        scanner.scanHexInt64(&color)

        if string.count == 2 {
            let mask = 0xFF

            let g = Int(color) & mask

            let gray = Double(g) / 255.0

            self.init(.sRGB, red: gray, green: gray, blue: gray, opacity: 1)

        } else if string.count == 4 {
            let mask = 0x00FF

            let g = Int(color >> 8) & mask
            let a = Int(color) & mask

            let gray = Double(g) / 255.0
            let alpha = Double(a) / 255.0

            self.init(.sRGB, red: gray, green: gray, blue: gray, opacity: alpha)

        } else if string.count == 6 {
            let mask = 0x0000FF
            let r = Int(color >> 16) & mask
            let g = Int(color >> 8) & mask
            let b = Int(color) & mask

            let red = Double(r) / 255.0
            let green = Double(g) / 255.0
            let blue = Double(b) / 255.0

            self.init(.sRGB, red: red, green: green, blue: blue, opacity: 1)

        } else if string.count == 8 {
            let mask = 0x000000FF
            let r = Int(color >> 24) & mask
            let g = Int(color >> 16) & mask
            let b = Int(color >> 8) & mask
            let a = Int(color) & mask

            let red = Double(r) / 255.0
            let green = Double(g) / 255.0
            let blue = Double(b) / 255.0
            let alpha = Double(a) / 255.0

            self.init(.sRGB, red: red, green: green, blue: blue, opacity: alpha)

        } else {
            self.init(.sRGB, red: 1, green: 1, blue: 1, opacity: 1)
        }
    }
}
extension Array {
    func dividedIntoGroups(of i: Int = 3) -> [[Element]] {
        var copy = self
        var res = [[Element]]()
        while copy.count > i {
            res.append( (0 ..< i).map { _ in copy.remove(at: 0) } )
        }
        res.append(copy)
        return res
    }
}

struct CustomTextField: UIViewRepresentable {

    class Coordinator: NSObject, UITextFieldDelegate {

        @Binding var text: String
        var didBecomeFirstResponder = false

        init(text: Binding<String>) {
            _text = text
        }

        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }

    }

    @Binding var text: String
    var isFirstResponder: Bool = false

    func makeUIView(context: UIViewRepresentableContext<CustomTextField>) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.delegate = context.coordinator
        return textField
    }

    func makeCoordinator() -> CustomTextField.Coordinator {
        return Coordinator(text: $text)
    }

    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<CustomTextField>) {
        uiView.text = text
        if isFirstResponder && !context.coordinator.didBecomeFirstResponder  {
            uiView.becomeFirstResponder()
            context.coordinator.didBecomeFirstResponder = true
        }
    }
}


struct AppView: View {
    
    @EnvironmentObject var session: SessionStore
    
    @State var showProfile: Bool = false
    @State var searchText: String = ""
    @State var searchActive: Bool = false
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                VStack {
                
                    HStack(alignment: .center) {
                         
                         if (self.searchText == "") {
                             Image(systemName: "magnifyingglass")
                                 .font(.caption)
                                 .padding(.leading, 5)
                                 .foregroundColor(.gray)
                         }
                         
                         TextField("Search for todos and users...", text: $searchText).font(.caption)
                        
                        if (self.searchText != "") {
                            Button(action: {
                                self.searchText = ""
                            }, label: {
                                Image(systemName: "xmark.circle.fill")
                                      .font(.caption)
                                      .padding(.trailing, 5)
                                      .foregroundColor(.gray)
                            })
                        }
                        
                     }.padding(.vertical, 8)
                     .padding(.horizontal, 20)
                     .background(Color("bg-light-1"))
                     .cornerRadius(.infinity)
                     .padding(.bottom, 20)
                     .padding(.top, -10)
                     .animation(.spring())
                    
                    VStack {
                        HStack {
                            Text("My Todos")
                                .font(.headline)
                                .fontWeight(.medium)
                        
                            Spacer()
                        }.padding(.bottom, 10)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 25) {
                                ForEach (Project.all()) { project in
                                        
                                    NavigationLink(destination: ContentAppItemView(project: project))  {
                                        VStack {
                                            VStack(alignment: .center){
                                                Image(project.image)
                                                    .renderingMode(.original)
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 80, height: 80)
                                            }
                                            .frame(width: 100, height: 100)
                                            .background(Color(hex: "\(project.color!)").opacity(0.5))
                                            .clipShape(RoundedRectangle(cornerRadius: .infinity))
                                            
                                                Text(project.title)
                                                    .fontWeight(.medium)
                                                    .font(.footnote)
                                                    .padding(.top, 2)
                                                    .foregroundColor(Color("TextAccent"))
                                        
                                        }.frame(width: 100, height: 125)
                                        .contextMenu {
                                         
                                         NavigationLink(destination: ContentAppItemView(project: project)) {
                                             Text("Open")
                                             Image(systemName: "list.bullet.below.rectangle")
                                         }
                                            Button(action: {}) {
                                                Text("Share")
                                                Image(systemName: "square.and.arrow.up.fill")
                                            }
                                        }
                                        
                                    }
                                    
                                }
                            }
                        }.frame(height: 125)
                    }.padding(.bottom, 20)
                    
                    Spacer()
                    
                }.padding(30)
                .navigationBarItems(leading:
                    
                    VStack(alignment: .leading) {
                         Text("Welcome")
                             .font(.caption)
                            .foregroundColor(Color("text-1").opacity(0.5))
                         Text("\(self.session.get().displayName!)")
                             .font(.subheadline)
                            .foregroundColor(Color("purple"))
                            .fontWeight(.bold)
                    }
                    
                , trailing:
                    
                    Button(action: {
                        self.showProfile.toggle()
                     }) {
                        ImageView(withURL: "\(self.session.get().photoURL!)")
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())

                    }.sheet(isPresented: $showProfile) {
                        Profile(show: self.$showProfile).environmentObject(self.session)
                    }.buttonStyle(PlainButtonStyle())
                
                ).navigationBarTitle("", displayMode: .inline).navigationBarBackButtonHidden(true)
            }
        }.onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
        }
    }
}

struct ContentAppItemView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var project: Project
    @State var projectMenuTitle = UserDefaults.standard.value(forKey: "menuTitle") as? String ?? ""
    
    var body: some View {
        
        ScrollView {
            
            VStack(spacing: 30) {

                    HStack(alignment: .center) {
                        Image(project.image)
                            .renderingMode(.original)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                    }
                    .frame(width: UIScreen.main.bounds.width-60, height: 220)
                    .background(Color(hex: "\(project.color!)"))
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .circular))
                    .padding(.top, 15)
  
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach (projectMenuData) { menu in
                                
                            VStack {
                                Button(action: {
                                    
                                    UserDefaults.standard.set(menu.title, forKey: "menuTitle")
                                    NotificationCenter.default.post(name: NSNotification.Name("menuTitleChange"), object: nil)
                                    
                                }) {
                                    VStack(alignment: .center){
                                        Image(systemName: "\(menu.icon)")
                                            .foregroundColor(self.projectMenuTitle == menu.title ? Color(.white) : Color(hex: "\(menu.color)"))
                                            .font(.title)
                                    }
                                    .frame(width: 55, height: 55)
                                    .background( self.projectMenuTitle == menu.title ? Color(hex: "\(menu.color)") : Color("bg-light-1"))
                                    .clipShape(RoundedRectangle(cornerRadius: self.projectMenuTitle == menu.title ? 20 : 10))
                                }.animation(.spring())
                                
                            }.frame(width: 55, height: 55)
                                
                            
                        }
                    }
                }.frame(height: 55)
           
           
               HStack {
                   
                   Text(self.projectMenuTitle)
                       .padding(.trailing,10)
                       .font(.headline)
                       .onAppear {
                           NotificationCenter.default.addObserver(forName: NSNotification.Name("menuTitleChange"), object: nil, queue: .main) { (_) in
                               
                               let projectMenuTitle = UserDefaults.standard.value(forKey: "menuTitle") as? String ?? ""
                               self.projectMenuTitle = projectMenuTitle
                               
                           }
                       }
                
                    Spacer()
                   
               }
                
            Spacer()
                
                
            }.navigationBarItems(leading: Button(action: { }) {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "arrow.left.circle.fill")
                        .foregroundColor(Color("text-1"))
                        .font(.title)
                }
            }).navigationBarBackButtonHidden(true)
              .navigationBarTitle("\(project.title)", displayMode: .inline)
              .padding(.horizontal, 30)
            
   
        }
    }
}

struct ColorSelect: View {
    
    @State var colorArray: Array<[String]> = ["#eac9c4","#e3b8b1","#dda79e","#d6968b","#cf8578","#c97465","#c4eadc","#8bd6bb","#8bd6af","#78cfb0","#65c9a5","#8bccd6","#c4d1ea","#b1c3e3","#9eb4dd","#8ba6d6","#7898cf","#6589c9","#fb9180","#e88979","#ee8573","#f4816d","#fa7c67","#f9674e","#fffde2","#fffcc8","#fffaaf","#fff995","#fff87c","#fff996","#eac4e4","#e3b1dc","#dd9ed3","#d68bcb","#cf78c3","#c965ba"].dividedIntoGroups(of: 6);
    @State var selectedColor: String = "";
    
    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
            ForEach(colorArray, id: \.self) { colorRow in
                HStack(spacing: 15) {
                    ForEach(colorRow, id: \.self) { color in
                        Button(action: {
                            self.selectedColor = color;
                        }) {
                            HStack {
                                Color(hex: "\(color)")
                                
                            }.frame(width: 50, height: 50)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .shadow(color: Color(hex: "\(color)").opacity(0.8), radius: 5, x: 0, y: 0)
                        }
                    }
                }
                
            }
        }
            
            Text(self.selectedColor)
        }
    }
}

struct Profile: View {
    
    @EnvironmentObject var session: SessionStore
    @Binding var show : Bool
    
    @State var showEdit:Bool = false
    
    func signOut () {
        let _ = session.signOut()
    }
    
    var body : some View {
        
        VStack{
        
            HStack(spacing: 10) {
                
                ImageView(withURL: "\(self.session.get().photoURL!)")
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .padding(.horizontal, 15)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("\(self.session.get().displayName!)")
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
            .padding(.top, 20)
            .sheet(isPresented: self.$showEdit) {
                EditProfile(showEdit: self.$showEdit).environmentObject(self.session)
            }
            
            BannerSubscribe().padding(.top, -20)
        
            Spacer()
        
        }
        
    }
}

struct EditProfile: View {
    
    @EnvironmentObject var session: SessionStore
    
    @Binding var showEdit: Bool
    
    var body: some View {
        
        VStack(spacing: 10) {
            
            ImageView(withURL: "\(self.session.get().photoURL!)")
                 .scaledToFit()
                 .frame(width: 150)
                 .clipShape(Circle())
            
            Divider()
            
            Text(self.session.get().displayName ?? "NONE")
            Text(self.session.get().email ?? "NONE")
            
            Divider()
            
            Button(action: {
                self.showEdit.toggle()
            }){
                Text("Close")
                    .font(.caption)
                    .fontWeight(.light)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 10)
                    .background(Color("AppAccent1"))
                    .foregroundColor(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
            }
            
            Spacer()
            
        }
        
    }
}



#if DEBUG
struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AppView().environment(\.colorScheme, .light)
        }
    }
}
#endif
