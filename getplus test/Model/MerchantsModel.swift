//
//  MerchantsModel.swift
//  getplus test
//
//  Created by Gerald Stephanus on 01/02/23.
//

import Foundation

struct MerchantsData: Codable {
    var data: Data
    
    struct Data: Codable {
        var list: [List]
        
        struct List: Codable, Identifiable {
            var ID, RSN, Name, DisplayValue, URL, WebsiteProfile: String
            var id: String { self.ID }
            
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
