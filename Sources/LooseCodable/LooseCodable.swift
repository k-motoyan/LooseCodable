//
//  LooseCodable.swift
//  LooseCodable
//
//  Created by k-motoyan on 2018/07/21.
//  Copyright © 2018年 k-motoyan. All rights reserved.
//

import Foundation

public struct LooseCodable<T: LooseCodableType>: Codable {

    public let value: T

    public init(from decoder: Decoder) throws {
        let svc = try decoder.singleValueContainer()

        switch T.self {
        case let t as Bool.Type:
            self.value = try svc.looseDecode(t) as! T
        case let t as Int.Type:
            self.value = try svc.looseDecode(t) as! T
        case let t as Double.Type:
            self.value = try svc.looseDecode(t) as! T
        case let t as String.Type:
            self.value = try svc.looseDecode(t) as! T
        default:
            fatalError("LooseCodable dose not support \(T.self) type.")
        }
    }

    public func encode(to encoder: Encoder) throws {
        var svc = encoder.singleValueContainer()

        switch T.self {
        case is Bool.Type:
            try svc.encode(self.value as! Bool)
        case is Int.Type:
            try svc.encode(self.value as! Int)
        case is Double.Type:
            // When encoding to Double, errors may occur.
            // For this reason, encode and cast to Decimal.
            let decimalValue = NSNumber(value: self.value as! Double).decimalValue
            try svc.encode(decimalValue)
        case is String.Type:
            try svc.encode(self.value as! String)
        default:
            fatalError("LooseCodable dose not support \(T.self) type.")
        }
    }

}
