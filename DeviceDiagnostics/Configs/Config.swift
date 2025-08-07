//
//  Config.swift
//  DeviceDiagnostics
//
//  Created by Igor Karyi on 07.08.2025.
//

import Foundation

final class Config {
    static let dataSyncInterval: TimeInterval = 2 * 60
    static let baseUrl = "https://jsonplaceholder.typicode.com/"
    static let backgroundTaskName = "SendBatteryData"
}
