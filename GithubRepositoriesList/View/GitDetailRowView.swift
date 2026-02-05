//
//  GitDetailRow.swift
//  GithubRepositoriesList
//
//  Created by Hasmukh Shah on 28/01/26.
//

import SwiftUI

struct GitDetailRow: View {
    
    let gitRepository: GithubRespository
    
    var body: some View {
        NavigationLink(destination: ListDetailView(viewModel: GithubRepositoryDetailViewModel(repository: gitRepository))) {
            Text(gitRepository.fullName)
        }
    }
}

#if DEBUG
struct RepositoryListRow_Previews : PreviewProvider {
    static var previews: some View {
        GitDetailRow(gitRepository:
                            GithubRespository(
                id: 1,
                fullName: "foo",
                owner: User(id: 1, login: "bar", avatarUrl: URL(string: "baz")!)
            )
        )
    }
}
#endif

