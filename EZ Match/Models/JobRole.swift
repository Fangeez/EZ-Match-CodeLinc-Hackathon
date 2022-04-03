//
//  JobRole.swift
//  EZ Match
//
//  Created by Subomi Popoola on 4/2/22.
//

import UIKit

class JobRole {
    let company: String
    let minSalary: Int
    let maxSalary: Int
    let benefits: [String]
    let skills: [String]
    let title: String
    let questionnaireLink: String
    
    init(object: [String: Any]) {
        self.company = object["company"] as! String
        self.minSalary = object["minSalary"] as! Int
        self.maxSalary = object["maxSalary"] as! Int
        self.benefits = object["benefits"] as! [String]
        self.skills = object["skills"] as! [String]
        self.title = object["title"] as! String
        self.questionnaireLink = object["questionnaire"] as! String
    }
}
