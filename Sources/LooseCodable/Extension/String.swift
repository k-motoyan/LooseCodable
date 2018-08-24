//
//  String.swift
//  LooseCodable
//
//  Created by k-motoyan on 2018/07/21.
//  Copyright © 2018年 k-motoyan. All rights reserved.
//

import Foundation

extension String {

    func toBool() -> Bool? {
        switch self.uppercased() {
        case "TRUE":
            return true
        case "FALSE":
            return false
        default:
            return nil
        }
    }

    func toInt() -> Int? {
        if let doubleValue = Double(self) {
            return NSNumber(value: doubleValue).intValue
        } else if let intValue = Int(self) {
            return intValue
        } else {
            return nil
        }
    }

    func toDouble() -> Double? {
        if let doubleValue = Double(self) {
            return doubleValue
        } else {
            return nil
        }
    }

}
