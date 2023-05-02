//
//  Array+.swift
//  SOPTving
//
//  Created by 김민재 on 2023/05/02.
//

import Foundation


extension Array {

    mutating func insertElementsBackAndForward() {
        self.insert(self[self.count - 1], at: 0)
        self.append(self[1])
    }
}
