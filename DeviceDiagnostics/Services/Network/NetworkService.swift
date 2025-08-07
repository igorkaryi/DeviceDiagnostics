//
//  NetworkService.swift
//  DeviceDiagnostics
//
//  Created by Igor Karyi on 07.08.2025.
//

import Foundation

final class NetworkService {

    static let shared = NetworkService()
    private init() {}

    /// Send data to the server, optionally encoding body in Base64
    func send<T: Encodable>(_ data: T, to endpoint: Endpoint, useBase64: Bool = false) {
        do {
            let jsonData = try JSONEncoder().encode(data)

            guard let url = URL(string: Config.baseUrl + endpoint.path) else {
                print("Bad URL")
                return
            }

            if endpoint.method == .get {
                print("GET method must not have a body — request aborted")
                return
            }

            var request = URLRequest(url: url)
            request.httpMethod = endpoint.method.rawValue

            let bodyData: Data
            if useBase64 {
                request.setValue("text/plain", forHTTPHeaderField: "Content-Type")
                bodyData = Data(jsonData.base64EncodedString().utf8)
            } else {
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                bodyData = jsonData
            }

            request.httpBody = bodyData

            print("Sending request to: \(url.absoluteString)")
            print("Method: \(endpoint.method.rawValue)")
            print("Headers: \(request.allHTTPHeaderFields ?? [:])")
            print("Body: \(String(data: bodyData, encoding: .utf8) ?? "nil")")

            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Network error: \(error.localizedDescription)")
                    return
                }

                if let httpResponse = response as? HTTPURLResponse {
                    print("Sent with status code: \(httpResponse.statusCode)")
                    if httpResponse.statusCode >= 400 {
                        let responseString = data.flatMap { String(data: $0, encoding: .utf8) } ?? "nil"
                        print("Server error response: \(responseString)")
                    }
                }
            }.resume()
        } catch {
            print("Encoding error: \(error.localizedDescription)")
        }
    }
}
