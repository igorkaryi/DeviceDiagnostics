//
//  APIEndpoint.swift
//  DeviceDiagnostics
//
//  Created by Igor Karyi on 07.08.2025.
//

import Foundation

enum APIEndpoint: Endpoint {
    case sendBatteryData

    var path: String {
        switch self {
        case .sendBatteryData:
            return "posts"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .sendBatteryData:
            return .post
        }
    }
}
