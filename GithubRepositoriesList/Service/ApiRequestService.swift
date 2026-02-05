//
//  ApiRequestService.swift
//  GithubRepositoriesList
//
//  Created by Hasmukh Shah on 28/01/26.
//

import Foundation

protocol ApiRequestServiceType{
    associatedtype Response: Decodable
    
    var path: String { get }
    var queryItems: [URLQueryItem]? { get }
}

final class ApiRequestService : ApiRequestServiceType{
    typealias Response = GithubRepositoryList
    
    var path: String { return "/search/repositories" }
    var queryItems: [URLQueryItem]? {
        return [
            .init(name: "q", value: "SwiftUI"),
            .init(name: "order", value: "desc")
        ]
    }
    
    
}
