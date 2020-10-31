////
////  test.swift
////  under-stars
////
////  Created by Lami Qv on 30.04.2020.
////  Copyright © 2020 Lami Qv. All rights reserved.
////
//
//import SwiftUI
//
//struct test: View {
//    var body: some View {
//        
//        TestPreview()
//    }
//}
//
//struct test_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
//
//struct TestPreview : View {
//    
//    @State var index = 1
//    @State var offset : CGFloat = UIScreen.main.bounds.width
//    var width = UIScreen.main.bounds.width
//    
//    var body: some View{
//        
//        VStack(spacing: 0){
//            
//            AppBar(index: self.$index, offset: self.$offset)
//            
//            GeometryReader{g in
//                
//                HStack(spacing: 0){
//                    
//                    First()
//                        .frame(width: g.frame(in : .global).width)
//                    
//                    Scnd()
//                        .frame(width: g.frame(in : .global).width)
//                    
//                    Third()
//                        .frame(width: g.frame(in : .global).width)
//                }
//                .offset(x: self.offset)
//                .highPriorityGesture(DragGesture()
//                
//                .onEnded({ (value) in
//                
//                    if value.translation.width > 50{// minimum drag...
//                        
//                        print("right")
//                        self.changeView(left: false)
//                    }
//                    if -value.translation.width > 50{
//                        
//                        print("left")
//                        self.changeView(left: true)
//                    }
//                }))
//                
//            }
//        }
//        .animation(.default)
//        .edgesIgnoringSafeArea(.all)
//    }
//    
//    func changeView(left : Bool){
//        
//        if left{
//            
//            if self.index != 3{
//                
//                self.index += 1
//            }
//        }
//        else{
//            
//            if self.index != 1{
//                
//                self.index -= 1
//            }
//        }
//        
//        if self.index == 1{
//            
//            self.offset = self.width
//        }
//        else if self.index == 2{
//            
//            self.offset = 0
//        }
//        else{
//            
//            self.offset = -self.width
//        }
//        // change the width based on the size of the tabs...
//    }
//}
//
//
//struct First : View {
//    
//    var body: some View{
//        
//        ScrollView(.vertical, showsIndicators: false) {
//            
//            VStack(spacing:0){
//                
//                ForEach(1...5,id: \.self){i in
//                    
//                    Text("1111111")
//                }
//            }
//            
//        }.padding(.bottom, 18)
//    }
//}
//
//struct Scnd : View {
//    
//    var body: some View{
//        
//        GeometryReader{_ in
//            
//            VStack{
//                
//                Text("Second View")
//            }
//        }
//        .background(Color.white)
//    }
//}
//
//struct Third : View {
//    
//    var body: some View{
//        
//        GeometryReader{_ in
//            
//            VStack{
//                
//                Text("Third View")
//            }
//        }
//        .background(Color.white)
//    }
//}
