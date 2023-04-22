//
//  AuthTextField.swift
//  SOPTving
//
//  Created by 김민재 on 2023/04/14.
//

import UIKit

final class AuthTextField: UITextField {

    // MARK: - Properties

    @frozen
    enum AuthTextFieldType {
        case email
        case password

        var isSecure: Bool {
            switch self {
            case .email:
                return false
            case .password:
                return true
            }
        }

        var placeholder: String {
            switch self {
            case .email:
                return "이메일"
            case .password:
                return "비밀번호"
            }
        }
    }

    @frozen
    private enum AuthTextFieldState {
        case normal
        case editing

        var borderColor: CGColor? {
            switch self {
            case .normal:
                return .none
            case .editing:
                return UIColor.tvingGray2.cgColor
            }
        }
    }

    private var textFieldState: AuthTextFieldState = .normal {
        didSet {
            updateBorderColor()
        }
    }

    private var textFieldType : AuthTextFieldType

    var completion: ((String) -> Void)?

    // MARK: - UI Components

    private lazy var clearButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "xmark.circle.fill")

        let button = UIButton(configuration: config)
        let action = UIAction { _ in
            self.text?.removeAll()
            self.clearButton.alpha = 0
            self.clearButton.isUserInteractionEnabled = false
        }
        button.addAction(action, for: .touchUpInside)
        button.tintColor = .tvingGray2
        return button
    }()

    private lazy var eyeButton: UIButton = {
        var config = UIButton.Configuration.plain()
        let button = UIButton(configuration: config)

        let action = UIAction { _ in
            self.eyeButton.isSelected.toggle()
            self.isSecureTextEntry.toggle()
        }
        button.tintColor = .tvingGray2
        button.automaticallyUpdatesConfiguration = false
        button.addAction(action, for: .touchUpInside)

        return button
    }()

    private lazy var rightStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            clearButton,
            eyeButton
        ])
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 15
        stackView.layoutMargins = UIEdgeInsets(
            top: 0,
            left: 8,
            bottom: 0,
            right: 16
        )
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()

    // MARK: - initializer

    init(type: AuthTextFieldType) {
        self.textFieldType = type
        super.init(frame: .zero)
        config()
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI & Layout

private extension AuthTextField {

    func config() {
        style()
        delegate = self
        self.autocapitalizationType = .none
        isSecureTextEntry = textFieldType.isSecure
        self.placeholder = textFieldType.placeholder
        setPlaceholderColor(.tvingGray2)
        setButtonHandler()
        makeRounded(cornerRadius: 5)
        setLeftPadding(amount: 23)
        setRightView()
    }

    func setRightView() {
        clearButtonMode = .never
        rightViewMode = .whileEditing
        rightView = rightStackView

        switch textFieldType {
        case .email:
            rightView = clearButton
            hideClearButton()
        case .password:
            rightView = rightStackView
            hideClearButton()
        }
    }

    func style() {
        backgroundColor = .tvingGray4
        font = .font(.pretendardMedium, ofSize: 15)
        textColor = .tvingWhite
    }


    func setLayout() {
        rightView?.snp.makeConstraints { make in
            make.width.lessThanOrEqualTo(90)
        }
    }

    func setButtonHandler() {
        eyeButton.configurationUpdateHandler = { button in
            var config = button.configuration
            config?.image = button.isSelected
            ? UIImage(systemName: "eye.fill")
            : UIImage(systemName: "eye.slash.fill")
            button.configuration = config
        }
    }
}

// MARK: - Methods

private extension AuthTextField {

    func updateBorderColor() {
        if let borderColor = textFieldState.borderColor {
            self.layer.borderColor = borderColor
            self.layer.borderWidth = 1
        } else {
            self.layer.borderWidth = 0
        }
    }

    func hideClearButton() {
        clearButton.alpha = 0
        clearButton.isUserInteractionEnabled = false
    }

    func showClearButton() {
        clearButton.alpha = 1
        clearButton.isUserInteractionEnabled = true
    }
}

// MARK: - Delegate

extension AuthTextField: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        textFieldState = .editing
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        textFieldState = .normal
    }

    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = self.text else { return }
        completion?(text)
        if text.isEmpty {
            hideClearButton()
        } else {
            showClearButton()
        }
    }
}
