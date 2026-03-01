//
//  HomePageView.swift
//  JobHoper
//
//  Created by Cedrick on 2/12/26.
//

import SwiftUI

struct HomePageView: View {
    @StateObject private var viewModel = JobViewModel()
    @State private var isShowProfile: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(StringConstants.jobTitle.rawValue)
                    .foregroundColor(.black)
                    .font(.system(size: 22, weight: .semibold))
                    .textCase(.uppercase)
                    .padding(.leading, 15)
                
                Spacer()
                
                Image(systemName: "person.circle")
                    .font(.system(size: 25))
                    .padding(.trailing, 15)
                    .foregroundColor(.black)
                    .onTapGesture {
                        isShowProfile = true
                    }
            }
            
            List {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.blue)
                    
                    TextField(StringConstants.jobSearchPlaceHolder.rawValue, text: $viewModel.searchText)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    
                    Spacer()
                    
                    if !viewModel.searchText.isEmpty {
                        Image(systemName: "x.circle.fill")
                            .foregroundColor(.red)
                            .onTapGesture { viewModel.searchText = "" }
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(9)
                .shadow(radius: 4)
                .padding(.all)
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets())
                
                if viewModel.searchText.isEmpty {
                    VStack(alignment: .leading, spacing: 3) {
                        Text(StringConstants.jobsYoullLove.rawValue)
                            .font(.system(size: 18, weight: .semibold))
                            .listRowSeparator(.hidden)
                        
                        Text(StringConstants.jobsDescription.rawValue)
                            .font(.system(size: 13, weight: .regular))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .listRowSeparator(.hidden)
                    }
                }
                
                ForEach(viewModel.filteredJobs, id: \.slug) { job in
                    CardView(company: job)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 15)
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets())
                        .onAppear {
                            if job.slug == viewModel.displayedJobs.last?.slug {
                                Task { await viewModel.loadMoreIfNeeded() }
                            }
                        }
                }
            }
            .listStyle(.plain)
            
            if viewModel.isLoadingMore {
                HStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
            }
        }
        .onAppear {
            Task { try await viewModel.getJob() }
        }
        .fullScreenCover(isPresented: $isShowProfile) {
            ProfileView()
        }
    }
}


#Preview {
    HomePageView()
}
