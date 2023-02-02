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
    @State var openPromo = false
    
    var body: some View {
        NavigationStack {
            //            if((homeVM.promos.isEmpty) && (homeVM.menus.isEmpty)){
            //                ProgressView()
            //                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            //                    .background(Color.black.opacity(0.3))

            //            } else {
            ScrollView{
                HStack() {
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
                            .padding(10)
                        }
                    }
                    
                    NavigationLink(destination: MerchantsView(), isActive: $openMerchants) {
                        EmptyView()
                    }
                    .isDetailLink(false)
                    .hidden()
                    
                    NavigationLink(destination: VouchersView(), isActive: $openVouchers) {
                        EmptyView()
                    }
                    .isDetailLink(false)
                    .hidden()
                }
                .padding(10)
                
                Text("Promo Section")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(10)
                    .opacity(homeVM.isLoading ? 0 : 1)
                
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        ForEach(homeVM.promos) { promo in
                            Button (action: {
                                print(promo.url)
                                if (homeVM.isBrowser(url: promo.url)) {
                                    // open in browser
                                    UIApplication.shared.open(URL(string: promo.url)!)
                                } else {
                                    // open in webview
                                    openPromo.toggle()
                                }
                            }) {
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
                                
                                NavigationLink(destination: PromoView(promoUrl: promo.url), isActive: $openPromo) {
                                    EmptyView()
                                }
                                .isDetailLink(false)
                                .hidden()
                            }
                        }
                    }
                }
                .padding(10)
                
                Spacer()
            }
            .navigationBarTitle(Text("GetPlus Indonesia"), displayMode: .inline)
            .overlay(homeVM.isLoading ? ProgressView("Loading")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black.opacity(0.3))
                .anyView() : EmptyView().anyView())
            .onAppear(perform: {
                homeVM.isLoading = true
                Task {
                    await homeVM.fetchHome()
                }
            })
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
