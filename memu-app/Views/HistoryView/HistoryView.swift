//
//  HistoryView.swift
//  memu-app
//
//  Created by Kane Thuong on 8/5/2024.
//
import SwiftUI

// The Text displays the last message in the session.
struct HistoryView: View { 
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    // Displaying the HistoryList with the mockHistory data
                    HistoryList()
                }
                .padding(.top, 110) // Adding padding to the top of the VStack
                // Displaying a custom navigation bar with the title "Translation History"
                CustomNavBarView(title: "Translation History", initialOffsetY: 85, hasBackButton: false)
            }
            .ignoresSafeArea() // Ignoring the safe area constraints
        }
    }
}

 #Preview {
    HistoryView()
}
