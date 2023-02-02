//
//  PromoView.swift
//  getplus test
//
//  Created by Gerald Stephanus on 02/02/23.
//

import SwiftUI

struct PromoView: View {
    @State var isLoading: Bool = false
    @State var promoUrl: String
    
    var body: some View {
        VStack {
            WebView(url: URL(string: promoUrl)!, isLoading: $isLoading)
                .overlay(isLoading ? ProgressView("Loading page")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.3))
                .anyView() : EmptyView().anyView())
        }
    }
}

struct PromoView_Previews: PreviewProvider {
    static var previews: some View {
        PromoView(promoUrl: "https://apple.com/")
    }
}

extension View {
    func anyView() -> AnyView {
        AnyView(self)
    }
}
