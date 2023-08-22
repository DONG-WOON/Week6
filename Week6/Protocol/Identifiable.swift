//
//  Identifiable.swift
//  Week6
//
//  Created by 서동운 on 8/22/23.
//

import Foundation

protocol Identifiable {
    static var identifier: String { get }
}

extension Identifiable {
    static var identifier: String {
        return String(describing: self)
    }
}
