//
//  GitRepositoryLineView.swift
//  GithubRepositoriesList
//
//  Created by Hasmukh Shah on 28/01/26.
//

import SwiftUI

struct GitRepositoryLineView: View {
    
    @ObservedObject var viewModel: GithubRepositoryListViewModel
    
    var body: some View {
        NavigationView {
            List(viewModel.repositories) { repository in
                GitDetailRow(gitRepository: repository)
            }
            .alert(isPresented: $viewModel.isErrorShown, content: { () -> Alert in
                Alert(title: Text("Error"), message: Text(viewModel.errorMessage))
            })
            .navigationBarTitle(Text("Repositories"))
        }
        .onAppear(perform: { self.viewModel.apply(.onAppear) })
    }
}

#if DEBUG
struct RepositoryListView_Previews : PreviewProvider {
    static var previews: some View {
        GitRepositoryLineView(viewModel: .init())
    }
}
#endif
