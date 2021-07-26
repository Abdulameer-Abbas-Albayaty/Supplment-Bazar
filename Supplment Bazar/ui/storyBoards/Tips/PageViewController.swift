//
//  PageViewController.swift
//  Supplment Bazar
//
//  Created by Ameer on 23/07/2021.
//

import UIKit

@objc protocol TipsDelegate {
    @objc optional func goNextPage(forwardTo position: Int)
    @objc optional func goPreviousPage(fowardTo position: Int)
}

class PageViewController: UIPageViewController, TipsDelegate {

    let firstView = FirstViewController()
    let secondView = SecondViewController()
    let thirdView = ThirdViewController()
    
    fileprivate lazy var subViewControllers = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        subViewControllers = [firstView,secondView,thirdView]
        firstView.delegate = self
        secondView.delegate = self

        self.delegate = self
        self.dataSource = self
        
        setViewControllers([subViewControllers[0]], direction: .forward, animated: true, completion: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(skipTapped), name: .skipTapped, object: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    @objc
    func skipTapped() {
        UserUD.isTipsShown = true
        Navigator.toTabs().changeRoot()
    }
    
    func goNextPage(forwardTo position: Int) {
        setViewControllers([subViewControllers[position]], direction: .forward, animated: true, completion: nil)
    }
    
    func goPreviousPage(fowardTo position: Int) {
        if let viewController = self.viewControllers?[position] {
            setViewControllers([viewController], direction: .reverse, animated: true, completion: nil)
        }
    }

}

extension PageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return subViewControllers.count
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let current = subViewControllers.firstIndex(of: viewController) ?? 0
        if current <= 0 {
            return nil
        }
        return subViewControllers[current - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let current = subViewControllers.firstIndex(of: viewController) ?? 0
        if current >= (subViewControllers.count - 1) {
            return nil
        }
        return subViewControllers[current + 1]
    }
    
}


class FirstViewController: UIViewController {
    
    var delegate: TipsDelegate?
    fileprivate var page = UIPageControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.background
        if let tipView = Bundle.main.loadNibNamed("TipsView", owner: nil, options: nil)?.first as? TipsView {
            tipView.setupView(view: view)
            tipView.update(image: #imageLiteral(resourceName: "healthy_habit"), title: "step1".getLocalized(), details: "step1_details".getLocalized())
        }
        
        setupPageControl()
    }
    
    fileprivate func setupPageControl() {
        page.pageIndicatorTintColor = UIColor.gray
        page.currentPageIndicatorTintColor = UIColor.primary
        page.numberOfPages = 3
        page.currentPage = 0
        page.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(page)
        NSLayoutConstraint.activate([
            page.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -48),
            page.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            page.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    @objc func handleButton() {
        delegate?.goNextPage?(forwardTo: 1)
    }
    
}

class SecondViewController: UIViewController {
    
    var delegate: TipsDelegate?
    fileprivate var page = UIPageControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.background
        if let tipView = Bundle.main.loadNibNamed("TipsView", owner: nil, options: nil)?.first as? TipsView {
            tipView.setupView(view: view)
            tipView.update(image: #imageLiteral(resourceName: "workout"), title: "step2".getLocalized(), details: "step2_details".getLocalized())
        }
        setupPageControl()
    }
    
    @objc func handleButton() {
        delegate?.goNextPage?(forwardTo: 2)
    }
    
    fileprivate func setupPageControl() {
        page.pageIndicatorTintColor = UIColor.gray
        page.currentPageIndicatorTintColor = UIColor.primary
        page.numberOfPages = 3
        page.currentPage = 1
        page.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(page)
        NSLayoutConstraint.activate([
            page.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -48),
            page.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            page.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
}

class ThirdViewController: UIViewController {
    
    fileprivate var page = UIPageControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.background
        if let tipView = Bundle.main.loadNibNamed("TipsView", owner: nil, options: nil)?.first as? TipsView {
            tipView.setupView(view: view)
            tipView.update(image: #imageLiteral(resourceName: "bike_delivery"), title: "step3".getLocalized(), details: "step3_details".getLocalized())
        }
        setupPageControl()
    }
    
    @objc func handleButton() {
        UserUD.isTipsShown = true
        self.dismiss(animated: true, completion: nil)
    }
    
    fileprivate func setupPageControl() {
        page.pageIndicatorTintColor = UIColor.gray
        page.currentPageIndicatorTintColor = UIColor.primary
        page.numberOfPages = 3
        page.currentPage = 2
        page.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(page)
        NSLayoutConstraint.activate([
            page.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -48),
            page.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            page.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
}

