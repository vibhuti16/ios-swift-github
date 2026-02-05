//
//  GithubRepositoriesListApp.swift
//  GithubRepositoriesList
//
//  Created by Hasmukh Shah on 28/01/26.
//

import SwiftUI

@main
struct GithubRepositoriesListApp: App {
    var body: some Scene {
        WindowGroup {
            GitRepositoryLineView(viewModel: GithubRepositoryListViewModel())
        }
    }
}
