//
//  ProfileView.swift
//  JobHoper
//
//  Created by Cedrick on 2/28/26.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 20) {
            VStack(spacing: 10) {
                ImageView(viewModel: viewModel)
                
                Text("John Doe")
                    .font(.system(size: 22, weight: .bold))
                
                Text("iOS Developer")
                    .font(.system(size: 18, weight: .regular))
                    .padding(.top, -5)
            }
            .padding(.top, 15)
            
            HStack(spacing: 15) {
                Image(systemName: "person")
                    .font(.system(size: 22, weight: .semibold))

                VStack(alignment: .leading, spacing: 5) {
                    Text(StringConstants.fullName.rawValue)
                        .font(.system(size: 18, weight: .regular))
                    
                    Text("Testing Ios")
                        .font(.system(size: 18, weight: .semibold))
                    
                    Divider()
                        .padding(.top, 10)
                }
                Spacer()
            }
            
            HStack(spacing: 15) {
                Image(systemName: "envelope")
                    .font(.system(size: 22, weight: .semibold))

                VStack(alignment: .leading, spacing: 5) {
                    Text(StringConstants.email.rawValue)
                        .font(.system(size: 18, weight: .regular))
                    
                    Text("testing@gmail.com")
                        .font(.system(size: 18, weight: .semibold))
                    
                    Divider()
                        .padding(.top, 10)
                }
                Spacer()
            }
            
            HStack(spacing: 15) {
                Image(systemName: "phone")
                    .font(.system(size: 22, weight: .semibold))

                VStack(alignment: .leading, spacing: 5) {
                    Text(StringConstants.phone.rawValue)
                        .font(.system(size: 18, weight: .regular))
                    
                    Text("+63 912 345 6789")
                        .font(.system(size: 18, weight: .semibold))
                    
                    Divider()
                        .padding(.top, 10)
                }
                Spacer()
            }
            
            HStack(spacing: 15) {
                Image(systemName: "location")
                    .font(.system(size: 22, weight: .semibold))

                VStack(alignment: .leading, spacing: 5) {
                    Text(StringConstants.address.rawValue)
                        .font(.system(size: 18, weight: .regular))
                    
                    Text("123 Sample Street, City, Country")
                        .font(.system(size: 18, weight: .semibold))
                    
                    Divider()
                        .padding(.top, 10)
                }
                Spacer()
            }
            
            HStack(spacing: 15) {
                Image(systemName: "calendar")
                    .font(.system(size: 22, weight: .semibold))

                VStack(alignment: .leading, spacing: 5) {
                    Text(StringConstants.joined.rawValue)
                        .font(.system(size: 18, weight: .regular))
                    
                    Text("April 15, 2022")
                        .font(.system(size: 18, weight: .semibold))
                    
                    Divider()
                        .padding(.top, 10)
                }
                
                Spacer()
            }
            
            Spacer()
            
            HStack(spacing: 20) {
                Button(StringConstants.back.rawValue) {
                    dismiss()
                }
                .padding()
                .background(Color.black)
                .foregroundColor(.white)
                .font(.system(size: 18, weight: .semibold))
                .cornerRadius(8)
                
                Button(StringConstants.logout.rawValue) {
                    AppSessionManager.shared.logout()
                }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .font(.system(size: 18, weight: .semibold))
                .cornerRadius(8)
                
            }
            
            
            Spacer()
            
        }
        .padding(.horizontal, 15)
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    ProfileView()
}
