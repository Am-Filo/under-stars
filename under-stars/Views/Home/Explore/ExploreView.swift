//
//  ExploreView.swift
//  under-stars
//
//  Created by Lami Qv on 19.03.2020.
//  Copyright © 2020 Lami Qv. All rights reserved.
//

import SwiftUI
import Foundation
import Combine


struct ExploreView: View {
    
    var body: some View {
        Text("ex")
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}

//
//struct ListTodoNoteView: View {
//    var body: some View {
//
//        ScrollView(.horizontal, showsIndicators: false) {
//            HStack(spacing: 20) {
//                ForEach (Project.all()) { project in
//                    GeometryReader { geometry in
//                        ExploreItemView(project: project)
//                            .rotation3DEffect(Angle(degrees: (Double(geometry.frame(in: .global).minX) - 20) / -20),
//                                              axis: (x: 0.0, y: 10.0, z: 0.0))
//                    }.frame(width: 250, height: 350)
//                }
//            }.padding(20)
//
//            Spacer()
//
//        }.frame(width: UIScreen.main.bounds.width,height: 380)
//
//    }
//}
//
//
//struct ExploreItemView: View {
//
//    @State var project: Project
//
//    var body: some View {
//
//        NavigationLink(destination: ContentAppItemView(project: project))  {
//            VStack(alignment: .leading) {
//                VStack(alignment: .leading) {
//                    Text(project.title)
//                        .font(.title)
//                        .padding(.bottom, 2)
//
//                    if (project.subtitle != nil) {
//                        Text(project.subtitle ?? "")
//                            .font(.caption)
//                    }
//                }
//
//                Spacer()
//
//                if (project.image != "") {
//                    Image(project.image)
//                        .resizable()
//                        .padding(.vertical, 7)
//
//                }
//
//                HStack(alignment: .center) {
//                    if (project.date != nil) {
//                        Text(project.date ?? "")
//                            .font(.caption)
//                            .padding(.horizontal, 20)
//                            .padding(.vertical, 7)
//                            .foregroundColor(.black)
//                            .background(Color.black.opacity(0.1))
//                            .clipShape(RoundedRectangle(cornerRadius: 10))
//
//                    }
//                }
//            }.padding()
//        }.buttonStyle(PlainButtonStyle())
//        .background(Color.white.opacity(0.8))
//        .foregroundColor(.black)
//        .clipShape(RoundedRectangle(cornerRadius: 25))
//        .shadow(color: Color.white.opacity(0.8), radius: 10, x: 0, y: 3)
//    }
//}
