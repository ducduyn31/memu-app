//
//  ListSettings.swift
//  memu-app
//
//  Created by David on 9/5/2024.
//

import SwiftUI

struct ListSettings: View {
    var setting: [ListSettingSession] = []
    
    var body: some View {
        ForEach(setting) { ListSettingSession in
            ListSettingItem(session: ListSettingSession)
        }
    }
}

#Preview {
    ListSettings(setting: [
        ListSettingSession(imageName: "person.crop.circle", titleMessage: "Account", screen: .account),
        ListSettingSession(imageName: "hand.thumbsup.circle", titleMessage: "Subscriptions", screen: .subscription),
        ListSettingSession(imageName: "exclamationmark.circle.fill", titleMessage: "About Memu", screen: .about)
    ])
}
