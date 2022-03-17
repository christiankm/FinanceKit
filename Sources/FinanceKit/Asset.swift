//
//  FinanceKit
//  Copyright © 2022 Christian Mitteldorf. All rights reserved.
//  MIT license, see LICENSE file for details.
//

import Foundation

public protocol Asset: Codable {

    var symbol: Symbol { get }
    var displayName: String { get }
}
