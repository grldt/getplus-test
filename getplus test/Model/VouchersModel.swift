//
//  VouchersModel.swift
//  getplus test
//
//  Created by Gerald Stephanus on 01/02/23.
//

import Foundation

// MARK: - VouchersData
struct VouchersData: Codable {
    var data: Data
    
    struct Data: Codable {
        var list: [List]
        
        struct List: Codable, Identifiable {
            var RSN, DisplayValue, Status, ValidFrom: String
            var ValidUntil, VoucherCode: String
            var VoucherValue: Int
            var AuthenticationRequired: Bool
//            var VoucherURL: String
            var URLOnly, IsPendingTransfer: Bool
//            var ReferralCode, ReferralExpiry: String
            var ScanToUse: Bool
            var Partner: Partner
            var id: String { RSN }
            
            struct Partner: Codable {
                var ID, RSN, DisplayValue: String
            }
            
            var Images: Images
            
            struct Images: Codable {
                var Feature: Feature
                
                struct Feature: Codable {
                    var ImageURL: String
                }
            }
        }
    }
}
