//
//  SecondViewController.swift
//  SOPT-32st-Assignment
//
//  Created by 김민재 on 2023/04/07.
//

import UIKit

final class SecondViewController: UIViewController {

    // MARK: - Properties
    private var name = "minjae"

    // MARK: - UI Components

    private let imageView = UIImageView()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "제 이름은요!"
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()

    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setTitle("뒤로가기", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.addTarget(
            self,
            action: #selector(backButtonTapped),
            for: .touchUpInside
        )
        return button
    }()

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        setLayout()
    }
}

// MARK: - UI & Layout

private extension SecondViewController {

    func style() {
        view.backgroundColor = .white
    }

    func setLayout() {
        [imageView, nameLabel, backButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 300)
        ])

        NSLayoutConstraint.activate(
            [nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             nameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)]
        )


        NSLayoutConstraint.activate(
            [backButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
             backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
             backButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
             backButton.heightAnchor.constraint(equalToConstant: 48)]
        )
    }
}

// MARK: - Methods

extension SecondViewController {

    func dataBind(name: String) {
        if name.isEmpty {
            nameLabel.text = "누구세요?"
        } else {
            nameLabel.text = name
            imageView.image = UIImage(named: "dev")
        }
    }

    @objc
    private func backButtonTapped() {

        if self.navigationController == nil {
            self.dismiss(animated: true, completion: nil)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
}
