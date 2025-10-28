//
//  SettingsItem.swift
//  BKSettingsKit
//
//  Created by Baturay Koc on 10/14/25.
//

import Foundation

public struct SettingsItem: Identifiable {
    public let id = UUID()
    public let title: String
    public let icon: String
    public let action: SettingsAction
    
    public init(title: String, icon: String, action: SettingsAction) {
        self.title = title
        self.icon = icon
        self.action = action
    }
}
