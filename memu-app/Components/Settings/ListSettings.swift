//
//  ListSettings.swift
//  memu-app
//
//  Created by David on 9/5/2024.
//

import SwiftUI

struct ListSettings: View {
    var settings: [ListSettingSession] = []
    
    var body: some View {
            ForEach(settings) { ListSettingSession in
                ListSettingItem(session: ListSettingSession)
        }
    }
}

#Preview {
    ListSettings(settings: [
        ListSettingSession(imageName: "person.crop.circle", titleMessage: "Account"),
        ListSettingSession(imageName: "hand.thumbsup.circle", titleMessage: "Subscriptions"),
        ListSettingSession(imageName: "note.text", titleMessage: "Privacy & Policies"),
        ListSettingSession(imageName: "exclamationmark.circle.fill", titleMessage: "About Memu"),
    ])
}
