//
//  User.swift
//  GithubRepositoriesList
//
//  Created by Hasmukh Shah on 28/01/26.
//

import Foundation
import SwiftUI

struct User : Decodable, Hashable, Identifiable{
    var id: Int64
    var login: String
    var avatarUrl: URL
    
}
