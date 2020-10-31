//
//  ContentItemView.swift
//  under-stars
//
//  Created by Lami Qv on 03.03.2020.
//  Copyright © 2020 Lami Qv. All rights reserved.
//

import SwiftUI
import Combine
import Firebase
import GoogleSignIn


struct ContentAppView: View {

    @State var showProfile = false
    @State var isNavigationBarHidden: Bool = true
    
    var body: some View {
            
        NavigationView {
            
            VStack {
            
                List (Project.all()) { project in
                    
                    NavigationLink(destination: ContentAppItemView(project: project))  {
                        VStack(alignment: .leading) {
                            HStack {
                                Image(project.image)
                                    .resizable()
                                    .frame(width: 60, height: 60, alignment: .center)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                    .padding(.trailing, 10)
                                
                                VStack(alignment: .leading) {
                                    Text(project.title)
                                        .fontWeight(.medium)
                                        .font(.headline)
                                        .padding(.bottom,5)
                                    
                                    Text(project.subtitle ?? "")
                                        .font(.subheadline)
                                        .fontWeight(.light)
                                        .foregroundColor(Color.init(.label))
                                        .opacity(0.75)
                                }
                                
                            }
                        }.onAppear {
                            self.isNavigationBarHidden = true
                        }
                    }.onAppear { UITableView.appearance().separatorStyle = .none } .onDisappear { UITableView.appearance().separatorStyle = .singleLine }
                    
                }.onAppear { UITableView.appearance().separatorStyle = .none } .onDisappear { UITableView.appearance().separatorStyle = .singleLine }
                
                
                
            }.navigationBarItems(leading:
                
                    Text("=").padding(.top, 10)
                
                , trailing:

                    Button(action: {

                        self.showProfile.toggle()

                        }
                    ) {

                        Image("stars")
                            .renderingMode(.original)
                            .resizable()
                            .frame(width: 40, height: 40, alignment: .center)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
    
                    }.sheet(isPresented: $showProfile) {
                        Profile(show: self.$showProfile)
                    }
                    .buttonStyle(PlainButtonStyle())
                )
            
        }
    }
}

struct ContentAppView_Previews: PreviewProvider {
    static var previews: some View {
        ContentAppView()
    }
}


struct profileProjects: View {
    
    @Binding var title : String
    @Binding var subtitle : String
    @Binding var image : String
    
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack {
                Image(self.image)
                    .resizable()
                    .frame(width: 40, height: 40, alignment: .center)
                    .overlay(Circle())
                    .clipShape(Circle())
                    .padding(.leading, 10)
                
                VStack(alignment: .leading) {
                    Text(self.title)
                        .fontWeight(.heavy)
                        .font(.largeTitle)
                        .padding(.bottom,5)
                    
                    Text(self.subtitle)
                        .font(.headline)
                        .fontWeight(.light)
                        .foregroundColor(Color.init(.label))
                        .opacity(0.75)
                }
                
            }
        }
    
    }
}
