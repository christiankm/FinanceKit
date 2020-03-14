////
////  DividendRecord.swift
////  FinanceKit
////
////  Created by Andrew Finke on 9/5/16.
////  Copyright © 2016 Andrew Finke. All rights reserved.
////
//
//import Foundation
//
///// The struct for dividends that the user actually received, calls formatters to format data
//public struct DividendRecord {
//    public let stockSymbol: String
//    public let value: Double
//    public let formattedDate: String
//    public let formattedValue: String
//    public init?(_ dividend: Dividend, _ shares: Double) {
//swiftlint:disable line_length
//        value = dividend.price * shares
//        guard let formattedDate = Formatters.shared.stringWithMonth(fromDate: dividend.date),
//            let formattedValue = Formatters.shared.string(fromPrice: value, currencyCode: dividend.stock.company.currency.code)
//            else {
//                return nil
//        }
//        self.stockSymbol = dividend.stock.company.symbol
//        self.formattedDate = formattedDate
//        self.formattedValue = formattedValue
//    }
//}

////
////  DividendRecord+Coding.swift
////  FinanceKit
////
////  Created by Andrew Finke on 9/5/16.
////  Copyright © 2016 Andrew Finke. All rights reserved.
////
//
//import Foundation
//
//extension DividendRecord {
//    @objc(_TtCV10FinanceKit14DividendRecordP33_08AB707C03E9627C5758FF8937CF676021DividendRecordCopying)fileprivate class DividendRecordCopying: NSObject, NSCoding {
//        internal let stockSymbol: String
//        internal let value: Double
//        internal let formattedDate: String
//        internal let formattedValue: String
//
//        internal init(_ dividendRecord: DividendRecord) {
//            stockSymbol = dividendRecord.stockSymbol
//            value = dividendRecord.value
//            formattedDate = dividendRecord.formattedDate
//            formattedValue = dividendRecord.formattedValue
//        }
//
//        internal required init?(coder aDecoder: NSCoder) {
//            stockSymbol = aDecoder.decodeObject(forKey: SerializationKeys.stockSymbol) as! String
//            value = (aDecoder.decodeObject(forKey: SerializationKeys.value) as! NSNumber).doubleValue
//            formattedDate = aDecoder.decodeObject(forKey: SerializationKeys.formattedDate) as! String
//            formattedValue = aDecoder.decodeObject(forKey: SerializationKeys.formattedValue) as! String
//        }
//
//        func encode(with aCoder: NSCoder) {
//            aCoder.encode(stockSymbol, forKey: SerializationKeys.stockSymbol)
//            aCoder.encode(NSNumber(value: value), forKey: SerializationKeys.value)
//            aCoder.encode(formattedDate, forKey: SerializationKeys.formattedDate)
//            aCoder.encode(formattedValue, forKey: SerializationKeys.formattedValue)
//        }
//
//        private struct SerializationKeys {
//            static let stockSymbol = "stockSymbol"
//            static let value = "value"
//            static let formattedDate = "formattedDate"
//            static let formattedValue = "formattedValue"
//        }
//    }
//
//    internal func asData() -> Data {
//        return NSKeyedArchiver.archivedData(withRootObject: DividendRecordCopying(self))
//    }
//
//    internal init(data: Data) {
//        let object = NSKeyedUnarchiver.unarchiveObject(with: data) as! DividendRecordCopying
//        stockSymbol = object.stockSymbol
//        value = object.value
//        formattedDate = object.formattedDate
//        formattedValue = object.formattedValue
//    }
//}
