//
//  DeviceDataService.swift
//  DeviceDiagnostics
//
//  Created by Igor Karyi on 07.08.2025.
//

import Foundation
import UIKit
import Combine

final class DeviceDataService: ObservableObject {
    static let shared = DeviceDataService()

    @Published var batteryLevel: Float = 0.0

    private var dispatchTimer: DispatchSourceTimer?
    private var backgroundTaskID: UIBackgroundTaskIdentifier = .invalid

    private init() {
        UIDevice.current.isBatteryMonitoringEnabled = true
        batteryLevel = UIDevice.current.batteryLevel
        startTimer()
    }

    /// Starts a DispatchSourceTimer that fires every 2 minutes
    private func startTimer() {
        guard dispatchTimer == nil else {
            print("Dispatch timer already running")
            return
        }

        print("Starting dispatch timer")

        let timer = DispatchSource.makeTimerSource(queue: DispatchQueue.global(qos: .background))
        timer.schedule(deadline: .now(), repeating: Config.dataSyncInterval)
        timer.setEventHandler { [weak self] in
            DispatchQueue.main.async {
                self?.startBackgroundTask()
            }
        }

        timer.resume()
        dispatchTimer = timer
    }

    /// Stops the timer if needed
    private func stopTimer() {
        dispatchTimer?.cancel()
        dispatchTimer = nil
        print("Dispatch timer stopped")
    }

    /// Data submission and background update
    private func startBackgroundTask() {
        backgroundTaskID = UIApplication.shared.beginBackgroundTask(withName: Config.backgroundTaskName) {
            UIApplication.shared.endBackgroundTask(self.backgroundTaskID)
            self.backgroundTaskID = .invalid
        }

        batteryLevel = UIDevice.current.batteryLevel
        print("Battery Level: \(batteryLevel)")
        sendBatteryDataToServer()

        UIApplication.shared.endBackgroundTask(backgroundTaskID)
        backgroundTaskID = .invalid
    }

    /// Sending data to the server
    private func sendBatteryDataToServer() {
        let data = BatteryData(level: batteryLevel)
        NetworkService.shared.send(data, to: APIEndpoint.sendBatteryData, useBase64: true)
    }
}
