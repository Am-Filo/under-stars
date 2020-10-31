//
//  OldAppView.swift
//  under-stars
//
//  Created by Lami Qv on 30.04.2020.
//  Copyright © 2020 Lami Qv. All rights reserved.
//

import SwiftUI

struct AppViewOld: View {
    
    @EnvironmentObject var session: SessionStore
    
    @State var showProfile: Bool = false
    @State var searchText: String = ""
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                HStack {
                     Button(action: {
                        self.showProfile.toggle()
                        }
                    ) {
                        ImageView(withURL: "\(self.session.get().photoURL!)")
                            .scaledToFit()
                            .frame(width: 45, height: 45)
                            .clipShape(Circle())

                    }.sheet(isPresented: $showProfile) {
                        Profile(show: self.$showProfile).environmentObject(self.session)
                        }.buttonStyle(PlainButtonStyle()).frame(width: 45, height: 45).padding()
                    
                    Spacer()
                }.padding(.horizontal, 10)
                .padding(.vertical, 5)
                    
                ScrollView {
                    
                    Text("Hello!").contextMenu {
                        
                        NavigationLink(destination: Text("Email").navigationBarTitle("New Email Page", displayMode: .inline)) {
                            Text("Email")
                            Image(systemName: "envelope.fill")
                        }
                           Button(action: {}) {
                               Text("Linkedin")
                           }
                       }
                    
                    HStack {
                        Text("Hello \(self.session.get().displayName!)")
                            .font(.title)
                            .fontWeight(.bold)
                        Spacer()
                    }.padding(.bottom, 10)
                    .padding(.top, 20)
                    
                    HStack {
                        
                        if (self.searchText == "") {
                            Image(systemName: "magnifyingglass")
                                .font(.body)
                                .padding(.trailing, 8)
                                .foregroundColor(.gray)
                        }
                        
                        TextField("Search for todos and users...", text: $searchText)
                            .font(.callout)
                        
                    }.padding(.vertical, 13)
                    .padding(.horizontal, 25)
                    .background(Color("AppAccent1").opacity(1))
                    .cornerRadius(15)
                    .padding(.bottom, 20)
                    
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
                                            .background(Color(hex: "\(project.color!)"))
                                            .clipShape(RoundedRectangle(cornerRadius: 20))
                                            
                                                Text(project.title)
                                                    .fontWeight(.medium)
                                                    .font(.footnote)
                                                    .padding(.top, 2)
                                                    .foregroundColor(Color("TextAccent"))
                                        
                                        }.frame(width: 100, height: 125)
                                        
                                    }
                                    
                                }
                            }
                        }.frame(height: 125)
                    }.padding(.bottom, 20)
                    
                    Spacer()
                }.padding(.horizontal, 30)
                
            }.navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }
}
