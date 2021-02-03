//
//  Person.swift
//  IssueNavigator
//
//  Created by Romina Uncrop on 01/02/2021.
//  Copyright © 2021 TestApp. All rights reserved.
//

import Foundation

// "First name", "Sur name", "Issue count", "Date of birth" - CSV header

/// Model for a CSV row
struct Person: Codable {
    var firstName: String
    var surname: String
    var issueCount: Int
    var birthDate: Date
    
    private enum CodingKeys: String, CodingKey {
        case firstName = "First name"
        case surname = "Sur name"
        case issueCount = "Issue count"
        case birthDate = "Date of birth"
    }
    
    static let dateFormatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withFullDate, .withDashSeparatorInDate, .withColonSeparatorInTime]
        return formatter
    }()
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        firstName = try container.decode(String.self, forKey: .firstName)
        surname = try container.decode(String.self, forKey: .surname)
        let issueCountString = try container.decode(String.self, forKey: .issueCount)
        issueCount = Int(issueCountString) ?? 0
        
        let dateString = try container.decode(String.self, forKey: .birthDate)
        if let date = Person.dateFormatter.date(from: dateString) {
            birthDate = date
        } else {
            throw DecodingError.dataCorruptedError(forKey: .birthDate,
                                                   in: container,
                debugDescription: "Date string does not match format expected by formatter.")
      }
    }
    
    init(firstName: String, surname: String, issueCount: Int, birthDate: Date) {
        self.firstName = firstName
        self.surname = surname
        self.issueCount = issueCount
        self.birthDate = birthDate
    }
}
