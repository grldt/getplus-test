//
//  MerchantsViewModel.swift
//  getplus test
//
//  Created by Gerald Stephanus on 01/02/23.
//

import Foundation

class MerchantsViewModel: ObservableObject {
    
    private var merchantUrl = "https://private-840560-gpimobiletakehometest.apiary-mock.com/merchants?page="
    @Published var merchants: [MerchantsData.Data.List] = []
    @Published var isLoading: Bool = false
    
    func fetchMerchants(page: String) async {
        guard let url = URL(string: merchantUrl + page) else {
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
            
            if let decodedData = try? JSONDecoder().decode(MerchantsData.self, from: data) {
                DispatchQueue.main.async {
                    self.merchants = decodedData.data.list
                    self.isLoading = false
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
}
