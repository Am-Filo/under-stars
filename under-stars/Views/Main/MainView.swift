//
//  MainView.swift
//  under-stars
//
//  Created by Lami Qv on 21.03.2020.
//  Copyright © 2020 Lami Qv. All rights reserved.
//

import SwiftUI
import Firebase
import GoogleSignIn


struct MainView: View {
    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
    
    @EnvironmentObject var session: SessionStore
    
    func getUser () {
        session.listen()
    }
    
    var body: some View {
        VStack {
            
            if (session.session != nil) {
//                HomeView()
                AppView()
            }
            else {
                AuthView().padding()
            }
        }
        .onAppear {
            self.getUser()
        }
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
