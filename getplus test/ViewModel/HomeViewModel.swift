//
//  HomeViewModel.swift
//  getplus test
//
//  Created by Gerald Stephanus on 31/01/23.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    private var homeUrl = "https://private-840560-gpimobiletakehometest.apiary-mock.com/home"
    @Published var menus: [JsonData.Data.Layout.Menu] = []
    @Published var promos: [JsonData.Data.Layout.Promo.PromoData] = []
    
    
    func fetchHome() async {
        guard let url = URL(string: homeUrl) else {
            print("Missing URL")
            return
        }
        
        do {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "GET"
            
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                print("Error while fetching data")
                return
            }
            
            if let decodedData = try? JSONDecoder().decode(JsonData.self, from: data) {
                DispatchQueue.main.async {
                    self.setMenuPromo(data: decodedData)
                }
            } else {
                print("Error parsing data")
            }
            
        } catch {
            print("error getting data from API")
        }
    }
    
    func setMenuPromo(data: JsonData) {
        menus = data.data.layout.menu
        promos = data.data.layout.promo.data
    }
}
