//
//  prints.swift
//  personal-bill
//
//  Created by Matheus Augusto Alves de Meneses on 01/04/22.
//

import Foundation

struct Printer {

    // Print mais "bonito" para lista de objetos.
    static func printBeautify (_ array: Array<Bill>) {
        for object in array {
            printBeautify(object)
        }
    }

    // Print mais "bonito" para objetos isolados.
    static func printBeautify (_ object: Bill) {
        let tempStatus: String
        tempStatus = object.status ? "Pago" : "Não Pago"
        print(
            """
            =================================
            |Conta:    \(object.description)
            |Valor:    \(object.value)
            |Código:   \(object.barCode)
            |Situação: \(tempStatus)
            =================================
            """
            )
    }
}
