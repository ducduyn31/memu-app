//
//  ListSettingSession.swift
//  memu-app
//
//  Created by David on 9/5/2024.
//

import Foundation
import SwiftUI

enum SettingScreen {
    case account
    case subscription
    case privacy
    case about
}

struct ListSettingSession: Identifiable {
    var id = UUID()
    let imageName: String
    let titleMessage: String
    let screen: SettingScreen
    
    @ViewBuilder
    func getScreen() -> some View {
        switch screen {
        case .account:
            EditAccountView()
        case .subscription:
            SubscriptionView()
        case .privacy:
            EditAccountView()
        case .about:
            AboutView()
        }
    }
    
}
