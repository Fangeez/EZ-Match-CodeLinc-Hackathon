
//  EditProfileView.swift
//  EZ Match
//
//  Created by Harris Dawurang on 4/3/22.
//

import Foundation
import UIKit
import CoreGraphics
import Parse


class EditProfileView: UIView {
    
    var imageView: UIImageView!
    var editButton: UIButton!
    var name: UILabel!
    var nameTextField: UITextField!
    var school: UILabel!
    var schoolTextField: UITextField!
    var gpaa: UILabel!
    var gpaTextField: UITextField!
    var salary: UILabel!
    var salaryTextField: UITextField!
    var resumeLabel: UILabel!
    var resumeFilePath: UILabel!
    var uploadResumeButton: UIButton!
    var editPreferences: UIButton!
    var logOutButton: UIButton!
    

//    var skills: [String]
//    var firstName: String
//    var lastName: String
//    var nameString: String
//    var gpa: Double
//    var user: PFUser
//
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    func configureData(){
        
        let user = PFUser.current()
        let compImg = user?.object(forKey: "image") as! PFFileObject
                compImg.getDataInBackground { (imageData: Data?, error: Error?) in
                    if let error = error {
                        print(error.localizedDescription)
                    } else if let imageData = imageData {
                        let image = UIImage(data: imageData)
                        self.imageView.image = image
                    }
                }
        
        let preferredSal = user!["preferredSalary"] as! Int
        let edu  = user!["education"] as! String
        let skills = user!["skills"] as! [String]
        let firstName = user!["firstName"] as! String
        let lastName = user!["lastName"] as! String
        let nameString = firstName + " " + lastName
        let gpa = user!["gpa"] as! Double
        
        nameTextField.text = nameString
        schoolTextField.text = edu
        salaryTextField.text = "\(String(describing: preferredSal))"
        gpaTextField.text = "\(String(describing: gpa))"
        
        
        
        
    }
    
    func loginUser() {
            PFUser.logInWithUsername(inBackground:"subomi", password:"subomi") {
              (user: PFUser?, error: Error?) -> Void in
              if user != nil {
                  print("YES")
              } else {
                print(error)
              }
            }
        }
    
    func setUpUI() {
        
        let sysBounds = UIScreen.main.bounds.size
        imageView = UIImageView(image: UIImage(systemName: "Test"))
        imageView.frame.size.height = 110
        imageView.frame.size.width = 110
        imageView.frame.origin.x = sysBounds.width / 2 - imageView.frame.size.width / 2
        imageView.frame.origin.y = 80
        imageView.image = UIImage(systemName: "person.fill")
        
        imageView.layer.borderWidth = 1
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = CGColor(red: 0.46, green: 0.078, blue: 0.486, alpha: 1)
        imageView.layer.cornerRadius = imageView.frame.height/2
        imageView.clipsToBounds = true
        self.addSubview(imageView)
        
        
        editButton = UIButton(frame: CGRect.zero)
        editButton.frame.size.height = 25
        editButton.frame.size.width = 25
        editButton.frame.origin.x = imageView.frame.maxX + 15
        editButton.frame.origin.y = imageView.frame.maxY + imageView.frame.size.height / 2
        
        editButton.setTitle("Edit", for: .normal)
        editButton.titleLabel?.textColor = UIColor(named: "AppColor")
        
        self.addSubview(editButton)
        
        name = UILabel(frame: CGRect.zero)
        name.text = "Name"
        name.frame.size.width = 100
        name.frame.size.height = 40
        name.frame.origin.x = 100
        name.frame.origin.y = imageView.frame.maxY + 20
        name.font = name.font.withSize(25)
        
        nameTextField = UITextField(frame: CGRect.zero)
        nameTextField.frame.size.width = 150
        nameTextField.frame.size.height = 40
        nameTextField.frame.origin.x = name.frame.maxX + 20
        nameTextField.frame.origin.y = name.frame.origin.y
        nameTextField.layer.borderColor = CGColor(red: 0.46, green: 0.078, blue: 0.486, alpha: 1)
        
        let customFont = UIFont.init(name: (nameTextField.font?.fontName)!, size: 25.0)
        nameTextField.font = customFont
        
        self.addSubview(name)
        self.addSubview(nameTextField)
        
        school = UILabel(frame: CGRect.zero)
        school.text = "School"
        school.frame.size.width = 100
        school.frame.size.height = 40
        school.frame.origin.x = 100
        school.frame.origin.y = name.frame.maxY + 20
        school.font = school.font.withSize(25)
        
        schoolTextField = UITextField(frame: CGRect.zero)
        schoolTextField.frame.size.width = 150
        schoolTextField.frame.size.height = 40
        schoolTextField.frame.origin.x = school.frame.maxX + 20
        schoolTextField.frame.origin.y = school.frame.origin.y
        schoolTextField.layer.borderColor = CGColor(red: 0.46, green: 0.078, blue: 0.486, alpha: 1)
        schoolTextField.font = customFont
        self.addSubview(school)
        self.addSubview(schoolTextField)
        
        gpaa = UILabel(frame: CGRect.zero)
        gpaa.text = "GPA"
        gpaa.frame.size.width = 100
        gpaa.frame.size.height = 40
        gpaa.frame.origin.x = 100
        gpaa.frame.origin.y = school.frame.maxY + 20
        gpaa.font = gpaa.font.withSize(25)
        
        
        gpaTextField = UITextField(frame: CGRect.zero)
        gpaTextField.frame.size.width = 150
        gpaTextField.frame.size.height = 40
        gpaTextField.frame.origin.x = gpaa.frame.maxX + 20
        gpaTextField.frame.origin.y = gpaa.frame.origin.y
        gpaTextField.layer.borderColor = CGColor(red: 0.46, green: 0.078, blue: 0.486, alpha: 1)
        gpaTextField.font = customFont
        
        self.addSubview(gpaa)
        self.addSubview(gpaTextField)
        
        
        
        
        
        salary = UILabel(frame: CGRect.zero)
        salary.text = "Salary"
        salary.frame.size.width = 150
        salary.frame.size.height = 40
        salary.frame.origin.x = 100
        salary.frame.origin.y = gpaa.frame.maxY + 20
        salary.font = salary.font.withSize(25)
        
        salaryTextField = UITextField(frame: CGRect.zero)
        salaryTextField.frame.size.width = 150
        salaryTextField.frame.size.height = 40
        salaryTextField.frame.origin.x = salary.frame.maxX + 20
        salaryTextField.frame.origin.y = salary.frame.origin.y
        salaryTextField.layer.borderColor = CGColor(red: 0.46, green: 0.078, blue: 0.486, alpha: 1)
        salaryTextField.font = customFont
        
        
        self.addSubview(salary)
        self.addSubview(salaryTextField)
        
        resumeLabel = UILabel(frame: CGRect.zero)
        resumeLabel.text = "Resume"
        resumeLabel.frame.size.width = 150
        resumeLabel.frame.size.height = 40
        resumeLabel.frame.origin.x = 100
        resumeLabel.frame.origin.y = salary.frame.maxY + 20
        resumeLabel.font = resumeLabel.font.withSize(25)
        
       
        resumeFilePath = UILabel(frame: CGRect.zero)
        resumeFilePath.frame.size.width = 80
        resumeFilePath.frame.size.height = 40
        resumeFilePath.frame.origin.x = resumeLabel.frame.maxX + 20
        resumeFilePath.frame.origin.y = resumeLabel.frame.origin.y
        resumeFilePath.text = "john's_resume.pdf"
        
        uploadResumeButton = UIButton(frame: CGRect.zero)
        uploadResumeButton.setTitle("Upload", for: .normal)
        uploadResumeButton.titleLabel?.textColor = UIColor(named: "AppColor")
        uploadResumeButton.frame.size.width = 20
        uploadResumeButton.frame.size.height = 20
        uploadResumeButton.frame.origin.x = resumeFilePath.frame.maxX + 5
        uploadResumeButton.frame.origin.y = resumeLabel.frame.origin.y
        
        self.addSubview(resumeLabel)
        self.addSubview(resumeFilePath)
//        self.addSubview(uploadResumeButton)
        
        
        editPreferences = UIButton(frame: CGRect.zero)
        editPreferences.setTitle("Edit preferences", for: .normal)
        editPreferences.frame.size.width = 150
        editPreferences.frame.size.height = 60
        editPreferences.frame.origin.x = sysBounds.width / 2 - editPreferences.frame.size.width / 2
        editPreferences.frame.origin.y = resumeLabel.frame.maxY + 40
        editPreferences.backgroundColor = UIColor(named: "AppColor")
        self.addSubview(editPreferences)
        
        logOutButton = UIButton(frame: CGRect.zero)
        logOutButton.setTitle("Log Out", for: .normal)
        logOutButton.frame.size.width = 150
        logOutButton.frame.size.height = 60
        logOutButton.frame.origin.x = editPreferences.frame.minX
        logOutButton.frame.origin.y = editPreferences.frame.maxY + 20
        logOutButton.backgroundColor = UIColor.red
        self.addSubview(logOutButton)
        
        
        
        
    }
    
}
