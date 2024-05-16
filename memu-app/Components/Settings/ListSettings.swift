//
//  ListSettings.swift
//  memu-app
//
//  Created by David on 9/5/2024.
//

import SwiftUI

// ListSettings is a SwiftUI View that represents a list of setting items.
struct ListSettings: View {
    // The setting variable is an array of ListSettingSession objects.
    // Each object represents a setting item in the list.
    var setting: [ListSettingSession] = []
    
    // The body of the ListSettings view.
    var body: some View {
        // ForEach is used to create a list of setting items from the setting array.
        ForEach(setting) { ListSettingSession in
            // ListSettingItem is a SwiftUI View that represents a single setting item.
            // It is initialized with a ListSettingSession object from the setting array.
            ListSettingItem(session: ListSettingSession)
        }
    }
}

// Preview is a SwiftUI View that represents a preview of the ListSettings view.
// It is initialized with an array of ListSettingSession objects.
#Preview {
    ListSettings(setting: [
        // The first setting item navigates to the account screen when clicked.
        ListSettingSession(imageName: "person.crop.circle", titleMessage: "Account", screen: .account),
        // The second setting item navigates to the subscriptions screen when clicked.
        ListSettingSession(imageName: "hand.thumbsup.circle", titleMessage: "Subscriptions", screen: .subscription),
        // The third setting item navigates to the about screen when clicked.
        ListSettingSession(imageName: "exclamationmark.circle.fill", titleMessage: "About Memu", screen: .about)
    ])
}
