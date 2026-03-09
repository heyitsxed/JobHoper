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
    @AppStorage("theme") private var isDarkMode: Bool = false

    var body: some View {
        VStack(spacing: 20) {
            VStack(spacing: 10) {
                ImageView(viewModel: viewModel)
                
                Text("\(AppSessionManager.shared.fullName ?? "")")
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
                    
                    Text("\(AppSessionManager.shared.fullName ?? "")")
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
                    
                    Text("\(AppSessionManager.shared.emailDisplay ?? "")")
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
                    
                    if viewModel.isEditingPhone {
                        TextField("Phone Number", text: $viewModel.editPhoneNumber)
                            .keyboardType(.numberPad)
                    } else {
                        Text(AppSessionManager.shared.phone ?? "")
                            .font(.system(size: 18, weight: .semibold))
                    }
                    
                    Divider()
                        .padding(.top, 10)
                }
                
                Button {
                    if viewModel.isEditingPhone {
                        AppSessionManager.shared.phone = viewModel.editPhoneNumber
                    } else {
                        viewModel.editPhoneNumber = AppSessionManager.shared.phone ?? ""
                    }
                    
                    viewModel.isEditingPhone.toggle()
                } label: {
                    Image(systemName: viewModel.isEditingPhone ? "checkmark.circle.fill" : "pencil")
                        .foregroundColor(viewModel.isEditingPhone ? .blue : .gray)
                        .font(.title3)
                }
                
                Spacer()
            }
            
            HStack(spacing: 15) {
                Image(systemName: "location")
                    .font(.system(size: 22, weight: .semibold))
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(StringConstants.address.rawValue)
                        .font(.system(size: 18, weight: .regular))
                    
                    if viewModel.isEditingAddress {
                        TextField("Address", text: $viewModel.editAddress)
                    } else {
                        Text(AppSessionManager.shared.location ?? "")
                            .font(.system(size: 18, weight: .semibold))
                    }
                    
                    Divider()
                        .padding(.top, 10)
                }
                
                Button {
                    if viewModel.isEditingAddress {
                        AppSessionManager.shared.location = viewModel.editAddress
                    } else {
                        viewModel.editAddress = AppSessionManager.shared.location ?? ""
                    }
                    
                    viewModel.isEditingAddress.toggle()
                } label: {
                    Image(systemName: viewModel.isEditingAddress ? "checkmark.circle.fill" : "pencil")
                        .foregroundColor(viewModel.isEditingAddress ? .blue : .gray)
                        .font(.title3)
                }
                
                Spacer()
            }
            
            HStack(spacing: 15) {
                Image(systemName: "calendar")
                    .font(.system(size: 22, weight: .semibold))
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(StringConstants.joined.rawValue)
                        .font(.system(size: 18, weight: .regular))
                    
                    Text("\(AppSessionManager.shared.joined ?? "")")
                        .font(.system(size: 18, weight: .semibold))
                    
                    Divider()
                        .padding(.top, 10)
                }
                
                Spacer()
            }
            
            SwipeToggleView(isDarkMode: $isDarkMode)
            
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
        .preferredColorScheme(isDarkMode ? .dark : .light)
        .padding(.horizontal, 15)
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    ProfileView()
}
