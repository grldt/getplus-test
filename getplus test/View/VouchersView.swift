//
//  VouchersView.swift
//  getplus test
//
//  Created by Gerald Stephanus on 01/02/23.
//

import SwiftUI

struct VouchersView: View {
    @StateObject var vouchersVM = VouchersViewModel()
    
    var body: some View {
        ScrollView {
            ForEach(vouchersVM.vouchers) { voucher in
                HStack {
                    AsyncImage(
                        url: URL(string: voucher.Images.Feature.ImageURL),
                        content: { image in
                            image.resizable()
                        },
                        placeholder: {
                            ProgressView()
                        }
                    )
                    .frame(width: 72, height: 72)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                    VStack {
                        Text(voucher.VoucherCode)
                            .font(.title2)
                            .lineLimit(1)
                        
                        Text("Valid until: ")
                            .font(.title2)
                            .lineLimit(1)
                    }
                    
                    Spacer()
                    
                    Button("Use", action: {
                        print("Feature in development")
                    })
                }
                .padding(.leading, 80)
                .padding(.trailing, 80)
            }
        }
        .onAppear(perform: {
            Task {
                await vouchersVM.fetchVouchers()
            }
        })
    }
}

struct VouchersView_Previews: PreviewProvider {
    static var previews: some View {
        VouchersView()
    }
}
