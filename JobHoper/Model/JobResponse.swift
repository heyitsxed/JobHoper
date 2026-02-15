//
//  JobResponse.swift
//  JobHoper
//
//  Created by Cedrick on 2/12/26.
//

import Foundation

struct JobResponse: Codable {
    var data: [Company]
    let meta: Meta
}

struct Company: Codable {
    let slug: String
    let companyName: String
    let title: String
    let description: String
    let remote: Bool
    let url: String
    let tags: [String]
    let jobTypes: [String]
    let location: String
    let createdAt: Int
    
    enum CodingKeys: String, CodingKey {
        case slug
        case companyName = "company_name"
        case title
        case description
        case remote
        case url
        case tags
        case jobTypes = "job_types"
        case location
        case createdAt = "created_at"
    }
}

struct Meta: Codable {
    let currentPage: Int
    let from: Int
    let perPage: Int
    let to: Int
    
    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case perPage = "per_page"
        case from
        case to
    }
}

