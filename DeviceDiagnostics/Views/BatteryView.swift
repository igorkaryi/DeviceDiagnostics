//
//  BatteryView.swift
//  DeviceDiagnostics
//
//  Created by Igor Karyi on 07.08.2025.
//

import SwiftUI

struct BatteryView: View {
    @StateObject private var viewModel = BatteryViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Battery Level")
                .font(.title)

            Text("\(Int(viewModel.batteryLevel * 100))%")
                .font(.system(size: 48, weight: .bold))
                .foregroundColor(.green)
        }
        .padding()
    }
}
