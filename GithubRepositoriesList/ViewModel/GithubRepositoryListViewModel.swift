//
//  RepositoryViewModel.swift
//  GithubRepositoriesList
//
//  Created by Hasmukh Shah on 28/01/26.
//

import Foundation
import Combine
import SwiftUI

final class GithubRepositoryListViewModel : ObservableObject, UnidirectionalDataFlowType{
    typealias InputType = Input

    private var cancellables: [AnyCancellable] = []
    
    // MARK: Input
    enum Input {
        case onAppear
    }
    func apply(_ input: Input) {
        switch input {
        case .onAppear: onAppearSubject.send(())
        }
    }
    private let onAppearSubject = PassthroughSubject<Void, Never>()
    
    
    @Published private(set) var repositories: [GithubRespository] = []
    @Published var isErrorShown = false
    @Published var errorMessage = ""
    
    private let responseSubject = PassthroughSubject<GithubRepositoryList, Never>()
    private let errorSubject = PassthroughSubject<APIServiceError, Never>()
    
    private let apiService: ApiServiceType
    
    init(apiService: ApiServiceType = ApiService()) {
        self.apiService = apiService
        
        bindInputs()
        bindOutputs()
    }
    
    private func bindInputs() {
        let request = ApiRequestService()
        let responsePublisher = onAppearSubject
            .flatMap { [apiService] _ in
                apiService.response(from: request)
                    .catch { [weak self] error -> Empty<GithubRepositoryList, Never> in
                        self?.errorSubject.send(error)
                        return .init()
                }
        }
        
        let responseStream = responsePublisher
            .share()
            .sink { [weak self] value in
                self?.responseSubject.send(value)
            }
        

        
        cancellables += [
            responseStream
        ]
    }
    
    private func bindOutputs() {
        let repositoriesStream = responseSubject
            .map { $0.items }
            .assign(to: \.repositories, on: self)
        
        let errorMessageStream = errorSubject
            .map { error -> String in
                switch error {
                case .responseError: return "network error"
                case .parseError: return "parse error"
                }
            }
            .assign(to: \.errorMessage, on: self)
        
        let errorStream = errorSubject
            .map { _ in true }
            .assign(to: \.isErrorShown, on: self)
        
        
        cancellables += [
            repositoriesStream,
            errorStream,
            errorMessageStream
        ]
    }
}

