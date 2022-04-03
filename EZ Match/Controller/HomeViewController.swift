//
//  HomeViewController.swift
//  EZ Match
//
//  Created by Subomi Popoola on 4/2/22.
//

import UIKit
import Koloda

class HomeViewController: UIViewController {
    
    private let swipeView = KolodaView()
    private let feed = [JobRole]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        swipeView.delegate = self
//        swipeView.dataSource = self
        let width = view.frame.size.width
        let height = view.frame.size.height
        let rect = CGRect(x: 0.0, y: 0.0, width: width, height: height * 0.8)
        let tola = JobView(frame: rect)
        view.addSubview(tola)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HomeViewController: KolodaViewDelegate {

}

extension HomeViewController: KolodaViewDataSource {
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        return UIView()
    }
    
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return feed.count
    }
    
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .moderate
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
    
    let startColor: UIColor = .clear
    let endColor: UIColor = UIColor(red: 0/255, green: 0/252, blue: 0/255, alpha: 0.85)

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        isOpaque = false
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
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
        let width = frame.size.width
        let height = frame.size.height
        
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
        
        nameLabel.text = "Meta"
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
        let width = frame.size.width
        
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
        
        backgroundImageView.frame.origin.x = 0
        backgroundImageView.frame.origin.y = vSpace
        backgroundImageView.frame.size.width = width
        backgroundImageView.frame.size.height = frame.size.height * 0.855
        backgroundImageView.contentMode = .scaleAspectFill
        addSubview(backgroundImageView)
        
        setupVLabel()
    }
    
    func setupVLabel() {
        let width = frame.size.width
        let height = frame.size.height
        
        let hSpace = 12.0
        visionLabel.text = "Originally founded in 2004 as Facebook, Meta’s mission is to give people the power to build and bring community together"
        visionLabel.numberOfLines = 3
        visionLabel.textAlignment = .center
        visionLabel.frame.origin.x = hSpace
        visionLabel.frame.origin.y = height + 15.0
        visionLabel.frame.size.width = width - (hSpace * 2)
        visionLabel.frame.size.height = 50.0
        addSubview(visionLabel)
    }
}
