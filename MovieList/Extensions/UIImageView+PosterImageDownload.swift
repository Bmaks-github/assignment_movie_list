////
////  UIImageView+ImageDownload.swift
////  MovieList
////
////  Created by Maksym Bura on 09.03.2022.
////
//
//import UIKit
//
//extension UIImageView {
//    func load(posterPath: String?) {
//        guard let posterPath = posterPath else { return }
//
//        MovieImageService().getImage(posterPath: posterPath) { [weak self] result in
//            switch result {
//            case let .success(data):
//                if let image = UIImage(data: data) {
//                    DispatchQueue.main.async {
//                        self?.image = image
//                    }
//                }
//            case .failure(_):
//                break
//            }
//        }
//    }
//}
