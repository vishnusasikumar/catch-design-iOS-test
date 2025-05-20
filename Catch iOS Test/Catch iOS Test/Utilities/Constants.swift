//
//  Constants.swift
//  Catch iOS Test
//
//  Created by Admin on 20/05/2025.
//

import Foundation

struct Constants {
    /// Configure the URL for our request.
    /// In this case, an example JSON response..
    static let baseURL = "https://raw.githubusercontent.com/"
    static let urlComponents = URLComponents(string: baseURL)!
    static let dataURL: String = "\(baseURL)/catchnz/ios-test/master/data/data.json"
    static let dataURLComponents = URLComponents(string: dataURL)!
}
