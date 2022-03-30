//
//  functions.swift
//  personal-bill
//
//  Created by Matheus Augusto Alves de Meneses on 15/03/22.
//

import Foundation

// Print mais "bonito" para lista de objetos.
func printBeautify (_ array: Array<Bill>) {
    for object in array {
        printBeautify(object)
    }
}
// Print mais "bonito" para objetos isolados.
func printBeautify (_ object: Bill) {
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
// Função de busca usando o código de barra(barCode)
func barCodeSearch(_ array: inout Array<Bill>, _ barCode: String) -> Bill{
    var tempBill: Bill = Bill(barCode: "404", description: "Sem Informação", status: true, value: 0)
    if array.count != 0 { // Checagem de lista vazia ou codigo de barra nulo
        for object in array {
            if object.barCode == barCode {
                tempBill = object
                break
            }
        }
    }
    else {
        return tempBill // Retorna objeto com valor de parada sem erro nil
    }
    return tempBill // Retorna o objeto que quero da lista
}
// Menu de entrada para o "programa" do terminal
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
// Função para a opção de Cadastrar Conta.
func registrationMenu(_ array: inout Array<Bill>) {
    // Cadastro feito por ordem: barCode/Description/status/value.
    // Código de Barra(barCode).
    var barCode: String?
    repeat {
        print(
            """
            ---------------- Aba de Registro ---------------
             - Digite o Código de Barra da Conta: ex. 13579
            ------------------------------------------------
            """
        )
        print("",terminator: "-> ")
        barCode = getBarCode()!
    } while barCode == nil || barCode == ""
    // Var temporário para receber o input.
    var tempBill = barCodeSearch(&array, barCode!)
    if tempBill.barCode != "404" { // Verificação para caso de ID repetido.
        print(
        """
        -> Já existe conta com esse Código de Barra.
        """
        )
        return
    }
    // Descrição(desciption).
    var description: String?
    repeat {
        print(
            """
            ---------------- Aba de Registro ---------------
             - Digite a Descrição da Conta: ex. Conta de Luz
            ------------------------------------------------
            """
        )
        print("",terminator: "-> ")
        description = getDescription()!
    } while description == nil || description == ""
    // Condição da Conta<Pago(true) ou não Pago(false)>(status).
    print(
        """
        -------------------------- Aba de Registro -------------------------
         - Digite 'Y' para conta Já Paga e 'N' para conta Não Paga : ex. Y
         - Deixar vazio constará como não paga.
         - Digitar algo diferente de 'Y' constará como não paga.
        --------------------------------------------------------------------
        """
    )
    print("",terminator: "-> ")
    // Var temporário para receber o input.
    let tempStatus: String = readLine()?.lowercased() ?? "n"
    let status = tempStatus == "y" ? true : false // Checagem para resultado true/false.
    // Valor da Conta(value).
    // Converção de valor para Double
    var value: Double?
    repeat {
        print(
            """
            ------------- Aba de Registro ------------
             - Digite o Valor da Conta: ex. 99.35
            ------------------------------------------
            """
        )
        print("",terminator: "-> ")
        value = getValue()
    } while value == nil
    // Atribuindo os valores a um objeto tipo conta e devolvendo para a adicionando a lista de contas.
    tempBill = Bill(barCode: barCode!, description: description!, status: status, value: value!)
    array.append(tempBill)
    print(
    """
    
    -> Conta Adicionada:
    
    """
    )
    printBeautify(tempBill) // Exibir a conta adicionada por último
    
}
// Função para menu de alteração de dados
func alterationMenu(_ array: inout Array<Bill>) {
    var barCode: String?
    repeat {
        print(
            """
            ------------------ Aba de Alteração -----------------
            -> Digite o Código de Barra da Conta: ex. 1234567...
            -----------------------------------------------------
            """
        )
        print("",terminator: "-> ")
        barCode = getBarCode()
    } while barCode == nil || barCode == ""
    let tempBill: Bill = barCodeSearch(&array, barCode!) // função de busca por codigo de barra
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
        var tempBarCode: String?
        repeat {
            print("-> Digite o NOVO Código: ex. 87589275667265")
            print("",terminator: "-> ")
            tempBarCode = getBarCode()
        } while tempBarCode == nil || tempBarCode == ""
        let tempBill = barCodeSearch(&array, tempBarCode!)
        if tempBill.barCode != "404" { // Verificação para caso de ID repetido.
            print(
            """
            -> Já existe conta com esse Código de Barra.
            """
            )
            return
        } else {
            tempBill.barCode = tempBarCode!
        }
    case "2":
        var tempDescription: String?
        repeat {
            print("-> Digite a NOVA Descrição: ex. Conta de Luz")
            print("",terminator: "-> ")
            tempDescription = getDescription()
        } while tempDescription == nil || tempDescription == ""
        tempBill.description = tempDescription!
        
    case "3":
        if tempBill.status == true { // Inverção de valores de Pago para não Pago ou contrário.
            tempBill.status = false
        } else {
            tempBill.status = true
        }
        print("-> Mudança na situação de pagamento.")
        
    case "4":
        var tempValue: Double?
        repeat {
            print("-> Digite o NOVO Valor da Conta: ex. 125.90")
            print("",terminator: "-> ")
            tempValue = getValue()
        } while tempValue == nil
        tempBill.value = tempValue! // Converção para Double.

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
// Funçao para menu de apagar dados.
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
    let tempBill: Bill = barCodeSearch(&array, tempOpt) // função de busca por codigo de barra
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
// Função para menu de exibição de contas.
func exibitionMenu(_ array: inout Array<Bill>){
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
                    printBeautify(array)
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
                    printBeautify(tempArray)
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
                    printBeautify(tempArray)
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
// Função para carregar as informações de contas.
func loadData(_ list: inout Array<Bill>, _ fileUrl: URL) {
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
func saveData(_ list: inout Array<Bill>, _ fileUrl: URL) {
    // Constante para Encoder da informação.
    let encoded = JSONEncoder()
    do {
        // Encondar para tipo JSON e escrita no Arquivo de Persistencia.
        try encoded.encode(list).write(to: fileUrl)
    } catch {
        print("-> Falha ao Salvar Informações.")
    }
}
// Função principal do programa.
func main() {
    // Lista inicial de Contas.
    var list: Array<Bill> = []
    // Constante para transformar o caminho do arquivo para URL.
    let fileUrl = URL.init(fileURLWithPath: NSHomeDirectory()+"/.saves")
    // Função para carregar dados dos arquivos na lista.
    loadData(&list, fileUrl)

    var state = true
    while state {
        entranceMenu() // Chamada do menu inicial.
        // Variável para inicialização do switch/case
        guard let options: String = readLine() else {
            print("-> Não Aceitamos valor NIL aqui!!")
            return
        }
        switch options {
            case "1":
                // Chamada de função para adicionar conta.
                registrationMenu(&list)
                saveData(&list, fileUrl)
            case "2":
                // Chamada de função para alterar dados de contas.
                alterationMenu(&list)
                saveData(&list, fileUrl)
            case "3":
                // Chamada de função para deletar um objeto conta.
                deletionMenu(&list)
                saveData(&list, fileUrl)
            case "4":
                // Chamada de função para exibir dados de contas.
                exibitionMenu(&list)
            default:
                // Saída do programa.
                print("Saída.")
                state = false
                break
        }
    }
    saveData(&list, fileUrl) // Função para salvar informação em arquivo.
}
// Função para loop de aquisição de valor da conta.
func getValue() -> Double?{
    guard let value = Double(readLine()!) else {
        print("-> Você deve digitar um valor numérico.")
        return nil
    }
    return value
}
// Função para loop de descrição de conta.
func getDescription() -> String?{
    // Var temporário para receber o input.
    guard let description = readLine()
    else {
        print("-> A Descrição não pode ser vazia.")
        return nil
    }
    return description
}
// Função para loop de aquisição de código de barra.
func getBarCode() -> String? {
    guard let barCode = readLine()
    else {
        print("-> Código não poderá ser vazio.")
        return nil
    }
    return barCode
}
