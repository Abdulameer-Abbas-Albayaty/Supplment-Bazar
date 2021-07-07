//
//  ImageViewExtension.swift
//  Supplment Bazar
//
//  Created by Ameer on 29/06/2021.
//

import UIKit
import Kingfisher

extension UIImageView {
    enum ImagePlaceHolder {
        case logo

        func image() -> UIImage {
            switch self {
            case .logo:
                return #imageLiteral(resourceName: "redcon1whey")
            }
        }
    }

    func setImage(_ urlString: String?, placeholder: ImagePlaceHolder? = nil, showIndicator: Bool = false, completion: ((UIImage?)->Void)? = nil) {
        if showIndicator {
            kf.indicatorType = .activity
        }
        let placeholderImage = placeholder?.image()
        let url = URL(string: urlString ?? "")
        kf.setImage(with: url, placeholder: placeholderImage, options: [.transition(.fade(1))]) { (result) in
            switch result {
            case .success(let kfimage):
                completion?(kfimage.image)
            case .failure:
                completion?(nil)
            }
        }
    }


    func setImageWithDownsampling(_ urlString: String?, size: CGSize, placeholder: ImagePlaceHolder? = nil, showIndicator: Bool = false) {
        let placeHolder = placeholder?.image()
        let url = URL(string: urlString ?? "")
        if showIndicator {
            kf.indicatorType = .activity
        }
        kf.setImage(
            with: url,
            placeholder: placeHolder,
            options: [
                .processor(DownsamplingImageProcessor(size: size)),
                .scaleFactor(UIScreen.main.scale),
                .cacheOriginalImage,
                .transition(.fade(1))
            ])
    }

}


