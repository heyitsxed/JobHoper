//
//  CardView.swift
//  JobHoper
//
//  Created by Cedrick on 2/15/26.
//

import SwiftUI

struct CardView: View {
    @State var isPresent: Bool = false
    
    var company: Company?
    
    var body: some View {
        VStack(spacing: 1) {
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white)
                    .frame(minHeight: 44)
                    .overlay {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.white)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                            .shadow(color: .blue.opacity(0.2), radius: 1, x: 1, y: 1)
                        
                    }
                
                VStack(alignment: .leading,spacing: 10) {
                    Text(company?.title ?? "")
                        .font(.system(size: 17, weight: .semibold))
                    Text(company?.companyName ?? "")
                        .font(.system(size: 14, weight: .regular))
                    
                    HStack {
                        Text(company?.remote == true ? StringConstants.wfh.rawValue : StringConstants.wfo.rawValue)
                            .padding(.horizontal, 10)
                            .font(.system(size: 12, weight: .semibold))
                            .frame(height: 20)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(3)
                        
                        Text(company?.location ?? "")
                            .padding(.horizontal, 10)
                            .font(.system(size: 12, weight: .semibold))
                            .frame(height: 20)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(3)
                    }
                    
                    Text(company?.tags.joined(separator: ", ") ?? "")
                        .font(.system(size: 14, weight: .regular))
                    
                    Text(company?.jobTypes.joined(separator: ", ") ?? "")
                        .font(.system(size: 14, weight: .regular))
                    
                }
                .padding()
            }
            .onTapGesture {
                isPresent = true
            }
            .sheet(isPresented: $isPresent) {
                SheetDescription(company: company)
                    .padding(.all, 20)
                    .presentationDragIndicator(.visible)
                    .ignoresSafeArea(edges: .bottom)
                
            }
            
        }
    }
}
