//
//  CustomNavBarView.swift
//  memu-app
//
//  Created by Jonathan on 9/5/2024.
//

import SwiftUI

//the custom navigation bar
struct CustomNavBarView: View {
    @State var title: String
    var initialOffsetY: Double = 85
    
    @Environment(\.dismiss) var dismissView
    var hasBackButton: Bool = true
    
    @State private var dragOffset: CGFloat = 0
    @State private var isCollapsed = false
    @State private var offsetY: Double = 0
    
    var body: some View {
        ZStack {
            UnevenRoundedRectangle()
                .fill(.blue)
                .clipShape(
                    .rect(
                        topLeadingRadius: 0,
                        bottomLeadingRadius: 60,
                        bottomTrailingRadius: 60,
                        topTrailingRadius: 0
                    )
                )
            VStack {
                Spacer()
                if !isCollapsed {
                    HStack {
                        if hasBackButton {
                            
                            //when the button is pressed, it will dismiss the current screen
                            //hence it is equivalent to the back button in NagivationLink
                            Button(action: {
                                dismissView()
                            }, label: {
                                Image(systemName: "chevron.left")
                                    .resizable()
                                    .foregroundStyle(.white)
                                    .frame(width: 15, height: 20)
                            })
                        }
                        Text(title)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                        Spacer()
                    }
                    .padding()
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: 1700)
        .position(x: UIScreen.main.bounds.width / 2, y: offsetY - 800)
        .offset(y: dragOffset)
        .ignoresSafeArea()
        .gesture(
            DragGesture()
                .onChanged { value in
                    dragOffset = value.translation.height
                }
                .onEnded { value in
                    if value.translation.height > 50 {
                        self.offsetY = initialOffsetY
                        isCollapsed = false
                    } else if value.translation.height < -50 {
                        self.offsetY = 20
                        isCollapsed = true
                    }
                    dragOffset = 0
                }
        )
        .onTapGesture {
            if isCollapsed {
                self.offsetY = initialOffsetY
                isCollapsed = false
            }
        }
        .animation(.spring())
        .background(
            GeometryReader { geometry in
                Color.clear
                    .onAppear {
                        offsetY = isCollapsed ? 20: initialOffsetY
                    }
            }
        )
    }
}

#Preview {
    CustomNavBarView(title: "Title")
}
