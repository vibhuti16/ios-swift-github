//
//  GithubRepositoryDetailViewModel.swift
//  GithubRepositoriesList
//
//  Created by Hasmukh Shah on 28/01/26.
//

import Foundation
import Combine

final class GithubRepositoryDetailViewModel : ObservableObject{
    let objectWillChange: AnyPublisher<GithubRepositoryListViewModel, Never>
    let objectWillChangeSubject = PassthroughSubject<GithubRepositoryListViewModel, Never>()
    
    let repository: GithubRespository
    
    init(repository: GithubRespository) {
        objectWillChange = objectWillChangeSubject.eraseToAnyPublisher()
        self.repository = repository
    }
}
