//
//  HomeViewController.swift
//  EZ Match
//
//  Created by Subomi Popoola on 4/2/22.
//

import UIKit
import Parse
import Koloda
import DropDown

class HomeViewController: UIViewController {
    
    private let swipeView = KolodaView()
    private var feed = [JobRole]()
    var company = [String: PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        swipeView.delegate = self
        swipeView.dataSource = self
        let width = view.frame.size.width
        let height = view.frame.size.height
        swipeView.frame = CGRect(x: 0.0, y: height * 0.1, width: width, height: height * 0.75)
        view.addSubview(swipeView)
        loginUser()
    }
    
    func loginUser() {
        PFUser.logInWithUsername(inBackground:"subomi", password:"subomi") {
          (user: PFUser?, error: Error?) -> Void in
          if user != nil {
              self.queryFeed()
          } else {
            // The login failed. Check error to see why.
          }
        }
    }
    
    func queryFeed() {
        let user = PFUser.current()
        let preferredSal = user!["preferredSalary"] as! Int
        let userSkills = user!["skills"] as! [String]
        let query = PFQuery(className:"JobRoles")
        query.whereKey("minSalary", greaterThanOrEqualTo: preferredSal)
        query.whereKey("skills", containedIn: userSkills)
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            if let error = error {
                // Log details of the failure
                print(error.localizedDescription)
            } else if let objects = objects {
                var data = [JobRole]()
                var compIDS = [String]()
                for object in objects {
                   let role = JobRole(object: object)
                   data.append(role)
                   compIDS.append(role.compID)
                }
                self.feed = data
                self.queryCompIDs(ids: compIDS)
            }
        }
    }
    
    func queryCompIDs(ids: [String]) {
        let query = PFQuery(className:"Company")
        query.whereKey("objectId", containedIn: ids)
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            if let error = error {
                // Log details of the failure
                print(error.localizedDescription)
            } else if let objects = objects {
                for object in objects {
                    self.company[object.objectId!] = object
                }
                self.swipeView.reloadData()
            }
        }
    }
    
    func saveApplication(jobID: JobRole) {
        let userID = PFUser.current()
        let status = "applied"
        let appObject = PFObject(className: "Applications")
        appObject["user"] = userID
        appObject["status"] = status
        appObject["jobRole"] = jobID.itSelf
        appObject["company"] = company[jobID.compID]
        appObject.saveInBackground { success, error in
            if success {
                print("YESSIR")
            } else {
                print("NO")
            }
        }
    }

}

extension HomeViewController: KolodaViewDelegate {
    func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection) {
        let role = feed[index]
        switch direction {
        case .left:
            break
        case .right:
            saveApplication(jobID: role)
        case .up:
            break
        case .down:
            break
        case .topLeft:
            break
        case .topRight:
            saveApplication(jobID: role)
        case .bottomLeft:
            break
        case .bottomRight:
            saveApplication(jobID: role)
        }
    }
    
    func presentController(comp: PFObject, job: JobRole) {
        let cd = CompanyDetailsViewController(company: comp, job: job)
        self.present(cd, animated: true, completion: nil)
    }
}

extension HomeViewController: KolodaViewDataSource {
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        let role = feed[index]
        let width = view.frame.size.width
        let height = view.frame.size.height
        let v =  JobView(frame: CGRect(x: 0.0, y: height * 0.1, width: width, height: height * 0.75))
        v.jobTitleLabel.text = role.title
        let user = PFUser.current()
        let workOpt = user!["workOption"] as! String
        v.workOptionLabel.text = workOpt
        let compData = company[role.compID] as! PFObject
        let compType = compData.object(forKey: "companyType") as! String
        v.companyTypeLabel.text = compType
        let name = compData.object(forKey: "name") as! String
        v.nameLabel.text = name
        let compImg = compData.object(forKey: "image") as! PFFileObject
        compImg.getDataInBackground { (imageData: Data?, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else if let imageData = imageData {
                let image = UIImage(data: imageData)
                v.backgroundImageView.image = image
                v.backgroundImageView.contentMode = .scaleAspectFill
            }
        }
        v.layer.cornerRadius = 20
        v.clipsToBounds = true
        return v
        return UIView()
    }
    
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return feed.count
    }
    
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .fast
    }
    
    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
        let role = feed[index]
        let comp = company[role.compID]
        presentController(comp: comp!, job: role)
    }

}

class JobView: UIView {
    
    let jobTitleLabel = UILabel()
    let workOptionLabel = UILabel()
    let companyTypeLabel = UILabel()
    let backgroundImageView = UIImageView()
    let heartImageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "heart"))
        image.frame.size.width = 45.0
        image.frame.size.height = 45.0
        return image
    }()
    let cancelImageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "cancel"))
        image.frame.size.width = 45.0
        image.frame.size.height = 45.0
        return image
    }()
    let dropupView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "dropup"))
        image.frame.size.width = 30.0
        image.frame.size.height = 15.0
        image.sizeToFit()
        return image
    }()
    let nameLabel = UILabel()
    let visionLabel = UILabel()
    var frect = CGRect()
    
    let startColor: UIColor = .white
    let endColor: UIColor = UIColor(red: 0/255, green: 0/252, blue: 0/255, alpha: 0.85)

    override init(frame: CGRect) {
        self.frect = frame
        super.init(frame: frame)
        backgroundColor = .white
        isOpaque = false
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .white
        isOpaque = false
    }

    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()!
        let colors = [startColor.cgColor, endColor.cgColor]

        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colorLocations: [CGFloat] = [0.855, 1.0]
        let gradient = CGGradient(colorsSpace: colorSpace,
                                  colors: colors as CFArray,
                                  locations: colorLocations)!

        let startPoint = CGPoint.zero
        let endPoint = CGPoint(x: 0, y: bounds.height)
        context.drawLinearGradient(gradient,
                                   start: startPoint,
                                   end: endPoint,
                                   options: [])
        
        setupUI()
    }
    
    func setupUI() {
        let width = frect.size.width
        let height = frect.size.height
      
        
        let sideSpace = 15.0
        let bottomSpace = 25.0
        
        let imgY = height - (heartImageView.frame.size.height + bottomSpace)
        heartImageView.frame.origin.x = sideSpace
        heartImageView.frame.origin.y = imgY
        heartImageView.backgroundColor = .white
        heartImageView.layer.cornerRadius = 22.5
        heartImageView.layer.shadowColor = UIColor.black.cgColor
        heartImageView.layer.shadowRadius = 5
        heartImageView.layer.shadowOpacity = 0.80
        addSubview(heartImageView)
        
        cancelImageView.frame.origin.x = width - (cancelImageView.frame.size.width + sideSpace)
        cancelImageView.frame.origin.y = imgY
        cancelImageView.backgroundColor = .white
        cancelImageView.layer.cornerRadius = 22.5
        cancelImageView.layer.shadowColor = UIColor.black.cgColor
        cancelImageView.layer.shadowRadius = 5
        cancelImageView.layer.shadowOpacity = 0.80
        addSubview(cancelImageView)
        
        nameLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 30.0)
        nameLabel.textColor = .white
        nameLabel.sizeToFit()
        let nameX = (width - nameLabel.frame.size.width) / 2.0
        addSubview(nameLabel)
        nameLabel.frame.origin.x = nameX
        nameLabel.frame.origin.y = imgY - 10.0
        
        let dropImgY = nameLabel.frame.origin.y + nameLabel.frame.size.height + 7.0
        let dropImgX = (width - dropupView.frame.size.width) / 2.0
        dropupView.frame.origin.x = dropImgX
        dropupView.frame.origin.y = dropImgY
        addSubview(dropupView)
        setHeadView()
    }
    
    func setHeadView() {
        let width = frect.size.width
        
        let headWidth = 80.0
        let hSpace = 12.0
        let vSpace = 80.0
        let startX = (width - ((headWidth * 3) + (hSpace * 2))) / 2.0
        
        jobTitleLabel.text = "SWE"
        jobTitleLabel.textAlignment = .center
        jobTitleLabel.frame.origin.x = startX
        jobTitleLabel.frame.origin.y = vSpace
        jobTitleLabel.frame.size.width = headWidth
        jobTitleLabel.frame.size.height = 30.0
        jobTitleLabel.layer.cornerRadius = 7.5
        jobTitleLabel.layer.masksToBounds = true
        jobTitleLabel.backgroundColor = UIColor(red: 128/255, green: 0.0, blue: 128/255, alpha: 1)
        jobTitleLabel.textColor = .white
        addSubview(jobTitleLabel)
        
        workOptionLabel.text = "HYBRID"
        workOptionLabel.textAlignment = .center
        workOptionLabel.frame.origin.x = jobTitleLabel.frame.origin.x + jobTitleLabel.frame.size.width + hSpace
        workOptionLabel.frame.origin.y = vSpace
        workOptionLabel.frame.size.width = headWidth
        workOptionLabel.frame.size.height = 30.0
        workOptionLabel.layer.cornerRadius = 7.5
        workOptionLabel.layer.masksToBounds = true
        workOptionLabel.backgroundColor = UIColor(red: 128/255, green: 0.0, blue: 128/255, alpha: 1)
        workOptionLabel.textColor = .white
        addSubview(workOptionLabel)
        
        companyTypeLabel.text = "FAANG"
        companyTypeLabel.textAlignment = .center
        companyTypeLabel.frame.origin.x = workOptionLabel.frame.origin.x + workOptionLabel.frame.size.width + hSpace
        companyTypeLabel.frame.origin.y = vSpace
        companyTypeLabel.frame.size.width = headWidth
        companyTypeLabel.frame.size.height = 30.0
        companyTypeLabel.layer.cornerRadius = 7.5
        companyTypeLabel.layer.masksToBounds = true
        companyTypeLabel.backgroundColor = UIColor(red: 128/255, green: 0.0, blue: 128/255, alpha: 1)
        companyTypeLabel.textColor = .white
        addSubview(companyTypeLabel)
        
        backgroundImageView.frame.origin.x = 0.0
        backgroundImageView.frame.origin.y = 215
        backgroundImageView.frame.size.width = width
        backgroundImageView.frame.size.height = 275
        backgroundImageView.contentMode = .scaleAspectFill
        addSubview(backgroundImageView)
     
    }
    
}


