//
//  CustomNavBarContainerView.swift
//  memu-app
//
//  Created by Jonathan on 9/5/2024.
//

import SwiftUI

struct CustomNavBarContainerView <Content: View>: View {
    
    let content: Content
    let title: String
    
    init(title: String, @ViewBuilder content: () -> Content){
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        ZStack(){
            content.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
            CustomNavBarView(title: title)
        }
    }
}

#Preview {
    CustomNavBarContainerView(title: "hello"){
        Text("Hello World")
    }
}
