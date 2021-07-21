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
            collectionView.reloadData()
        }
    }
    
    fileprivate var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.isPagingEnabled = true
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .clear
        return collection
    }()
    
    fileprivate let pageControl = FSPageControl()
    
    var selectItem: ((String) -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(UINib(nibName: "OfferCell", bundle: nil), forCellWithReuseIdentifier: "cell")
//        pagerView.automaticSlidingInterval = 5
        self.addSubview(collectionView)
        
        pageControl.setFillColor(.primary, for: .selected)
        pageControl.setFillColor(.lightGray, for: .normal)
        pageControl.setStrokeColor(.primary, for: .selected)
        pageControl.setStrokeColor(.lightGray, for: .normal)
        pageControl.hidesForSinglePage = true
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(pageControl)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            pageControl.bottomAnchor.constraint(equalTo: bottomAnchor),
            pageControl.leadingAnchor.constraint(equalTo: leadingAnchor),
            pageControl.trailingAnchor.constraint(equalTo: trailingAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 26),
            collectionView.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: -8)
        ])
        
//        pagerView.itemSize = CGSize(width: pagerView.frame.width, height: pagerView.frame.height)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension OffersCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! OfferCell
        cell.setup(data: items[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageControl.currentPage = indexPath.row
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let select = selectItem {
            select(items[indexPath.row].id)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

//extension OffersCell: FSPagerViewDataSource, FSPagerViewDelegate {
//
//    func numberOfItems(in pagerView: FSPagerView) -> Int {
//        items.count
//    }
//
//    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
//        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index) as! OfferCell
//        cell.setup(data: items[index])
//        return cell
//    }
//
//    func pagerView(_ pagerView: FSPagerView, willDisplay cell: FSPagerViewCell, forItemAt index: Int) {
//        pageControl.currentPage = index
//    }
//
//    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
//        if let select = selectItem {
//            select(items[index].id)
//        }
//    }
//
//}
