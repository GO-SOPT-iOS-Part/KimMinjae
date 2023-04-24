//
//  NSObject+.swift
//  SOPTving
//
//  Created by 김민재 on 2023/04/24.
//

import Foundation


extension NSObject {
    static var className: String {
        return String(describing: self)
    }
}
