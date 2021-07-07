//
//  OffersCell.swift
//  Supplment Bazar
//
//  Created by Ameer on 01/07/2021.
//

import UIKit
import FSPagerView

class OffersCell: UICollectionViewCell {
    
    var items = [ProductResponse]() {
        didSet {
            pageControl.numberOfPages = items.count
            pageControl.currentPage = 0
            pagerView.reloadData()
        }
    }
    
    let pagerView = FSPagerView()
    let pageControl = FSPageControl()
    
    var selectItem: ((String) -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        pagerView.dataSource = self
        pagerView.delegate = self
        pagerView.register(UINib(nibName: "OfferCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        pagerView.translatesAutoresizingMaskIntoConstraints = false
        pagerView.isInfinite = true
        pagerView.automaticSlidingInterval = 5
        self.addSubview(pagerView)
        
        pageControl.setFillColor(.primary, for: .selected)
        pageControl.setFillColor(.lightGray, for: .normal)
        pageControl.setStrokeColor(.primary, for: .selected)
        pageControl.setStrokeColor(.lightGray, for: .normal)
        pageControl.hidesForSinglePage = true
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(pageControl)
        
        NSLayoutConstraint.activate([
            pagerView.topAnchor.constraint(equalTo: topAnchor),
            pagerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            pagerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            pageControl.bottomAnchor.constraint(equalTo: bottomAnchor),
            pageControl.leadingAnchor.constraint(equalTo: leadingAnchor),
            pageControl.trailingAnchor.constraint(equalTo: trailingAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 26),
            pagerView.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: -8)
        ])
        
        pagerView.itemSize = CGSize(width: pagerView.frame.width, height: pagerView.frame.height)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension OffersCell: FSPagerViewDataSource, FSPagerViewDelegate {
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        items.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index) as! OfferCell
        cell.setup(data: items[index])
        return cell
    }
        
    func pagerView(_ pagerView: FSPagerView, willDisplay cell: FSPagerViewCell, forItemAt index: Int) {
        pageControl.currentPage = index
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        if let select = selectItem {
            select(items[index].id)
        }
    }
    
}
