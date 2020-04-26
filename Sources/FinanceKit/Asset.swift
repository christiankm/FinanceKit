//
//  Asset.swift
//  FinanceKit
//
//  Created by Christian Mitteldorf on 30/11/2019.
//

import Foundation

public protocol Asset: Codable {

    var symbol: Symbol { get }
    var displayName: String { get }
}
