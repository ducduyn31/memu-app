//
//  CustomNavLink.swift
//  memu-app
//
//  Created by Jonathan on 9/5/2024.
//

import SwiftUI

//a custom wrapper to replace the default NavigationLink with a stylized version
struct CustomNavLink<Label:View, Destination:View>: View {
    
    let title: String
    let destination: Destination
    let label: Label
    
    init(title: String, destination: Destination, @ViewBuilder label: () -> Label){
        self.title = title
        self.destination = destination
        self.label = label()
    }
    
    var body: some View {
        NavigationLink(
            destination: 
                CustomNavBarContainerView(title: title, content: {
                    destination
                })
                .toolbar(.hidden)
            ,
            label: {
                label
            })
    }
}

#Preview {
    NavigationView{
        CustomNavLink(title: "Title",
            destination: Text("Hello World")){
                Text("Click me")
            }
    }
}
