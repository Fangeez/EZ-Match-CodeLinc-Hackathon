//
//  JobRole.swift
//  EZ Match
//
//  Created by Subomi Popoola on 4/2/22.
//

import UIKit
import Parse

class JobRole {
    let id: String
    let compID: String
    let minSalary: Int
    let maxSalary: Int
    let benefits: [String]
    let skills: [String]
    let title: String
    let questionnaireLink: String
    let itSelf: PFObject
    
    init(object: PFObject) {
        self.itSelf = object
        self.id = object.objectId!
        let data = object.object(forKey: "company") as! PFObject
        self.compID = data.objectId!
        self.minSalary = object.object(forKey: "minSalary") as! Int
        self.maxSalary = object.object(forKey: "maxSalary") as! Int
        self.benefits = object.object(forKey: "benefits") as! [String]
        self.skills = object.object(forKey: "skills") as! [String]
        self.title = object.object(forKey: "title") as! String
        self.questionnaireLink = object.object(forKey: "questionnaire") as! String
        
    }
    
    
}
