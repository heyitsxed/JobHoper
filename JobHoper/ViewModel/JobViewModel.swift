//
//  JobViewModel.swift
//  JobHoper
//
//  Created by Cedrick on 2/12/26.
//

import Combine
import Foundation

class JobViewModel: ObservableObject {
    @Published var job: JobResponse?
    
    func getJob() async throws {
        guard let endPoint = URL(string: "https://arbeitnow.com/api/job-board-api") else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: endPoint)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        do {
            let decoder = JSONDecoder()
            let parse = try decoder.decode(JobResponse.self, from: data)
            job = parse
        } catch {
            print(error)
        }
    }
}
