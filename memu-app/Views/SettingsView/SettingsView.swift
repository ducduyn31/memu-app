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
                    HStack {
                        Image("Avatar6")
                            .resizable()
                            .frame(width:64,height:64)
                            .clipShape(.circle)
                            .padding()
                        Text("Anna Lee")
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
