//
//  models.swift
//  personal-bill
//
//  Created by Matheus Augusto Alves de Meneses on 15/03/22.
//

import Foundation

class Bill: Codable, CustomStringConvertible {
    var barCode: String
    var billDescription: String
    var status: Bool
    var value: Double
    init(barCode: String, description: String, status: Bool, value: Double) {
        self.barCode = barCode
        self.billDescription = description
        self.status = status
        self.value = value
    }
    var description: String {
            """
            =================================
            |Conta:    \(billDescription)
            |Valor:    \(value)
            |Código:   \(barCode)
            =================================
            """
    }
}
