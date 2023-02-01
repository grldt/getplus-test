//
//  HomeView.swift
//  getplus test
//
//  Created by Gerald Stephanus on 30/01/23.
//

import SwiftUI

struct HomeView: View {
    @StateObject var homeVM = HomeViewModel()
    @State var openMerchants = false
    @State var openVouchers = false
    
    var body: some View {
        NavigationStack {
            if((homeVM.promos.isEmpty) && (homeVM.menus.isEmpty)){
                ProgressView()
                    .onAppear(perform: {
                        Task {
                            await homeVM.fetchHome()
                        }
                    })
            } else {
                ScrollView{
                    HStack(spacing: 20) {
                        ForEach(homeVM.menus) { menu in
                            Button (action: {
                                switch menu.label {
                                case "Merchants":
                                    openMerchants.toggle()
                                case "Vouchers":
                                    openVouchers.toggle()
                                default:
                                    print("Have you done something new?")
                                }
                            }) {
                                AsyncImage(
                                    url: URL(string: menu.logoUrl),
                                    content: { image in
                                        image.resizable()
                                    },
                                    placeholder: {
                                        ProgressView()
                                    }
                                )
                                .frame(width: 50, height: 50)
                            }
                        }
                        
                        NavigationLink(destination: MerchantsView(), isActive: $openMerchants) {
                            EmptyView()
                        }
                        .isDetailLink(false)
                        .hidden()
                        
//                        NavigationLink(destination: VouchersView(), isActive: $openVouchers) {
//                            EmptyView()
//                        }
//                        .isDetailLink(false)
//                        .hidden()
                    }
                    .padding(10)
                    
                    Text("Promo Section")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(10)
                    
                    ScrollView(.horizontal) {
                        HStack(spacing: 20) {
                            ForEach(homeVM.promos) { promo in
                                AsyncImage(url: URL(string: promo.imageUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .overlay(
                                            Text("Promo \(promo.order)")
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                .foregroundColor(.white)
                                                .padding()
                                                .background(Color.gray.opacity(0.5)),
                                            alignment: .bottomLeading
                                        )
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 200, height: 120, alignment: .center)
                                
                            }
                        }
                    }
                    .padding(10)
                    
                    Spacer()
                }
                .navigationBarTitle(Text("GetPlus Indonesia"), displayMode: .inline)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
