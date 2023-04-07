//
//  firstViewModel.swift
//  SOPT-32st-Assignment
//
//  Created by 김민재 on 2023/04/07.
//

import UIKit

protocol FirstViewModelInput {
    func didTapPressButton()
    func didTapPushButton()
}


protocol FirstViewModelOutput {
    var count: Observable<String> { get }
}


protocol FirstViewModel: FirstViewModelInput, FirstViewModelOutput {}

final class DefaultFirstViewModel: FirstViewModel {

    var count: Observable<String> = Observable("0")




    private func updateCount() {
        guard let curr = Int(count.value) else { return }
        count.value = String(curr + 1)
    }

}


extension DefaultFirstViewModel {
    func didTapPushButton() {
        
    }

    func didTapPressButton() {
        updateCount()
    }
}
