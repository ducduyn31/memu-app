//
//  SettingsView.swift
//  memu-app
//
//  Created by Kane Thuong on 8/5/2024.
//

import SwiftUI

struct SettingsView: View {
    // Using AppStorage to store the user's name
    // The name will be displayed on the top of the screen
    @AppStorage("name") var name: String = ""
    
    // Creating a mock settings data
    // This data will be used to display the settings list
    let mockSettings: [ListSettingSession] = [
        ListSettingSession(imageName: "person.crop.circle", titleMessage: "Account", screen: .account),
        ListSettingSession(imageName: "hand.thumbsup.circle", titleMessage: "Subscriptions", screen: .subscription),
        ListSettingSession(imageName: "exclamationmark.circle.fill", titleMessage: "About Memu", screen: .about)
    ]
    
    var body: some View {
        NavigationStack{
            ZStack {
                VStack {
                    HStack {
                        Image("Avatar6")
                            .resizable()
                            .frame(width:64,height:64)
                            .clipShape(.circle)
                            .padding()
                        Text(name)
                            .font(.headline)
                            .foregroundColor(.black)
                            .fontWeight(.semibold)
                            .lineLimit(1)
                        Spacer()
                    }
                    VStack {
                        ListSettings(setting:  mockSettings)
                    }
                    Spacer()
                }
                .padding(.top, 150)
                // Displaying a custom navigation bar with the title "Settings"
                // The back button is hidden in the settings view
                CustomNavBarView(title: "Settings", hasBackButton: false, offsetY: 50)
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    SettingsView()
}
