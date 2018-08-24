//
//  SingleValueDecodingContainer.swift
//  LooseCodable
//
//  Created by k-motoyan on 2018/07/21.
//  Copyright © 2018年 k-motoyan. All rights reserved.
//

import Foundation

extension SingleValueDecodingContainer {

    func looseDecode(_ type: Bool.Type) throws -> Bool {
        if let boolValue = try? self.decode(Bool.self) {
            return boolValue
        } else if let intValue = try? self.decode(Int.self) {
            return NSNumber(value: intValue).boolValue
        } else if let doubleValue = try? self.decode(Double.self) {
            return NSNumber(value: doubleValue).boolValue
        } else if let stringValue = try? self.decode(String.self), let boolValue = stringValue.toBool() {
            return boolValue
        }

        throw self.createTypeMismatchError(type)
    }

    func looseDecode(_ type: Int.Type) throws -> Int {
        if let boolValue = try? self.decode(Bool.self) {
            return NSNumber(value: boolValue).intValue
        } else if let intValue = try? self.decode(Int.self) {
            return intValue
        } else if let doubleValue = try? self.decode(Double.self) {
            return NSNumber(value: doubleValue).intValue
        } else if let stringValue = try? self.decode(String.self), let intValue = stringValue.toInt() {
            return intValue
        }

        throw self.createTypeMismatchError(type)
    }

    func looseDecode(_ type: Double.Type) throws -> Double {
        if let boolValue = try? self.decode(Bool.self) {
            return NSNumber(value: boolValue).doubleValue
        } else if let intValue = try? self.decode(Int.self) {
            return Double(intValue)
        } else if let doubleValue = try? self.decode(Double.self) {
            return doubleValue
        } else if let stringValue = try? self.decode(String.self), let doubleValue = stringValue.toDouble() {
            return doubleValue
        }

        throw self.createTypeMismatchError(type)
    }

    func looseDecode(_ type: String.Type) throws -> String {
        if let boolValue = try? self.decode(Bool.self) {
            return boolValue ? "true" : "false"
        } else if let intValue = try? self.decode(Int.self) {
            return "\(intValue)"
        } else if let doubleValue = try? self.decode(Double.self) {
            return "\(doubleValue)"
        } else if let stringValue = try? self.decode(String.self) {
            return stringValue
        }

        throw self.createTypeMismatchError(type)
    }

    private func createTypeMismatchError(_ type: Any.Type) -> DecodingError {
        let errorContext = DecodingError.Context(
            codingPath: self.codingPath,
            debugDescription: "This value is not decodable by LooseDecodable."
        )
        return DecodingError.typeMismatch(type, errorContext)
    }

}
