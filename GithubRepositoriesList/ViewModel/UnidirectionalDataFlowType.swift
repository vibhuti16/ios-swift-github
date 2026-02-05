//
//  UnidirectionalDataFlowType.swift
//  GithubRepositoriesList
//
//  Created by Hasmukh Shah on 28/01/26.
//

import Foundation

protocol UnidirectionalDataFlowType{
    associatedtype InputType
    
    func apply(_ input: InputType)
}
