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
                        .font(.subheadline)
                        .lineLimit(1)
                    
                    Spacer()
                }
                .padding(.leading, 40)
                .padding(.trailing, 40)
            }
            
            HStack {
                Button("1") {
                    // set page to 1
                    page = "1"
                    Task {
                        merchantsVM.isLoading = true
                        await merchantsVM.fetchMerchants(page: page)
                    }
                }
                .disabled(page == "1")
                
                Button("2") {
                    page = "2"
                    Task {
                        merchantsVM.isLoading = true
                        await merchantsVM.fetchMerchants(page: page)
                    }
                }
                .disabled(page == "2")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear(perform: {
            Task {
                merchantsVM.isLoading = true
                await merchantsVM.fetchMerchants(page: page)
            }
        })
        .navigationBarTitle(Text("Merchants"), displayMode: .inline)
        .overlay(merchantsVM.isLoading ? ProgressView("Loading")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black.opacity(0.3))
            .anyView() : EmptyView().anyView())
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        MerchantsView()
    }
}
