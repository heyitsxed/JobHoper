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
        VStack(alignment: .leading) {
            HStack {
                Text("Job Hoper")
                    .foregroundColor(.blue)
                    .font(.system(size: 22, weight: .semibold))
                    .padding(.leading, 15)
                    .textCase(.uppercase)
                
                Spacer()
                
                Image(systemName: "bell.badge")
                    .resizable()
                    .frame(width: 20, height: 25)
                    .padding(.trailing, 15)
                
            }
            
            List {
                ForEach(viewModel.displayedJobs, id: \.slug) { job in
                    CardView(company: job)
                        .listRowSeparator(.hidden)
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

