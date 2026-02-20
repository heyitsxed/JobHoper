//
//  JobViewModel.swift
//  JobHoper
//
//  Created by Cedrick on 2/12/26.
//

import Combine
import Foundation

@MainActor
class JobViewModel: ObservableObject {
    @Published var allJobs: [Company] = []
    @Published var displayedJobs: [Company] = []
    
    @Published var currentPage: Int = 1
    @Published var currentIndex: Int = 0
    
    @Published var isLoading: Bool = false
    @Published var isLoadingMore: Bool = false
    
    @Published var searchText = ""
    
    private let pageSize: Int = 20
    private let apiPageSize: Int = 100
    
    private var hasMoreApiPages: Bool = true
    
    var hasMoreDisplayJobs: Bool {
        currentIndex < allJobs.count
    }
        
    var filteredJobs: [Company] {
        if searchText.isEmpty {
            return displayedJobs
        } else {
            return allJobs.filter {
                $0.title.localizedStandardContains(searchText) ||
                $0.companyName.localizedStandardContains(searchText)
            }
        }
    }
    
    func getJob(page: Int = 1) async throws {
        isLoading = true
        
        defer { isLoading = false }
        
        guard var components = URLComponents(string: "https://arbeitnow.com/api/job-board-api") else {
            throw URLError(.badURL)
        }
        
        components.queryItems = [
            URLQueryItem(name: "page", value: "\(page)")
        ]
        
        guard let url = components.url else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        do {
            let decoder = JSONDecoder()
            let parse = try decoder.decode(JobResponse.self, from: data)
            allJobs.append(contentsOf: parse.data)
            
            if displayedJobs.isEmpty {
                showNextBatch()
            }
            
            if parse.data.count < apiPageSize {
                self.hasMoreApiPages = false
            }
            
        } catch {
            print(error)
        }
    }
    
    func showNextBatch() {
        guard currentIndex < allJobs.count else { return }
        guard !isLoadingMore else { return }
        
        isLoadingMore = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            let nextIndex = min(self.currentIndex + self.pageSize, self.allJobs.count)
            let nextBatch = self.allJobs[self.currentIndex..<nextIndex]
            self.displayedJobs.append(contentsOf: nextBatch)
            self.currentIndex = nextIndex
            self.isLoadingMore = false
        }
    }
    
    func loadMoreIfNeeded() async {
        if hasMoreDisplayJobs {
            showNextBatch()
        } else if currentIndex >= allJobs.count - 5 && hasMoreApiPages {
            isLoadingMore = true
            currentPage += 1
            
            do {
                try await getJob(page: currentPage)
                showNextBatch()
            } catch {
                print("Failed to load next page:", error)
            }
            
            isLoadingMore = false
        }
    }
}
