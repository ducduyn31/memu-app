//
//  ListSettingSession.swift
//  memu-app
//
//  Created by David on 9/5/2024.
//

import Foundation
import SwiftUI

// SettingScreen is an enumeration that represents the different screens that can be navigated to from the settings.
enum SettingScreen {
    case account       // Represents the account edit screen
    case subscription  // Represents the subscription screen
    case about         // Represents the about screen
}

// ListSettingSession is a struct that represents a setting item in a list.
struct ListSettingSession: Identifiable {
    var id = UUID()               // Unique identifier for each setting item
    let imageName: String         // Name of the image icon for the setting item
    let titleMessage: String      // Display text for the setting item
    let screen: SettingScreen     // The target screen when this setting item is selected

    // getScreen is a function that returns a SwiftUI View based on the screen enum.
    // This function is used to navigate to the appropriate screen when a setting item is selected.
    @ViewBuilder
    func getScreen() -> some View {
        switch screen {
        case .account:
            EditAccountView()     // Navigates to the EditAccountView screen
        case .subscription:
            SubscriptionView()    // Navigates to the SubscriptionView screen
        case .about:
            AboutView()           // Navigates to the AboutView screen
        }
    }
}
