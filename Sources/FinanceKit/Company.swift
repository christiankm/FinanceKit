//
//  Company.swift
//  FinanceKit
//
//  Created by Christian Mitteldorf on 16/06/2016.
//  Copyright © 2016 Christian Mitteldorf. All rights reserved.
//

import Foundation

public struct Company: Codable {
    public let symbol: String
    public let name: String
    public let marketCap: String?
    public let exchange: String
    public let currency: Currency
}
