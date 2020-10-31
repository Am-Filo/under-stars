//
//  Project.swift
//  under-stars
//
//  Created by Lami Qv on 19.03.2020.
//  Copyright © 2020 Lami Qv. All rights reserved.
//

import SwiftUI
import Combine

struct Project: Identifiable,Hashable {
    var id = UUID()
    var image: String
    var title: String
    var subtitle: String?
    var date: String?
    var color: String?
}

extension Project {
    static func all() -> [Project] {
        return [
            Project(image: "man", title: "Учеба", subtitle: "посещение 5ти городов", date: "14.09.2020", color: "#eac4e4"),
            Project(image: "girl-2", title: "Уход", color: "#dda79e"),
            Project(image: "girl-3", title: "Путешестиве", date: "01.05.2020", color: "#fffde2"),
            Project(image: "girl-4", title: "Музыка", subtitle: "однодневная поездка", date: "11.07.2020", color: "#8bd6bb")
        ]
    }
}

struct Menu: Identifiable,Hashable {
    var id = UUID()
    var name: String
    var icon: String
    var color_active: String
    var active: Bool
}

class MainMenu: ObservableObject {
    var mainMenuItems: [Menu] = [
        Menu(name: "search", icon: "icon_search", color_active: "purple", active: false),
        Menu(name: "explore", icon: "icon_explore", color_active: "orange", active: true),
        Menu(name: "profile", icon: "icon_profile", color_active: "blue", active: false)
    ]

}
