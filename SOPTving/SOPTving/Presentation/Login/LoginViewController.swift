//
//  LoginViewController.swift
//  SOPTving
//
//  Created by 김민재 on 2023/04/13.
//

import UIKit

final class LoginViewController: UIViewController {

    // MARK: - Properties
    private var viewModel: LoginViewModel

    private var email: String?

    // MARK: - UI Components

    private let loginLabel: UILabel = {
        let label = UILabel()
        label.text = "TVING ID 로그인"
        label.font = .font(.pretendardBold, ofSize: 23)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()

    private lazy var emailTextField: AuthTextField = {
        let textField = AuthTextField(type: .email)
        textField.completion = { text in
            self.email = text
            self.viewModel.emailText(email: text)
        }
        return textField
    }()
    
    private lazy var passwordTextField: AuthTextField = {
        let textField = AuthTextField(type: .password)
        textField.completion = { text in
            self.viewModel.passwordText(password: text)
        }
        return textField
    }()

    private lazy var textFieldStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            emailTextField,
            passwordTextField
        ])
        stackView.axis = .vertical
        stackView.spacing = 11
        stackView.distribution = .fillEqually
        return stackView
    }()

    private lazy var loginButton: UIButton = {
        var config = UIButton.Configuration.plain()
        var titleAttr = AttributedString("로그인하기")
        titleAttr.font = .font(.pretendardSemiBold, ofSize: 14)
        config.attributedTitle = titleAttr
        config.background.backgroundColor = .tvingBlack
        config.baseForegroundColor = .tvingGray2
        let button = UIButton(configuration: config)
        let action = UIAction { _ in
            guard let email = self.email else { return }
            let welcomeVC = WelcomeViewController()
            welcomeVC.dataBind(nameOrEmail: email)
            self.navigationController?.pushViewController(welcomeVC, animated: true)
        }
        button.addAction(action, for: .touchUpInside)
        
        button.layer.borderColor = UIColor.tvingGray4.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 3
        button.isUserInteractionEnabled = false
        return button
    }()

    private let findIdButton: UIButton = {
        var config = UIButton.Configuration.plain()
        var titleAttr = AttributedString.init("아이디 찾기")
        titleAttr.font = .font(.pretendardSemiBold, ofSize: 14)
        config.attributedTitle = titleAttr
        config.background.backgroundColor = .tvingBlack
        config.baseForegroundColor = .tvingGray2
        let button = UIButton(configuration: config)
        return button
    }()

    private let findPasswordButton: UIButton = {
        var config = UIButton.Configuration.plain()
        var titleAttr = AttributedString.init("비밀번호 찾기")
        titleAttr.font = .font(.pretendardSemiBold, ofSize: 14)
        config.attributedTitle = titleAttr
        config.background.backgroundColor = .tvingBlack
        config.baseForegroundColor = .tvingGray2
        let button = UIButton(configuration: config)
        return button
    }()

    private let grayLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .tvingGray4
        return view
    }()

    private lazy var findInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            findIdButton,
            grayLineView,
            findPasswordButton
        ])
        stackView.axis = .horizontal
        stackView.spacing = 33
        stackView.distribution = .equalSpacing
        return stackView
    }()

    private let noAccountLabel: UILabel = {
        let label = UILabel()
        label.text = "아직 계정이 없으신가요?"
        label.font = .font(.pretendardSemiBold, ofSize: 14)
        label.textColor = .tvingGray3
        return label
    }()

    private let createAccountButton: UIButton = {
        var config = UIButton.Configuration.plain()
        var titleAttr = AttributedString("닉네임 만들러가기")
        titleAttr.font = .font(.pretendardRegular, ofSize: 14)
        titleAttr.underlineStyle = .single
        titleAttr.underlineColor = .tvingGray2
        config.attributedTitle = titleAttr
        config.baseForegroundColor = .tvingGray2
        config.titleAlignment = .center
        let button = UIButton(configuration: config)
        button.titleLabel?.numberOfLines = 1
        button.setUnderline()
        return button
    }()

    private lazy var noAccountStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            noAccountLabel,
            createAccountButton
        ])
        stackView.axis = .horizontal
        stackView.spacing = 17
        return stackView
    }()

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    // MARK: - View Life Cycle

    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        setNavigationItem()
        setLayout()
        bind()
    }
}

// MARK: - UI & Layout

private extension LoginViewController {

    func style() {
        view.backgroundColor = .tvingBlack
    }

    func setNavigationItem() {
        self.navigationItem.leftBarButtonItem =
        UIBarButtonItem(
            image: ImageLiterals.Auth
                .buttonBefore
                .withRenderingMode(.alwaysOriginal),
            style: .plain,
            target: self,
            action: #selector(backTapped)
        )
    }

    func setLayout() {
        view.addSubviews(
            loginLabel,
            textFieldStackView,
            loginButton,
            findInfoStackView,
            noAccountStackView
        )

        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(52)
        }
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(52)
        }

        loginLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(60)
            make.leading.trailing.equalToSuperview().inset(40)
        }

        textFieldStackView.snp.makeConstraints { make in
            make.top.equalTo(loginLabel.snp.bottom).offset(27)
            make.leading.trailing.equalToSuperview().inset(20)
        }

        loginButton.snp.makeConstraints { make in
            make.height.equalTo(52)
            make.top.equalTo(textFieldStackView.snp.bottom).offset(21)
            make.leading.trailing.equalTo(textFieldStackView)
        }

        grayLineView.snp.makeConstraints { make in
            make.width.equalTo(1)
            make.height.equalTo(12)
        }

        findInfoStackView.snp.makeConstraints { make in
            make.centerX.equalTo(loginButton)
            make.top.equalTo(loginButton.snp.bottom).offset(31)
        }

        noAccountStackView.snp.makeConstraints { make in
            make.top.equalTo(findInfoStackView.snp.bottom).offset(31)
            make.leading.trailing.equalToSuperview().inset(49)
        }
    }
}

// MARK: - Methods

private extension LoginViewController {
    @objc
    func backTapped() {
        navigationController?.popViewController(animated: false)
    }

    func setButtonHandler() {
        loginButton.configurationUpdateHandler = { button in
            var config = button.configuration
            config?.background.backgroundColor = button.isUserInteractionEnabled
            ? .tvingRed
            : .tvingBlack
            config?.baseForegroundColor = button.isUserInteractionEnabled
            ? .tvingWhite
            : .tvingGray2
            button.configuration = config
        }
    }

    func bind() {
        self.viewModel.isLoginButtonEnableUpdated = { isEnable in
            self.loginButton.isUserInteractionEnabled = isEnable
            self.setButtonHandler()
        }
    }
}
