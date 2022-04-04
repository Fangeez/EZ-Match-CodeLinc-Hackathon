//
//  CompanyDetailsViewController.swift
//  EZ Match
//
//  Created by Subomi Popoola on 4/3/22.
//

import UIKit
import Parse

class CompanyDetailsViewController: UIViewController {
    
    let company: PFObject
    let job: JobRole
    let compImg = UIImageView()
    let nameLbl = UILabel()
    let visionLbl = UILabel()
    let locLbl = UILabel()
    
    init(company: PFObject, job: JobRole) {
        self.company = company
        self.job = job
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setUI()
    }
    
    func setUI() {
        compImg.frame.origin.x = 0.0
        compImg.frame.origin.y = 95.0
        compImg.frame.size.width = view.frame.size.width
        compImg.frame.size.height = 100.0
        let compFile = company.object(forKey: "image") as! PFFileObject
        compFile.getDataInBackground { (imageData: Data?, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else if let imageData = imageData {
                let image = UIImage(data: imageData)
                self.compImg.image = image
                self.compImg.contentMode = .scaleAspectFill
            }
        }
        
        view.addSubview(compImg)
        
        let nText = company.object(forKey: "name") as! String
        nameLbl.frame.origin.x = 10.0
        nameLbl.frame.origin.y = compImg.frame.size.height + compImg.frame.origin.y + 20.0
        nameLbl.frame.size.width = view.frame.size.width - 20.0
        nameLbl.numberOfLines = 1
        nameLbl.text = nText
        nameLbl.textAlignment = .left
        nameLbl.font = UIFont(name: "HelveticaNeue-Bold", size: 30.0)
        nameLbl.sizeToFit()
        view.addSubview(nameLbl)
        
        let vText = company.object(forKey: "vision") as! String
        visionLbl.frame.origin.x = 10.0
        visionLbl.frame.origin.y = nameLbl.frame.size.height + nameLbl.frame.origin.y + 20.0
        visionLbl.frame.size.width = view.frame.size.width - 20.0
        visionLbl.numberOfLines = 0
        visionLbl.font = UIFont(name: "HelveticaNeue", size: 20.0)
        visionLbl.text = vText
        visionLbl.sizeToFit()
        view.addSubview(visionLbl)
        
        let aText = company.object(forKey: "location") as! String
        locLbl.frame.origin.x = 10.0
        locLbl.frame.origin.y = visionLbl.frame.size.height + visionLbl.frame.origin.y + 20.0
        locLbl.frame.size.width = view.frame.size.width - 20.0
        locLbl.numberOfLines = 0
        locLbl.font = UIFont(name: "HelveticaNeue", size: 20.0)
        locLbl.text = aText
        locLbl.sizeToFit()
        view.addSubview(locLbl)
        
        let titleLbl = UILabel()
        titleLbl.frame.origin.x = 10.0
        titleLbl.frame.origin.y = locLbl.frame.size.height + locLbl.frame.origin.y + 40.0
        titleLbl.frame.size.width = view.frame.size.width - 20.0
        titleLbl.numberOfLines = 1
        titleLbl.font = UIFont(name: "HelveticaNeue-Bold", size: 20.0)
        titleLbl.text = job.title
        titleLbl.sizeToFit()
        view.addSubview(titleLbl)
        
        let minSalLbl = UILabel()
        minSalLbl.frame.origin.x = 10.0
        minSalLbl.frame.origin.y = titleLbl.frame.size.height + titleLbl.frame.origin.y + 20.0
        minSalLbl.frame.size.width = view.frame.size.width - 20.0
        minSalLbl.numberOfLines = 1
        minSalLbl.font = UIFont(name: "HelveticaNeue", size: 20.0)
        minSalLbl.text = "Minimum Salary: \(String(describing: job.minSalary))"
        minSalLbl.sizeToFit()
        view.addSubview(minSalLbl)
        
        let maxSalLbl = UILabel()
        maxSalLbl.frame.origin.x = 10.0
        maxSalLbl.frame.origin.y = minSalLbl.frame.size.height + minSalLbl.frame.origin.y + 20.0
        maxSalLbl.frame.size.width = view.frame.size.width - 20.0
        maxSalLbl.numberOfLines = 1
        maxSalLbl.font = UIFont(name: "HelveticaNeue", size: 20.0)
        maxSalLbl.text = "Maximum Salary: \(String(describing: job.maxSalary))"
        maxSalLbl.sizeToFit()
        view.addSubview(maxSalLbl)
        
        let benefitLbl = UILabel()
        benefitLbl.frame.origin.x = 10.0
        benefitLbl.frame.origin.y = maxSalLbl.frame.size.height + maxSalLbl.frame.origin.y + 20.0
        benefitLbl.frame.size.width = view.frame.size.width - 20.0
        benefitLbl.numberOfLines = 0
        benefitLbl.font = UIFont(name: "HelveticaNeue", size: 20.0)
        let bText = job.benefits.joined(separator: ", ")
        benefitLbl.text = "Benefits: \(bText)"
        benefitLbl.sizeToFit()
        view.addSubview(benefitLbl)
        
        let skillLbl = UILabel()
        skillLbl.frame.origin.x = 10.0
        skillLbl.frame.origin.y = benefitLbl.frame.size.height + benefitLbl.frame.origin.y + 20.0
        skillLbl.frame.size.width = view.frame.size.width - 20.0
        skillLbl.numberOfLines = 0
        skillLbl.font = UIFont(name: "HelveticaNeue", size: 20.0)
        let uSkills = PFUser.current()?.object(forKey: "skills") as! [String]
        let mSkills = intersect(a: uSkills, b: job.skills)
        let sText = mSkills.joined(separator: ", ")
        skillLbl.text = "Matched Skills: \(sText)"
        skillLbl.sizeToFit()
        view.addSubview(skillLbl)
        
        let sg = UISwipeGestureRecognizer()
        sg.direction = .down
        sg.addTarget(self, action: #selector(dissView))
        view.addGestureRecognizer(sg)
    }
    
    @objc func dissView() {
        dismiss(animated: true)
    }
    
    func intersect(a: [String], b: [String]) -> [String] {
        var res = [String]()
        for x in a {
            if b.contains(x) {
                res.append(x)
            }
        }
        return res
    }

}
