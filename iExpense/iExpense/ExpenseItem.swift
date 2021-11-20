//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Ivan Ivanušić on 18.11.2021..
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: StringLiteralType
    let amount: Double
}
