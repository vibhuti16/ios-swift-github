//
//  ApiService.swift
//  GithubRepositoriesList
//
//  Created by Hasmukh Shah on 28/01/26.
//

import Foundation
import Combine


protocol ApiServiceType{
    func response<Request>(from request: Request) -> AnyPublisher<Request.Response, APIServiceError> where Request: ApiRequestServiceType
}

final class ApiService : ApiServiceType{
    
    private let baseURL: URL
    init(baseURL: URL = URL(string: "https://api.github.com")!) {
        self.baseURL = baseURL
    }
    
    func response<Request>(from request: Request) -> AnyPublisher<Request.Response, APIServiceError> where Request: ApiRequestServiceType {
    
        let pathURL = URL(string: request.path, relativeTo: baseURL)!
        
        var urlComponents = URLComponents(url: pathURL, resolvingAgainstBaseURL: true)!
        urlComponents.queryItems = request.queryItems
        var request = URLRequest(url: urlComponents.url!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let decorder = JSONDecoder()
        decorder.keyDecodingStrategy = .convertFromSnakeCase
        return URLSession.shared.dataTaskPublisher(for: request)
            .map { data, urlResponse in data }
            .mapError { _ in APIServiceError.responseError }
            .decode(type: Request.Response.self, decoder: decorder)
            .mapError(APIServiceError.parseError)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    
}
