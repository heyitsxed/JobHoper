//
//  JobHoper.swift
//  JobHoper
//
//  Created by Cedrick on 2/12/26.
//

import SwiftUI

struct JobHoper: View {
    @StateObject private var viewModel = JobViewModel()
    @State private var searchText = ""
    
    var filteredJobs: [Company] {
        if searchText.isEmpty {
            return viewModel.displayedJobs
        } else {
            return viewModel.allJobs.filter {
                $0.title.localizedStandardContains(searchText) ||
                $0.companyName.localizedStandardContains(searchText)
            }
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Job Hoper")
                    .foregroundColor(.blue)
                    .font(.system(size: 22, weight: .semibold))
                    .textCase(.uppercase)
                    .padding(.leading, 15)
            }
            
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.blue)
                
                TextField("Search jobs...", text: $searchText)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                
                Spacer()
                
                if !searchText.isEmpty {
                    Image(systemName: "x.circle.fill")
                        .foregroundColor(.red)
                        .onTapGesture { searchText = "" }
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(9)
            .padding(.vertical, 5)
            .shadow(radius: 4)
            .padding(.horizontal, 15)
            
            List {
                ForEach(filteredJobs, id: \.slug) { job in
                    CardView(company: job)
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets())
                        .padding(.vertical, 6)
                        .padding(.horizontal, 15)
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
    }
}

#Preview {
    JobHoper()
}

