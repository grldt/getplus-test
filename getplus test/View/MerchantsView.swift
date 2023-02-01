//
//  SwiftUIView.swift
//  getplus test
//
//  Created by Gerald Stephanus on 01/02/23.
//

import SwiftUI

struct MerchantsView: View {
    @StateObject var merchantsVM = MerchantsViewModel()
    @State var page = "1"
    
    var body: some View {
        ScrollView {
            ForEach(merchantsVM.merchants) { merchant in
                HStack {
                    AsyncImage(
                        url: URL(string: merchant.Images.Feature.ImageURL),
                        content: { image in
                            image.resizable()
                        },
                        placeholder: {
                            ProgressView()
                        }
                    )
                    .frame(width: 72, height: 72)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                    Text(merchant.Name)
                        .font(.title2)
                        .lineLimit(1)
                    
                    Spacer()
                }
                .padding(.leading, 80)
                .padding(.trailing, 80)
            }
            
            HStack {
                Button("1") {
                    // set page to 1
                    page = "1"
                    Task {
                        await merchantsVM.fetchMerchants(page: page)
                    }
                }
                .disabled(page == "1")
                
                Button("2") {
                    page = "2"
                    Task {
                        await merchantsVM.fetchMerchants(page: page)
                    }
                }
                .disabled(page == "2")
            }
        }
        .onAppear(perform: {
            Task {
                await merchantsVM.fetchMerchants(page: page)
            }
        })
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        MerchantsView()
    }
}
