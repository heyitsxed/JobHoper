//
//  JobHoper.swift
//  JobHoper
//
//  Created by Cedrick on 2/12/26.
//

import SwiftUI

struct JobHoper: View {
    @StateObject private var viewModel = JobViewModel()
    
    var body: some View {
        VStack {
            Text("Job Hoper")
                .font(.title)
            
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(viewModel.job?.data ?? [], id: \.slug) { company in
                    ScrollView {
                        CardView(company: company)
                    }
                    .padding()
                }
            }
        }
        .onAppear {
            Task { try await viewModel.getJob() }
        }
    }
}

#Preview {
    JobHoper()
}


struct CardView: View {
    var company: Company?
    @State var isPresent: Bool = false
    
    var body: some View {
        VStack {
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white)
                    .frame(minHeight: 44)
                    .overlay {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.white)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                            .shadow(color: .black.opacity(0.2), radius: 4)

                    }
                
                VStack(alignment: .leading,spacing: 10) {
                    Text(company?.title ?? "Sr. iOS Developer")
                        .font(.system(size: 17, weight: .semibold))
                    Text(company?.companyName ?? "Metromart")
                        .font(.system(size: 14, weight: .regular))

                    HStack {
                        Text(company?.remote == true ? "Work from Home" : "Work from Office")
                            .padding(.horizontal, 10)
                            .font(.system(size: 12, weight: .semibold))
                            .frame(height: 20)
                            .background(Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(3)
                        
                        Text(company?.location ?? "Makati City, Philippines")
                            .padding(.horizontal, 10)
                            .font(.system(size: 12, weight: .semibold))
                            .frame(height: 20)
                            .background(Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(3)
                    }
                    
                    Text(company?.tags.joined(separator: ", ") ?? "Full time, Hybrid")
                        .font(.system(size: 14, weight: .regular))

                    Text("Easily Apply")
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
        .padding(.horizontal, 15)
    }
}

struct SheetDescription: View {
    var company: Company?
    
    var body: some View {
        VStack {
            ScrollView {
                Text(company?.description.htmlPlaintToText ?? "")
                    .font(.system(size: 16,weight: .regular))
            }
        }
    }
}
