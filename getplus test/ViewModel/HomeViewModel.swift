//
//  HomeViewModel.swift
//  getplus test
//
//  Created by Gerald Stephanus on 31/01/23.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    private var homeUrl = "https://private-840560-gpimobiletakehometest.apiary-mock.com/home"
    @Published var menus: [HomeData.Data.Layout.Menu] = []
    @Published var promos: [HomeData.Data.Layout.Promo.PromoData] = []
    @Published var isLoading: Bool = false
    
    func fetchHome() async {
        guard let url = URL(string: homeUrl) else {
            print("Missing URL")
            self.isLoading = false
            return
        }
        
        do {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "GET"
            
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                print("Error while fetching data")
                self.isLoading = false
                return
            }
            
            if let decodedData = try? JSONDecoder().decode(HomeData.self, from: data) {
                DispatchQueue.main.async {
                    self.setMenuPromo(data: decodedData)
                }
            } else {
                print("Error parsing data")
                self.isLoading = false
            }
            
        } catch {
            print("error getting data from API")
            self.isLoading = false
        }
    }
    
    func setMenuPromo(data: HomeData) {
        menus = data.data.layout.menu
        promos = data.data.layout.promo.data
        isLoading = false
    }
    
    func isBrowser(url: String) -> Bool {
        let checkUrl = URL(string: url)
        if(checkUrl!.getParam("browser") == "true") { return true }
        return false
    }
}

extension URL {
    func getParam(_ queryParameterName: String) -> String? {
        guard let url = URLComponents(string: self.absoluteString) else { return nil }
        return url.queryItems?.first(where: { $0.name == queryParameterName })?.value
    }
}
