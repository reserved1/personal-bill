//
//  file-manager.swift
//  personal-bill
//
//  Created by Matheus Augusto Alves de Meneses on 01/04/22.
//

import Foundation

struct Manager {
    
    // Função para carregar as informações de contas.
    static func loadData(_ list: inout Array<Bill>, _ fileUrl: URL) {
        do {
            // Constante para transformar o conteúdo da URL em tipo Data.
            let data = try Data(contentsOf: fileUrl)
            // Decoder do tipo Data para formato da classe Conta(Bill).
            let decodedData = try JSONDecoder().decode(Array<Bill>.self, from: data)
            // Atribuição dos valores do arquivo para a lista de contas.
            list.append(contentsOf: decodedData)
        } catch {
            
        }
    }

    // Função para guardar as informações de contas.
    static func saveData(_ list: Array<Bill>, _ fileUrl: URL) {
        // Constante para Encoder da informação.
        let encoded = JSONEncoder()
        do {
            // Encondar para tipo JSON e escrita no Arquivo de Persistencia.
            try encoded.encode(list).write(to: fileUrl)
        } catch {
            print("-> Falha ao Salvar Informações.")
        }
    }
}
