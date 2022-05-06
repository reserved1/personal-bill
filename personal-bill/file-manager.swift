//
//  file-manager.swift
//  personal-bill
//
//  Created by Matheus Augusto Alves de Meneses on 01/04/22.
//

import Foundation

struct Manager {
    static func loadData(_ fileUrl: URL) -> [Bill]? {
        do {
            let data = try Data(contentsOf: fileUrl)
            let decodedData = try JSONDecoder().decode([Bill].self, from: data)
            return decodedData
        } catch {
            return nil
        }
    }

    static func saveData(_ list: [Bill], _ fileUrl: URL) {
        let encoded = JSONEncoder()
        do {
            try encoded.encode(list).write(to: fileUrl)
        } catch {
            print("-> Error: Fail to save information.")
        }
    }
}
