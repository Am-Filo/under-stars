//
//  SearchView.swift
//  under-stars
//
//  Created by Lami Qv on 19.03.2020.
//  Copyright © 2020 Lami Qv. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    var body: some View {
        GeometryReader{_ in

            VStack{
            

                        Text("Search new todo notes")
                Spacer()
            }
        }
        .background(Color("backgroundAllApp"))

    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
