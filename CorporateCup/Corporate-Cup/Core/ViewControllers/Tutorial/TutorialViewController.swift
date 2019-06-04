//
//  TutorialViewController.swift
//  Corporate-Cup
//
//  Created by wesley on 25/04/2019.
//  Copyright © 2019 corporate-cup. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var startButton: UIButton!
    
    
    var slides:[TutorialSlideView] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        
        startButton.customButton(backgroundColor: UIColor.FlatColor.green, color: UIColor.white)
        startButton.isHidden = true
        
        slides = createSlides()
        setupSlideScrollView(slides: slides)
        
        pageControl.numberOfPages = slides.count
        pageControl.currentPage = 0
        view.bringSubviewToFront(pageControl)
    }
    
    func setupSlideScrollView(slides : [TutorialSlideView]) {
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
        scrollView.isPagingEnabled = true

        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            scrollView.addSubview(slides[i])
        }
    }

    func createSlides() -> [TutorialSlideView] {

        let slide1:TutorialSlideView = Bundle.main.loadNibNamed("TutorialSlide", owner: self, options: nil)?.first as! TutorialSlideView
        slide1.illustration.image = UIImage(named: "meeting")
        slide1.title.text = "Découvrez"
        slide1.text.text = "Échangez avec des nouvelles personnes de votre entreprise"

        let slide2:TutorialSlideView = Bundle.main.loadNibNamed("TutorialSlide", owner: self, options: nil)?.first as! TutorialSlideView
        slide2.illustration.image = UIImage(named: "drawers")
        slide2.title.text = "Respirez"
        slide2.text.text = "Passez un bon moment autour d'une activité avec un collègue"

        let slide3:TutorialSlideView = Bundle.main.loadNibNamed("TutorialSlide", owner: self, options: nil)?.first as! TutorialSlideView
        slide3.illustration.image = UIImage(named: "team_work")
        slide3.title.text = "Respirez"
        slide3.text.text = "Passez un bon moment autour d'une activité avec un collègue"

        return [slide1, slide2, slide3]
    }
 
    /*
     * default function called when view is scolled. In order to enable callback
     * when scrollview is scrolled, the below code needs to be called:
     * slideScrollView.delegate = self or
     */
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        
        pageControl.currentPage = Int(pageIndex)
        
        if Int(pageIndex) == slides.count - 1 {
            startButton.isHidden = false
        } else {
            startButton.isHidden = true
        }
    }
}
