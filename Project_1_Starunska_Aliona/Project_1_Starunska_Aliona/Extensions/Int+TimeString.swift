//
//  Int+TimeString.swift
//  Project_1_Starunska_Aliona
//
//  Created by Aliona Starunska on 19.01.2021.
//

import Foundation

extension Int {
    var time: String {
        let seconds = self % 60
        let minutes = self / 60
        let hours = self / 3600
        let optionalHours: Int? = hours > 0 ? hours : nil
        return [optionalHours, minutes, seconds]
            .compactMap({ $0 })
            .map({ $0 < 10 ? "0\($0)" : "\($0)" })
            .joined(separator: ":")
    }
}
