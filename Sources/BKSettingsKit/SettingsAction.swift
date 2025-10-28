//
//  SettingsAction.swift
//  BKSettingsKit
//
//  Created by Baturay Koc on 10/14/25.
//

import Foundation

public enum SettingsAction {
    case rateApp(URL)
    case shareApp(String)
    case feedback(URL)
    case openURL(URL)
    case openSheet
    case custom(() -> Void)
}
