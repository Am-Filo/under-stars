//
//  ContentView.swift
//  under-stars
//
//  Created by Lami Qv on 02.03.2020.
//  Copyright © 2020 Lami Qv. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    
    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
    
    var body: some View {
        
        Color("appbackground")
//        .edgesIgnoringSafeArea(.vertical) // Ignore just for the color
        .overlay(
            VStack {

                if status {
//                    HomeView()
                    MainView()
                }
                else {
                    AuthView().padding()
                }

            }.animation(.spring())
            .onAppear {
                NotificationCenter.default.addObserver(forName: NSNotification.Name("statusChange"), object: nil, queue: .main) { (_) in
                    let status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
                    self.status = status
                }
            }
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home: View {
    
    var body : some View {
        ContentAppView()
    }
    
}
