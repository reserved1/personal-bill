//
//  functions.swift
//  personal-bill
//
//  Created by Matheus Augusto Alves de Meneses on 15/03/22.
//

import Foundation
struct Functions{

    func main() {
        let fileUrl = URL.init(fileURLWithPath: NSHomeDirectory()+"/.saves")
        var list: Array<Bill> = Manager.loadData(fileUrl) ?? []
        
        var state = true
        while state {
            entranceMenu()
            guard let options: String = readLine() else {
                print("-> Nil value not allowed.")
                return
            }
            switch options {
                case "1":
                    registrationMenu(&list)
                    Manager.saveData(list, fileUrl)
                case "2":
                    alterationMenu(&list)
                    Manager.saveData(list, fileUrl)
                case "3":
                    deletionMenu(&list)
                    Manager.saveData(list, fileUrl)
                case "4":
                    exibitionMenu(list)
                default:
                    print("Ending.")
                    state = false
                    break
            }
        }
        Manager.saveData(list, fileUrl)
    }
    
    func entranceMenu() {
        print(
            """
            
            -------------- Aba de Seleção --------------
             1 - Cadastrar Conta  ||  2 - Alterar Conta
             3 - Apagar Conta     ||  4 - Exibir Contas
               * Outras opções encerrarão o Programa.
            --------------------------------------------
            
            """
        )
        print("",terminator: "-> ")
    }
    
    func registrationMenu(_ array: inout Array<Bill>) {
        // Cadastro feito por ordem: barCode/Description/status/value.
        // Código de Barra(barCode).
        let barCode = getBarCode()
        var tempBill = barCodeSearch(array, barCode)
        if tempBill.barCode != "404" { // Verificação para caso de ID repetido.
            print(
            """
            -> Já existe conta com esse Código de Barra.
            """
            )
            return
        }
        // Descrição(desciption).
        let description = getDescription()
        // Condição da Conta<Pago(true) ou não Pago(false)>(status).
        print(
            """
             - Digite 'Y' para conta Já Paga e 'N' para conta Não Paga : ex. Y
             - Deixar vazio constará como não paga.
             - Digitar algo diferente de 'Y' constará como não paga.
            """
        )
        print("",terminator: "-> ")
        // Var temporário para receber o input.
        let tempStatus: String = readLine()?.lowercased() ?? "n"
        let status = tempStatus == "y" ? true : false // Checagem para resultado true/false.
        // Valor da Conta(value).
        // Converção de valor para Double
        let value = getValue()
        // Atribuindo os valores a um objeto tipo conta e devolvendo para a adicionando a lista de contas.
        tempBill = Bill(barCode: barCode, description: description, status: status, value: value)
        array.append(tempBill)
        print(
        """
        
        -> Conta Adicionada:
        
        """
        )
        print(tempBill.description) // Exibir a conta adicionada por último
    }
    
    func alterationMenu(_ array: inout Array<Bill>) {
        let barCode = getBarCode()
        let tempBill: Bill = barCodeSearch(array, barCode) // função de busca por codigo de barra
        if tempBill.barCode == "404" { // Condição de parada para falha de busca
            print("-> O Código de Barra não foi encontrado.")
            return
        }
        print(
            """
            
            ------------- Aba de Alteração ------------
            -> Digite qual opção deseja alterar:
            1 - Código de Barra  ||  2 - Descrição
            3 - Pagamento        ||  4 - Valor
            -------------------------------------------
            
            """
        )
        print("",terminator: "-> ")
        let tempOpt = readLine() ?? "0" // Var temporário para receber o input de opção.
        
        switch tempOpt {
        case "1":
            let tempBarCode = getBarCode()
            let tempBill1 = barCodeSearch(array, tempBarCode)
            if tempBill1.barCode != "404" { // Verificação para caso de ID repetido.
                print(
                """
                -> Já existe conta com esse Código de Barra.
                """
                )
                return
            } else {
                tempBill.barCode = tempBarCode
            }
        case "2":
            tempBill.billDescription = getDescription()
            
        case "3":
            if tempBill.status == true { // Inverção de valores de Pago para não Pago ou contrário.
                tempBill.status = false
            } else {
                tempBill.status = true
            }
            print("-> Mudança na situação de pagamento.")
            
        case "4":
            tempBill.value = getValue()

        default:
            print(
            """
            
            -> Erro ao escolher a opção.
            
            """
            )
            print("")
            print("")
            return
        }
        print(
            """
            
            -> Dados Alterados.
            
            """
        )
    }
    
    func deletionMenu(_ array: inout Array<Bill>) {
        print(
            """
            ------------------ Aba de Alteração -----------------
            -> Digite o Código de Barra da Conta: ex. 1234567...
            -----------------------------------------------------
            """
        )
        print("",terminator: "-> ")
        // Var temporário para receber o input.
        guard let tempOpt = readLine()
        else {
            print("-> Código pesquisado não poderá ser vazio.")
            return
        }
        if tempOpt == "" {
            print("-> Código de barra não pode estar vazio.")
            return
        }
        let tempBill: Bill = barCodeSearch(array, tempOpt) // função de busca por codigo de barra
        if tempBill.barCode == "404" { // Condição de parada para falha de busca
            print("-> O Código de Barra não foi encontrado.")
            return
        }
        array = array.filter({object in object.barCode != tempOpt}) // Filtro de exclusão de objeto da lista
        print(
        """
        
        -> Conta Apagada.
        
        """
        )
    }
    
    func exibitionMenu(_ array: Array<Bill>){
        while true { // Loop para manter no menu.
            print(
                """
                --------------------- Aba de Exibição ---------------------
                 1 - Exibir Todas as Contas || 2 - Exibir Contas não Pagas
                 3 - Exibir Contas Pagas    || 4 - Exibir Total a Pagar
                  * Outras opções retornaram para o Menu de Entrada.
                -----------------------------------------------------------
                """
            )
            print("",terminator: "-> ")

            let options: String = readLine() ?? "0" // Variáveis para seleção de opção.
            switch options {
                case "1":
                    if array.count == 0 {
                        print(
                        """
                        
                        -> Não há contas registradas.
                        
                        """
                        )
                    }
                    else {
                        for object in array {
                            print(object.description)
                        }
                    }
                case "2":
                    let tempArray = array.filter({object in object.status == false}) // Filtro de contas não pagas.
                    if tempArray.count == 0 {
                        print(
                        """
                        
                        -> Não há contas a pagar.
                        
                        """
                        )
                    }
                    else {
                        for object in tempArray {
                            print(object.description)
                        }
                    }
                case "3":
                    let tempArray = array.filter({object in object.status == true}) // Filtro de contas pagas.
                    if tempArray.count == 0 {
                        print(
                        """
                        
                        -> Não há contas pagas.
                        
                        """
                        )
                    }
                    else {
                        for object in tempArray {
                            print(object.description)
                        }
                    }
                case "4":
                    var tempValue: Double = 0
                    let tempArray = array.filter({object in object.status != true})
                    if tempArray.isEmpty {
                        print(
                        """
                        
                        -> Não há contas a pagar.
                        
                        """
                        )
                    } else {
                        for object in tempArray {
                            tempValue += object.value
                        }
                        print(
                        """
                        
                        -> Valor necessário para todas as contas:
                        -> R$ \(tempValue)
                        
                        """
                        )
                    }
                default:
                    print(
                    """
                    
                    -> Voltando pro Menu Inicial.
                    
                    """
                    )
                    return
            }
        }
    }

    func getValue() -> Double {
        var value: Double?
        repeat {
            print("- Digite o Valor da Conta: ex. 99.35")
            print("",terminator: "-> ")
            if let tempValue = Double(readLine()!) {
                value = tempValue
            }
        } while value == nil
        return value!
    }
    
    func getDescription() -> String {
        var description: String?
        repeat {
            print("- Digite a Descrição da Conta: ex. Conta de Luz")
            print("",terminator: "-> ")
            if let tempDescription = readLine() {
                description = tempDescription
            }
        } while description == nil || description == ""
        return description!
    }
    
    func getBarCode() -> String {
        var barCode: String?
        repeat {
            print("- Digite o Código de Barra da Conta: ex. 13579")
            print("",terminator: "-> ")
            if let tempBarCode = readLine() {
                barCode = tempBarCode
            }
        } while barCode == nil || barCode == ""
        return barCode!
    }
    
    func barCodeSearch(_ array: Array<Bill>, _ barCode: String) -> Bill {
        let tempBill = array.first(where: { $0.barCode == barCode })
        if tempBill != nil {
            return tempBill!
        } else {
            return Bill(barCode: "404", description: "Sem Informação", status: true, value: 0)
        }
    }
}
