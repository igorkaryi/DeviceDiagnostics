//
//  DeviceDiagnosticsApp.swift
//  DeviceDiagnostics
//
//  Created by Igor Karyi on 07.08.2025.
//

import SwiftUI

@main
struct DeviceDiagnosticsApp: App {
    
    init() {
        _ = DeviceDataService.shared
    }
    
    var body: some Scene {
        WindowGroup {
            BatteryView()
        }
    }
}
