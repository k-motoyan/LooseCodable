//
//  LooseCodableType.swift
//  LooseCodable
//
//  Created by k-motoyan on 2018/07/21.
//  Copyright © 2018年 k-motoyan. All rights reserved.
//

import Foundation

public protocol LooseCodableType {}

extension Bool: LooseCodableType {}

extension Int: LooseCodableType {}

extension Double: LooseCodableType {}

extension String: LooseCodableType {}
