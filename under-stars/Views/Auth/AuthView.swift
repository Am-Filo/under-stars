//
//  AuthView.swift
//  under-stars
//
//  Created by Lami Qv on 19.03.2020.
//  Copyright © 2020 Lami Qv. All rights reserved.
//

import SwiftUI
//import Firebase
import GoogleSignIn

struct AuthView: View {
    var body: some View {
        Login()
    }
}


struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}


struct Login : View {
    
    @State var email = ""
    @State var msg = ""
    @State var pass = ""
    @State var alert = false
    
    @EnvironmentObject var session: SessionStore
    
    func signIn () {

        session.signIn(email: email, password: pass) { (result, error) in
            if error != nil {
                self.msg = error as! String
                self.alert.toggle()
            } else {
                self.email = ""
                self.pass = ""
            }
        }
    }

    
    var body: some View {
        
        VStack {
            
            Text("Sign In")
                .fontWeight(.heavy)
                .font(.largeTitle)
                .padding([.top,.bottom])
            
            VStack(alignment: .center) {
                
                VStack(alignment: .leading) {
                    
                    Text("Username")
                        .font(.headline)
                        .fontWeight(.light)
                        .foregroundColor(Color.init(.label))
                        .opacity(0.75)
                    
                    HStack {
                        
                        TextField("Enter Your Username", text: $email)
                        
//                        if email != "" {
//                            Image(systemName: "checkmark")
//                        }

                    }
                    
                    Divider()
                    
                }.padding(.bottom, 15)
                
                VStack(alignment: .leading) {
                    
                    Text("Password")
                        .font(.headline)
                        .fontWeight(.light)
                        .foregroundColor(Color.init(.label))
                        .opacity(0.75)
                    
                    SecureField("Enter Your Password", text: $pass)
                    
                    Divider()
                    
                }.padding(.horizontal, 6)
                
                Button(action: signIn
                    
//                    self.session.signIn(email: self.email, password: self.pass)
                    
//                    signInWithEmail(email: self.email, password: self.pass) { (verified, status) in
//
//                        if !verified {
//                            self.msg = status
//                            self.alert.toggle()
//                        }
//                        else {
//                            UserDefaults.standard.set(true, forKey: "status")
//                            NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
//                        }
//
//                    }
                    
                ) {
                    
                    Text("Sign In")
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width - 120)
                        .padding()
                    
                }.background(Color.init(.red))
                .clipShape(Capsule())
                .padding(.top, 45)
                
                BottomView()
                
            }.padding()
            .alert(isPresented: $alert) {

                Alert(title: Text("Error"), message: Text(self.msg), dismissButton: .default(Text("Ok")))
                    
            }
            
        }
    }
}

struct BottomView : View {
    
    @State var show = false
    
    var body: some View {
        
        VStack {
            Text("or")
                .foregroundColor(Color.gray.opacity(0.5))
                .padding(.top, 30)
            
            GoogleSignView().frame(width: 150, height: 55)
            
            HStack(spacing: 8) {
                Text("Don't Have An Account ?")
                    .foregroundColor(Color.gray.opacity(0.5))
                
                Button(action: {
                        
                    self.show.toggle()
                    
                }) {
                    Text("Sign Up")
                }.foregroundColor(.blue)
                
            }.padding(.top, 25)
            
        }.sheet(isPresented: $show) {
            
            signUp(show: self.$show)
            
        }
        
    }
}

struct signUp : View {
    
    @State var email = ""
    @State var msg = ""
    @State var pass = ""
    @State var alert = false
    @Binding var show : Bool
    
    @EnvironmentObject var session: SessionStore
    
    func signUp () {
        
        session.signUp(email: email, password: pass) { (result, error) in
            
            if error != nil {
                self.msg = error!.localizedDescription
                self.alert.toggle()
            }
            else {
                self.email = ""
                self.msg = ""
                self.pass = ""
//
//                UserDefaults.standard.set(true, forKey: "status")
                self.show.toggle()
//                NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
                
            }
        }
    }
    
    var body : some View {
        
        VStack {
        
            Text("Sign Up")
                .fontWeight(.heavy)
                .font(.largeTitle)
                .padding([.top,.bottom])
        
            VStack(alignment: .center) {
            
                VStack(alignment: .leading) {
                
                    Text("Username")
                        .font(.headline)
                        .fontWeight(.light)
                        .foregroundColor(Color.init(.label))
                        .opacity(0.75)
                    
                    HStack {
                        TextField("Enter Your Username", text: $email)
                    }
                    
                    Divider()
                    
                }.padding(.bottom, 15)
            
                VStack(alignment: .leading) {
                    
                    Text("Password")
                        .font(.headline)
                        .fontWeight(.light)
                        .foregroundColor(Color.init(.label))
                        .opacity(0.75)
                    
                    SecureField("Enter Your Password", text: $pass)
                    
                    Divider()
                    
                }.padding(.horizontal, 6)
            
                Button(action: signUp
//                    {
//
//                    signUpWithEmail(email: self.email, password: self.pass) { (verified, status) in
//
//                        if !verified {
//
//                            self.msg = status
//                            self.alert.toggle()
//
//                        }
//                        else {
//
//                            UserDefaults.standard.set(true, forKey: "status")
//
//                            self.show.toggle()
//
//                            NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
//
//                        }
//
//                    }
//
//                }
                ) {
                    
                    Text("Sign Up")
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width - 120)
                        .padding()
                    
                }.background(Color.init(.red))
                .clipShape(Capsule())
                .padding(.top, 45)
            }
        
        }.padding()
        .alert(isPresented: $alert) {

            Alert(title: Text("Error"), message: Text(self.msg), dismissButton: .default(Text("Ok")))
                
        }
    }
    
}


struct GoogleSignView: UIViewRepresentable {
    
    @EnvironmentObject var session: SessionStore
    
    func makeUIView(context: UIViewRepresentableContext<GoogleSignView>) -> GIDSignInButton {
        
        let button = GIDSignInButton()
        button.colorScheme = .dark
        GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.last?.rootViewController
        
        session.listen()
        return button
        
    }
    
    func updateUIView(_ uiView: GIDSignInButton, context: UIViewRepresentableContext<GoogleSignView>) {
    
    }
}
//
//func signInWithEmail(email: String, password: String, completion: @escaping(Bool,String) -> Void) {
//
//    Auth.auth().signIn(withEmail: email, password: password) { (res, err) in
//        if err != nil {
//            completion(false, (err?.localizedDescription)!)
//            return
//        }
//
//        completion(true, (res?.user.email)!)
//    }
//
//}
//
//
//func signUpWithEmail(email: String, password: String, completion: @escaping(Bool,String) -> Void) {
//
//    Auth.auth().createUser(withEmail: email, password: password){ (res, err) in
//
//        if err != nil {
//            completion(false, (err?.localizedDescription)!)
//            return
//        }
//
//        completion(true, (res?.user.email)!)
//
//    }
//
//}
