//
//  ViewController.swift
//  SOPT-32st-Assignment
//
//  Created by 김민재 on 2023/04/07.
//

import UIKit

final class ViewController: UIViewController {

    // MARK: - UI Components

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "이름이 무엇인가요!?"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .blue
        label.textAlignment = .center
        return label
    }()

    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "이름을 입력해주세요"
        textField.clearButtonMode = .whileEditing
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1
        return textField
    }()

    private lazy var presentButton: UIButton = {
        let button = UIButton()
        button.setTitle("present!", for: .normal)
        button.backgroundColor = .yellow
        button.setTitleColor(.blue, for: .normal)

        button.addTarget(
            self,
            action: #selector(presentButtonTapped),
            for: .touchUpInside
        )
        return button
    }()

    private lazy var pushButton: UIButton = {
        let button = UIButton()
        button.setTitle("push!", for: .normal)
        button.backgroundColor = .yellow
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(
            self,
            action: #selector(pushButtonTapped),
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

private extension ViewController {

    func style() {
        view.backgroundColor = .white
    }

    func setLayout() {

        [
            nameLabel,
            nameTextField,
            presentButton,
            pushButton
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }

        NSLayoutConstraint.activate(
            [nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 300),
             nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
             nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)]
        )

        NSLayoutConstraint.activate(
            [nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
             nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
             nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
             nameTextField.heightAnchor.constraint(equalToConstant: 48)]
        )

        NSLayoutConstraint.activate(
            [presentButton.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
             presentButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
             presentButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
             presentButton.heightAnchor.constraint(equalToConstant: 48)]
        )

        NSLayoutConstraint.activate(
            [pushButton.topAnchor.constraint(equalTo: presentButton.bottomAnchor, constant: 20),
             pushButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
             pushButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
             pushButton.heightAnchor.constraint(equalToConstant: 48)]
        )
    }
}

// MARK: - Methods

private extension ViewController {
    func presentToSecondViewController() {
        let secondViewController = SecondViewController()
        secondViewController.modalPresentationStyle = .fullScreen
        self.present(secondViewController, animated: true)
    }

    func pushToSecondViewController() {
        guard let name = nameTextField.text else { return }
        let secondViewController = SecondViewController()
        secondViewController.dataBind(name: name)
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }

    @objc
    func presentButtonTapped() {
        presentToSecondViewController()
    }

    @objc
    func pushButtonTapped() {
        pushToSecondViewController()
    }
}
