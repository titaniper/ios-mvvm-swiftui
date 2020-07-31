//
//  Array+suffle.swift
//  ios-mvvm-swiftui
//
//  Created by kang juyoung on 2020/07/31.
//  Copyright © 2020 jooyoung. All rights reserved.
//

import Foundation

extension Array {
    var suffle: Element? {
        count == 1 ? first : nil
    }
}
