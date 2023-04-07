//
//  ViewController.swift
//  SOPT-32st-Assignment
//
//  Created by 김민재 on 2023/04/07.
//

import UIKit

final class ViewController: UIViewController {

    // MARK: - Properties
    var viewModel: FirstViewModel!

    // MARK: - UI Components

    private let countLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .black
        return label
    }()

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

    private lazy var pressButton: UIButton = {
        let action = UIAction { _ in
            self.viewModel.didTapPressButton()
        }
        var config = UIButton.Configuration.filled()
        config.title = "눌러 그냥"
        config.background.backgroundColor = .systemPurple
        config.baseForegroundColor = .white
        let button = UIButton(configuration: config)
        button.layer.cornerRadius = 5
        button.addAction(action, for: .touchUpInside)
        return button
    }()

    private lazy var pushButton: UIButton = {
        let action = UIAction {_ in
            self.pushToSecondViewController()
        }
        var config = UIButton.Configuration.tinted()
        config.background.backgroundColor = .yellow
        config.title = "PUSH"
        config.baseForegroundColor = .blue
        let button = UIButton(configuration: config, primaryAction: action)
        return button
    }()

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        setLayout()
        bind(with: viewModel)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        nameTextField.text?.removeAll()
    }
}

// MARK: - UI & Layout

private extension ViewController {

    func style() {
        view.backgroundColor = .white
    }

    func setLayout() {

        [
            countLabel,
            nameLabel,
            nameTextField,
            pressButton,
            pushButton
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }

        NSLayoutConstraint.activate([
            countLabel.centerXAnchor.constraint(equalTo: nameLabel.centerXAnchor),
            countLabel.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -30)
        ])

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
            [pressButton.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
             pressButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
             pressButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
             pressButton.heightAnchor.constraint(equalToConstant: 48)]
        )

        NSLayoutConstraint.activate(
            [pushButton.topAnchor.constraint(equalTo: pressButton.bottomAnchor, constant: 20),
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
        let secondViewController = ModuleFactory.shared.makeSecondViewController()
        secondViewController.dataBind(name: name)
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }

    func bind(with viewModel: FirstViewModel) {
        viewModel.count
            .subscribe(on: self) { [weak self] text in
                self?.countLabel.text = text
            }
    }
}
