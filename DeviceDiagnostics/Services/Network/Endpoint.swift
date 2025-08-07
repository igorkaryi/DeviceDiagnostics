//
//  Endpoint.swift
//  DeviceDiagnostics
//
//  Created by Igor Karyi on 07.08.2025.
//

import Foundation

protocol Endpoint {
    var path: String { get }
    var method: HTTPMethod { get }
}
