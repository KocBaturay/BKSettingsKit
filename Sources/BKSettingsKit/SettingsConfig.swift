//
//  SettingsConfig.swift
//  BKSettingsKit
//
//  Created by Baturay Koc on 10/14/25.
//

import Foundation

public struct SettingsConfig {
    public let appVersion: String
    public let appName: String
    public let isUserSubscribed: Bool
    
    public init(
        appVersion: String,
        appName: String,
        isUserSubscribed: Bool = false
    ) {
        self.appVersion = appVersion
        self.appName = appName
        self.isUserSubscribed = isUserSubscribed
    }
}
