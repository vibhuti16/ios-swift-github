//
//  ListDetailView.swift
//  GithubRepositoriesList
//
//  Created by Hasmukh Shah on 28/01/26.
//

import SwiftUI

struct ListDetailView: View {
    @ObservedObject var viewModel: GithubRepositoryDetailViewModel

    var body: some View {
        VStack{
            Text(viewModel.repository.fullName)
                .padding(10)
            Text(viewModel.repository.description ?? "").padding(10)
            Text("\(viewModel.repository.stargazersCount)"+" stars")
        }
    }
}

#Preview {
    ListDetailView(
        viewModel: .init(
            repository: GithubRespository(
                id: 1,
                fullName: "foo",
                owner: User(
                    id: 1,
                    login: "bar",
                    avatarUrl: URL(string: "http://baz.com")!
                )
            )
        )
    )
}
