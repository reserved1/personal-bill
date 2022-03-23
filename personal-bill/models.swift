//
//  models.swift
//  personal-bill
//
//  Created by Matheus Augusto Alves de Meneses on 15/03/22.
//

import Foundation
// Classe de Conta.
// Parametros: Código de Barra(barCode), Descrição(description),
// Condição da conta(status, true para Pago, false para não pago) e Valor da Conta(value).
class Bill: Codable {
    var barCode: String
    var description: String
    var status: Bool
    var value: Double
    
    // Construtor.
    init(barCode: String, description: String, status: Bool, value: Double) {
        self.barCode = barCode
        self.description = description
        self.status = status
        self.value = value
    }
}

