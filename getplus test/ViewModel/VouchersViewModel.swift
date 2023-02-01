//
//  VouchersViewModel.swift
//  getplus test
//
//  Created by Gerald Stephanus on 01/02/23.
//

import Foundation

class VouchersViewModel: ObservableObject {
    private var voucherUrl = "https://private-840560-gpimobiletakehometest.apiary-mock.com/vouchers"
    @Published var vouchers: [VouchersData.Data.List] = []
    
    func fetchVouchers() async {
        guard let url = URL(string: voucherUrl) else {
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
            
            if let decodedData = try? JSONDecoder().decode(VouchersData.self, from: data) {
                DispatchQueue.main.async {
                    self.vouchers = decodedData.data.list
                }
            } else {
                print("Error parsing data")
            }
            
        } catch {
            print("error getting data from API")
        }
    }
}
