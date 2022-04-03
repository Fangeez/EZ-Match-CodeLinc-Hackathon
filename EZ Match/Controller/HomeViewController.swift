//
//  HomeViewController.swift
//  EZ Match
//
//  Created by Subomi Popoola on 4/2/22.
//

import UIKit
import Koloda
import DropDown

class HomeViewController: UIViewController {
    
    private let swipeView = KolodaView()
    private let feed = [JobRole]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        swipeView.delegate = self
        swipeView.dataSource = self
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
    
    let jobTitleView = UIView()
    let workOptionView = UIView()
    let companyTypeView = UIView()
    let backgroundImageView = UIImageView()
    let heartImageView = UIImageView()
    let cancelImageView = UIImageView()
    let dropupView = UIView()
    let nameLabel = UILabel()
    let gradientView = UIView()
    
    func setupUI() {
        let width = frame.size.width
        let height = frame.size.height
        
        let lowerViewHeight = height * 0.1
        let lowerViewY = height - lowerViewHeight
        
        gradientView.frame.size.width = width
        gradientView.frame.size.height = lowerViewHeight
        gradientView.frame.origin.y = lowerViewY
        gradientView.frame.origin.x = 0.0
        
        addSubview(gradientView)
        
        let mGradient = CAGradientLayer()
        
    }
}
