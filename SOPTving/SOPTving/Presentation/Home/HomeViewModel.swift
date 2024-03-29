//
//  MainHomeViewModel.swift
//  SOPTving
//
//  Created by 김민재 on 2023/04/30.
//

import Foundation

protocol HomeViewModelInput {
    func viewWillAppear()
}

protocol HomeViewModelOutput {
    var moviesFetched: (([Movie]?) -> Void)? { get set }
}

protocol HomeViewModel: HomeViewModelInput, HomeViewModelOutput {}


final class DefaultMainHomeViewModel: HomeViewModel {

    // MARK: - Output

    var moviesFetched: (([Movie]?) -> Void)?

    var movies: [Movie]? {
        didSet {
            self.moviesFetched?(movies)
        }
    }

    // MARK: - Properties

    private let useCase: MovieUseCase

    init(useCase: MovieUseCase) {
        self.useCase = useCase
    }
}

// MARK: - Input

extension DefaultMainHomeViewModel {
    func viewWillAppear() {
        useCase.getPopularMovie(page: 1) { movies in
            self.movies = movies
        }

    }
}
