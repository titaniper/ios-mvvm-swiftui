//
//  Pie.swift
//  ios-mvvm-swiftui
//
//  Created by kang juyoung on 2020/09/01.
//  Copyright © 2020 jooyoung. All rights reserved.
//

import SwiftUI

struct Pie: Shape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool = false
    
    func path(in rect:CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let redius = min(rect.width, rect.height) / 2
        let start = CGPoint(x: center.x + redius * cos(CGFloat(startAngle.radians)), y: center.x + redius * sin(CGFloat(startAngle.radians)))
        
        var p = Path()
        p.move(to: center)
        p.addLine(to: start)
        p.addArc(center: center, radius: redius, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
        
        return p
    }
}
