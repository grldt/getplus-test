//
//  HomeModel.swift
//  getplus test
//
//  Created by Gerald Stephanus on 31/01/23.
//

import Foundation

struct JsonData: Codable {
    var data: Data
    
    struct Data: Codable {
        var layout: Layout
        
        struct Layout: Codable {
            var menu: [Menu]
            
            struct Menu: Codable, Identifiable {
                var id: String
                var logoUrl: String
                var label: String
                var deeplink: String
                var enable, visible: Bool
            }
            
            var promo: Promo
            
            struct Promo: Codable {
                var title: String
                var data: [PromoData]
                
                struct PromoData: Codable, Identifiable {
                    var id: Int
                    var imageUrl: String
                    var order: Int
                    var url: String
                }
            }
        }
    }
}
