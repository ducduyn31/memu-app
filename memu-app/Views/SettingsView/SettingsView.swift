//
//  SettingsView.swift
//  MemuAI
//
//  Created by Kane Thuong on 8/5/2024.
//

import SwiftUI

struct SettingsView: View {
    let mockSettings: [ListSettingSession] = [
        ListSettingSession(imageName: "person.crop.circle", titleMessage: "Account"),
        ListSettingSession(imageName: "hand.thumbsup.circle", titleMessage: "Subscriptions"),
        ListSettingSession(imageName: "note.text", titleMessage: "Privacy & Policies"),
        ListSettingSession(imageName: "exclamationmark.circle.fill", titleMessage: "About Memu"),
    ]

    var body: some View {
        NavigationStack{
            ZStack {
                VStack {
                    UserProfile()
                    VStack {
                        ListSettings(settings:  mockSettings)
                    }
                    Spacer()
                }
                .padding(.top, 150)
                Title(label: "Settings")
                    .ignoresSafeArea()
                    .position(x: 214.9, y: 50)
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    SettingsView()
}
