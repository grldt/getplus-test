//
//  HomeView.swift
//  getplus test
//
//  Created by Gerald Stephanus on 30/01/23.
//

import SwiftUI

struct HomeView: View {
    @StateObject var homeVM = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            VStack{
                HStack(spacing: 20) {
                    ForEach(homeVM.menus) { menu in
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
                .padding(10)
                
                Text("Promo Section")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(10)
                    .onAppear(perform: {
                        Task {
                            await homeVM.fetchHome()
                        }
                    })
                
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        ForEach(homeVM.promos) { promo in
                            AsyncImage(url: URL(string: promo.imageUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 200, alignment: .center)
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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
