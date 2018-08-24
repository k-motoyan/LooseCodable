//
//  LooseCodableTests.swift
//  LooseCodableTests
//
//  Created by k-motoyan on 2018/07/21.
//  Copyright © 2018年 k-motoyan. All rights reserved.
//

import XCTest
@testable import LooseCodable

final class LooseCodableTests: XCTestCase {

    // MARK: Test for decode

    func testDecodeWhenBoolDecoderGivenNormalCaseExpectDecoded() {
        let testData = [
            (false, "{ \"_value\": false }"),
            (true, "{ \"_value\": true }"),
            (false, "{ \"_value\": 0 }"),
            (true, "{ \"_value\": 1 }"),
            (true, "{ \"_value\": -1 }"),
            (false, "{ \"_value\": 0.0 }"),
            (true, "{ \"_value\": 0.1 }"),
            (true, "{ \"_value\": -0.1 }"),
            (false, "{ \"_value\": \"False\" }"),
            (true, "{ \"_value\": \"True\" }")
        ]

        for (expect, json) in testData {
            self.test(json: json) { (data: Data) -> (Bool, Bool) in
                let decoded = try! JSONDecoder().decode(BoolCoding.self, from: data)
                let result = decoded.value == expect
                XCTAssert(result)

                return (decoded.value, result)
            }
        }
    }

    func testDecodeWhenIntDecoderGivenNormalCaseExpectDecoded() {
        let testData = [
            (0, "{ \"_value\": false }"),
            (1, "{ \"_value\": true }"),
            (0, "{ \"_value\": 0 }"),
            (1, "{ \"_value\": 1 }"),
            (-1, "{ \"_value\": -1 }"),
            (0, "{ \"_value\": 0.0 }"),
            (0, "{ \"_value\": 0.1 }"),
            (0, "{ \"_value\": -0.1 }"),
            (1, "{ \"_value\": 1.0 }"),
            (0, "{ \"_value\": \"0\" }"),
            (1, "{ \"_value\": \"1\" }")
        ]

        for (expect, json) in testData {
            self.test(json: json) { (data: Data) -> (Int, Bool) in
                let decoded = try! JSONDecoder().decode(IntCoding.self, from: data)
                let result = decoded.value == expect
                XCTAssert(result)

                return (decoded.value, result)
            }
        }
    }

    func testDecodeWhenDoubleDecoderGivenNormalCaseExpectDecoded() {
        let testData = [
            (0.0, "{ \"_value\": false }"),
            (1.0, "{ \"_value\": true }"),
            (0.0, "{ \"_value\": 0 }"),
            (1.0, "{ \"_value\": 1 }"),
            (-1.0, "{ \"_value\": -1 }"),
            (0.0, "{ \"_value\": 0.0 }"),
            (0.1, "{ \"_value\": 0.1 }"),
            (-0.1, "{ \"_value\": -0.1 }"),
            (1.0, "{ \"_value\": 1.0 }"),
            (0.0, "{ \"_value\": \"0\" }"),
            (1.0, "{ \"_value\": \"1\" }"),
            (0.0, "{ \"_value\": \"0.0\" }"),
            (1.0, "{ \"_value\": \"1.0\" }")
        ]

        for (expect, json) in testData {
            self.test(json: json) { (data: Data) -> (Double, Bool) in
                let decoded = try! JSONDecoder().decode(DoubleCoding.self, from: data)
                let result = decoded.value == expect
                XCTAssert(result)

                return (decoded.value, result)
            }
        }
    }

    func testDecodeWhenStringDecoderGivenNormalCaseExpectDecoded() {
        let testData = [
            ("false", "{ \"_value\": false }"),
            ("true", "{ \"_value\": true }"),
            ("0", "{ \"_value\": 0 }"),
            ("1", "{ \"_value\": 1 }"),
            ("-1", "{ \"_value\": -1 }"),
            ("0.1", "{ \"_value\": 0.1 }"),
            ("-0.1", "{ \"_value\": -0.1 }"),
            ("0", "{ \"_value\": 0.0 }"),
            ("1", "{ \"_value\": 1.0 }"),
            ("Hello world!!", "{ \"_value\": \"Hello world!!\" }")
        ]

        for (expect, json) in testData {
            self.test(json: json) { (data: Data) -> (String, Bool) in
                let decoded = try! JSONDecoder().decode(StringCoding.self, from: data)
                let result = decoded.value == expect
                XCTAssert(result)

                return (decoded.value, result)
            }
        }
    }

    private func test<T>(json: String, checker: (Data) -> (T, Bool)) {
        print("===> Testing: \(json)")
        let (actual, result) = checker(json.data)
        print("===> \(result ? "OK!!" : "NG, actual \(actual)")")
    }

    // MARK: Test for encode

    func testDecodeWhenBoolEncoderExpectEncoded() {
        let expect = "{\"_value\":true}"
        let encoder = try! JSONDecoder().decode(BoolCoding.self, from: expect.data)
        let actual = try! JSONEncoder().encode(encoder).string
        XCTAssert(expect == actual)
    }

    func testDecodeWhenIntEncoderExpectEncoded() {
        let expect = "{\"_value\":42}"
        let encoder = try! JSONDecoder().decode(IntCoding.self, from: expect.data)
        let actual = try! JSONEncoder().encode(encoder).string
        XCTAssert(expect == actual)
    }

    func testDecodeWhenDoubleEncoderExpectEncoded() {
        let expect = "{\"_value\":3.14}"
        let encoder = try! JSONDecoder().decode(DoubleCoding.self, from: expect.data)
        let actual = try! JSONEncoder().encode(encoder).string
        XCTAssert(expect == actual)
    }

    func testDecodeWhenStringEncoderExpectEncoded() {
        let expect = "{\"_value\":\"Hello world!!\"}"
        let encoder = try! JSONDecoder().decode(StringCoding.self, from: expect.data)
        let actual = try! JSONEncoder().encode(encoder).string
        XCTAssert(expect == actual)
    }

}

// MARK: - Codable types

private struct BoolCoding: Codable {
    private let _value: LooseCodable<Bool>
    var value: Bool { return self._value.value }
}

private struct IntCoding: Codable {
    private let _value: LooseCodable<Int>
    var value: Int { return self._value.value }
}

private struct DoubleCoding: Codable {
    private let _value: LooseCodable<Double>
    var value: Double { return self._value.value }
}

private struct StringCoding: Codable {
    private let _value: LooseCodable<String>
    var value: String { return self._value.value }
}

// MARK: - Helper extensions

private extension String {

    var data: Data {
        return self.data(using: .utf8)!
    }

}

private extension Data {

    var string: String {
        return String(data: self, encoding: .utf8)!
    }

}
