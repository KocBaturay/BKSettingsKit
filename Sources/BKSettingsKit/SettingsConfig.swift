//
//  SettingsConfig.swift
//  BKSettingsKit
//
//  Created by Baturay Koc on 10/14/25.
//

import Foundation

public struct SettingsConfig {
    public let appVersion: String
    public let companyName: String
    public let isUserSubscribed: Bool
    
    public init(
        appVersion: String,
        companyName: String,
        isUserSubscribed: Bool = false
    ) {
        self.appVersion = appVersion
        self.companyName = companyName
        self.isUserSubscribed = isUserSubscribed
    }
}
