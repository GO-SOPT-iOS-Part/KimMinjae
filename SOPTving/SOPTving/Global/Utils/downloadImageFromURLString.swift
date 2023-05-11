//
//  downloadImageFromURL.swift
//  SOPTving
//
//  Created by 김민재 on 2023/05/12.
//

import UIKit

import Kingfisher

extension String {
    func downloadImageWithURLString(completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: self) else {
            return completion(nil)
        }

        let imgResource = ImageResource(downloadURL: url)

        KingfisherManager.shared.retrieveImage(with: imgResource) { result in
            switch result {
            case .success(let imageResult):
                completion(imageResult.image)
            case .failure:
                completion(nil)
            }
        }

    }

}
