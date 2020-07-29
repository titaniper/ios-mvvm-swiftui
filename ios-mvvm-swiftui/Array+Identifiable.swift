//
//  Array+Identifiable.swift
//  ios-mvvm-swiftui
//
//  Created by kang juyoung on 2020/07/29.
//  Copyright © 2020 jooyoung. All rights reserved.
//

import Foundation

extension Array where Element: Identifiable {
    func firstIndex(matching: Element) -> Int? {
        for index in 0..<self.count {
            if self[index].id == matching.id {
                return index
            }
        }
        return 0 // TODO: bogus
    }
}
