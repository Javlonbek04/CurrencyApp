//
//  CurrencyModel.swift
//  CurrencyApp
//
//  Created by Abdulvoxid on 15/12/24.
//

import Foundation

struct CurrencyData: Codable {
    let id: Int
       let code, ccy, ccyNmRU, ccyNmUZ: String
       let ccyNmUZC, ccyNmEN, nominal, rate: String
       let diff, date: String

       enum CodingKeys: String, CodingKey {
           case id
           case code = "Code"
           case ccy = "Ccy"
           case ccyNmRU = "CcyNm_RU"
           case ccyNmUZ = "CcyNm_UZ"
           case ccyNmUZC = "CcyNm_UZC"
           case ccyNmEN = "CcyNm_EN"
           case nominal = "Nominal"
           case rate = "Rate"
           case diff = "Diff"
           case date = "Date"
       }
}
