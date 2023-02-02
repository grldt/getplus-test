//
//  VouchersView.swift
//  getplus test
//
//  Created by Gerald Stephanus on 01/02/23.
//

import SwiftUI

struct VouchersView: View {
    @StateObject var vouchersVM = VouchersViewModel()
    @State private var useAlert = false
    
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
                    
                    VStack(alignment: .leading) {
                        Text(voucher.VoucherCode)
                            .font(.footnote)
                            .lineLimit(1)
                        
                        Text("Valid until: ")
                            .font(.footnote)
                            .lineLimit(1)
                    }
                    
                    Spacer()
                    
                    Button("Use", action: {
                        useAlert.toggle()
                    })
                    .alert("Feature under development", isPresented: $useAlert) {
                        Button("OK", role: .cancel) { }
                    }
                }
                .padding(.leading, 40)
                .padding(.trailing, 40)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear(perform: {
            Task {
                vouchersVM.isLoading = true
                await vouchersVM.fetchVouchers()
            }
        })
        .navigationBarTitle(Text("Vouchers"), displayMode: .inline)
        .overlay(vouchersVM.isLoading ? ProgressView("Loading")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black.opacity(0.3))
            .anyView() : EmptyView().anyView())
    }
}

struct VouchersView_Previews: PreviewProvider {
    static var previews: some View {
        VouchersView()
    }
}
