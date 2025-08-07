//
//  BatteryViewModel.swift
//  DeviceDiagnostics
//
//  Created by Igor Karyi on 07.08.2025.
//

import Foundation
import Combine

final class BatteryViewModel: ObservableObject {
    @Published var batteryLevel: Float = 0.0
    
    private var cancellables = Set<AnyCancellable>()
    
    init(service: DeviceDataService = .shared) {
        service.$batteryLevel
            .receive(on: DispatchQueue.main)
            .assign(to: \.batteryLevel, on: self)
            .store(in: &cancellables)
    }
}
