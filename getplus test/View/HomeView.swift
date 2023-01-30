//
//  HomeView.swift
//  getplus test
//
//  Created by Gerald Stephanus on 30/01/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            VStack{
                HStack(spacing: 20) {
                    ForEach(0..<2) {
                        Text("Item \($0)")
                            .font(.caption2)
                            .frame(width: 50, height: 50)
                            .foregroundColor(.black)
                            .background(.cyan)
                    }
                }
                .padding(10)
                
                Text("Promo Section")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(10)
                
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        ForEach(0..<6) {
                            Text("Test \($0)")
                                .font(.caption2)
                                .frame(width: 200, height: 120)
                                .foregroundColor(.black)
                                .background(.cyan)
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
