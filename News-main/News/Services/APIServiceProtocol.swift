//
//  APIServiceProtocol.swift
//  News
//
//  Created by KozlovKonstantin on 19.11.2024.
//

import Foundation
import Combine

protocol APIServiceProtocol {
    func fetchResponse(from url: URL) -> AnyPublisher<Response, Error>
}
