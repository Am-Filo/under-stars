//
//  ProjectClasses.swift
//  under-stars
//
//  Created by Lami Qv on 21.03.2020.
//  Copyright © 2020 Lami Qv. All rights reserved.
//

import SwiftUI
import Firebase
import GoogleSignIn
import Combine

// User model from Authenticate

class User {
    @Published var uid: String
    @Published var email: String?
    @Published var displayName: String?
    @Published var photoURL: URL?

    init(uid: String, displayName: String?, email: String?, photoURL: URL?) {
        self.uid = uid
        self.email = email
        self.displayName = displayName
        self.photoURL = photoURL
    }
}

// User Info model from Database / Users

class UserInfo {
    @Published var username: String?
    @Published var premium: Bool?
    @Published var todonotes: Array<Any>?
    @Published var follow: Array<Any>?

    init(follow: Array<Any>?, premium: Bool?, todonotes: Array<Any>?, username: String?) {
        self.username = username
        self.premium = premium
        self.todonotes = todonotes
        self.follow = follow
    }
}

// TodoNote List Collection model from Database / TodoNote / Collections

//class TodoNoteCollection {
//    @Published var username: String?
//    @Published var premium: Bool?
//    @Published var todonotes: Array<Any>?
//    @Published var follow: Array<Any>?
//
//    init(follow: Array<Any>?, premium: Bool?, todonotes: Array<Any>?, username: String?) {
//        self.username = username
//        self.premium = premium
//        self.todonotes = todonotes
//        self.follow = follow
//    }
//}

// TodoNote model from Database / TodoNote
//
//struct TodoNote: Identifiable {
//    let id: UUID
//    let ref: DatabaseReference?
//    let title: String
//    let is_private: Bool
//    let owner: String
//    let image: String?
//    let followers: Array<String>?
//    let edit_date: Data?
//    let date: Data
//
//    init(title: String, is_private: Bool, owner: String, image: String?, followers: Array<Any>?, edit_date: Data?, date: Data) {
//        self.ref = nil
//        self.title = title
//        self.is_private = is_private
//        self.owner = owner
//        self.image = image ?? nil
//        self.followers = (followers as! Array<String>)
//        self.edit_date = edit_date ?? nil
//        self.date = date
//    }
//
//    init?(snapshot: DataSnapshot) {
//        guard
//            let value = snapshot.value as? [String: AnyObject],
//            let title = value["title"] as? String,
//            let is_private = value["is_private"] as? Bool,
//            let owner = value["owner"] as? String,
//            let image = value["image"] as? String,
//            let followers = value["followers"] as? Array<String>?,
//            let edit_date = value["edit_date"] as? Data?,
//            let date = value["date"] as? Data
//            else {
//                return nil
//            }
//
//        self.ref = snapshot.ref
//        self.title = title
//        self.is_private = is_private
//        self.owner = owner
//        self.image = image
//        self.followers = followers
//        self.edit_date = edit_date
//        self.date = date
//    }
//
//    func toAnyObject() -> Any {
//        return [
//            "title": title,
//            "is_private": is_private,
//            "owner": owner,
//            "image": image ?? nil!,
//            "followers": followers ?? nil!,
//            "edit_date": edit_date ?? nil!,
//            "date": date
//        ]
//    }
//
//}

// User Session in Application model from Database / TodoNote

class SessionStore : ObservableObject {
    @Published var session: User? { didSet { self.didChange.send(self) }}
    @Published var userInfo: UserInfo?
//    @Published var todoNote: [TodoNote] = []
    
    var didChange = PassthroughSubject<SessionStore, Never>()
    var handle: AuthStateDidChangeListenerHandle?

    var ref: DatabaseReference = Database.database().reference(withPath: "\(String(describing: Auth.auth().currentUser?.uid ?? "Error"))")
    

    func listen () {
        // monitor authentication changes using firebase
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                // if we have a user, create a new user model
                print("Got user: \(user)")
                self.session = User(
                    uid: user.uid,
                    displayName: user.displayName,
                    email: user.email,
                    photoURL: user.photoURL)
                
//                let db = Firestore.firestore()
//                let docRef = db.collection("cities").document("SF")

//                docRef.getDocument { (document, error) in
//                    if let document = document, document.exists {
//                        let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
//                        print("Document data: \(dataDescription)")
//                    } else {
//                        print("Document does not exist")
//                    }
//                }
                
//                self.ref.observe(DataEventType.value) { (snapshot) in
//                    self.userInfo = UserInfo(
//                        username: snapshot.username,
//                        premium: snapshot.premium,
//                        todonotes: snapshot.todonotes,
//                        follow: snapshot.follow
//                    )
//                }

                
            } else {
                // if we don't have a user, set our session to nil
                self.session = nil
            }
        }
    }
    
    func get() -> User {
        return session!
    }
    
    func signUp(
            email: String,
            password: String,
            handler: @escaping AuthDataResultCallback
        ) {
        Auth.auth().createUser(withEmail: email, password: password, completion: handler)
    }

    func signIn(
            email: String,
            password: String,
            handler: @escaping AuthDataResultCallback
        ) {
        Auth.auth().signIn(withEmail: email, password: password, completion: handler)
    }


    func signOut () -> Bool {
        do {
            try Auth.auth().signOut()
            self.session = nil
            return true
        } catch {
            return false
        }
    }
    
//    func getTodoNotes() {
//        ref.observe(DataEventType.value) { (snapshot) in
//            self.items = []
//            for child in snapshot.children {
//                if let snapshot = child as? DataSnapshot,
//                    let todoNote = TodoNote(snapshot: snapshot) {
//                    self.items.append(todoNote)
//                }
//            }
//        }
//    }
    
//    func uploadTodoNotes(todoNote: String) {
//        //Generates number going up as time goes on, sets order of TODO's by how old they are.
//        let number = Int(Date.timeIntervalSinceReferenceDate * 1000)
//
//        let postRef = ref.child(String(number))
//        let post = TodoNote(todo: todoNote, isComplete: "false")
//        postRef.setValue(post.toAnyObject())
//    }
//
    func updateTodoNotes(key: String, todo: String, isComplete: String) {
        let update = ["todo": todo, "isComplete": isComplete]
        let childUpdate = ["\(key)": update]
        ref.updateChildValues(childUpdate)
    }
    
    func unbind () {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
}


class ImageLoader: ObservableObject {
    var didChange = PassthroughSubject<Data, Never>()
    var data = Data() {
        didSet {
            didChange.send(data)
        }
    }

    init(urlString:String) {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.data = data
            }
        }
        task.resume()
    }
}

//
//struct TodoNote1: Identifiable {
//
//    let ref: DatabaseReference?
//    let key: String
//    let todo: String
//    let isComplete: String
//    let id: String
//
//    init(todo: String, isComplete: String, key: String = "") {
//        self.ref = nil
//        self.key = key
//        self.todo = todo
//        self.isComplete = isComplete
//        self.id = key
//
//    }
//
//    init?(snapshot: DataSnapshot) {
//        guard
//            let value = snapshot.value as? [String: AnyObject],
//            let todo = value["todo"] as? String,
//            let isComplete = value["isComplete"] as? String
//            else {
//                return nil
//            }
//
//        self.ref = snapshot.ref
//        self.key = snapshot.key
//        self.todo = todo
//        self.isComplete = isComplete
//        self.id = snapshot.key
//
//    }
//
//    func toAnyObject() -> Any {
//        return [
//            "todo": todo,
//            "isComplete": isComplete,
//
//        ]
//    }
//}
