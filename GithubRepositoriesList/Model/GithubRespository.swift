//
//  GithubRespository.swift
//  GithubRepositoriesList
//
//  Created by Hasmukh Shah on 28/01/26.
//

import Foundation
import SwiftUI

struct GithubRespository : Decodable, Hashable, Identifiable {
    
    var id: Int64
    var fullName: String
    var description: String?
    var stargazersCount: Int = 0
    var language: String?
    var owner: User
    
    
}
