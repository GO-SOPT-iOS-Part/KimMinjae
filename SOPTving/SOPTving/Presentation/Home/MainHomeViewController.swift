//
//  MainHomeViewController.swift
//  SOPTving
//
//  Created by 김민재 on 2023/04/30.
//

import UIKit

final class MainHomeViewController: UIViewController {

    // MARK: - Properties

    private let viewModel: MainHomeViewModel

    private var currentPageIndex = 0 {
        didSet {
            setFirstVCinPageViewController(currIndex: oldValue, targetIndex: currentPageIndex)
        }
    }

    private var isScrollEnabled = true

    // MARK: - UI Components

    private lazy var navigationBarView = NavigationBarView(self, type: .tvingMain)

    private let topTabBarView = TopTabBarView()

    private let backgroundView = UIView().then {
        $0.backgroundColor = .tvingBlack
        $0.isHidden = true
    }

    private lazy var stickyTabBarView = TopTabBarView().then {
        $0.isHidden = true
        $0.backgroundColor = .clear
    }

    private lazy var pageViewController = UIPageViewController(
        transitionStyle: .scroll,
        navigationOrientation: .horizontal)

    private lazy var controllers: [UIViewController] = TopTab.allCases.map({ $0.viewController })

    // MARK: - View Life Cycle

    init(viewModel: MainHomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        setLayout()
        setPageViewController()
    }

    // MARK: - UI & Layout

    private func setLayout() {

        view.addSubviews(
            pageViewController.view,
            navigationBarView,
            topTabBarView,
            backgroundView,
            stickyTabBarView
        )

        backgroundView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(stickyTabBarView.snp.bottom)
        }

        stickyTabBarView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(ScreenUtils.getHeight(40))
        }

        pageViewController.view.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }

        navigationBarView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(ScreenUtils.getHeight(40))
        }

        topTabBarView.snp.makeConstraints { make in
            make.top.equalTo(navigationBarView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(ScreenUtils.getHeight(40))
        }
    }
}

// MARK: - Methods

extension MainHomeViewController {

    private func setPageViewController() {
        self.addChild(pageViewController)

        pageViewController.didMove(toParent: self)

        guard let firstVC = controllers.first,
              let homeVC = firstVC as? HomeViewController
        else {
            return
        }

        homeVC.delegate = self

        pageViewController.setViewControllers(
            [homeVC],
            direction: .forward,
            animated: true)
    }

    private func setDelegate() {
        navigationBarView.delegate = self
        topTabBarView.delegate = self
        stickyTabBarView.delegate = self
        pageViewController.delegate = self
        pageViewController.dataSource = self
    }

    private func setFirstVCinPageViewController(currIndex: Int, targetIndex: Int) {

        guard targetIndex >= 0 && targetIndex < controllers.count else { return }
        let direction: UIPageViewController.NavigationDirection = currIndex < targetIndex
        ? .forward
        : .reverse
        pageViewController.setViewControllers([controllers[targetIndex]], direction: direction, animated: true)
    }
}

extension MainHomeViewController: TopTabBarViewProtocol {
    func moveToTargetViewController(index: Int) {
        self.currentPageIndex = index
    }
}

extension MainHomeViewController: NavigationBarViewProtcol {
    func moveToMain() {
        topTabBarView.targetIndex = 0
        self.currentPageIndex = 0
    }
}

extension MainHomeViewController: HomeViewControllerProtocol {
    //TODO: - 스크롤 시의 애니메이션 구현하기
    func updateScrollViewOffset(y: CGFloat) {
//        guard let statusBarHeight = view.getStatusBarHeight(),
//              y >= 0
//        else { return }

        navigationBarView.transform = CGAffineTransform(translationX: 0, y: -y)
        topTabBarView.transform = CGAffineTransform(translationX: 0, y: -y)

        if y >= navigationBarView.frame.minY {
            navigationBarView.isHidden = true
        } else {
            navigationBarView.isHidden = false
        }

        if y >= topTabBarView.frame.minY {
            topTabBarView.isHidden = true
            stickyTabBarView.isHidden = false
            backgroundView.isHidden = false

            backgroundView.alpha = (y / 498) // bigger
        } else {
            topTabBarView.isHidden = false
            stickyTabBarView.isHidden = true
            backgroundView.isHidden = true

            backgroundView.alpha = 1 - (y / 498) // smaller
        }
    }
}

extension MainHomeViewController: UIPageViewControllerDelegate {

    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        guard let targetVC = pendingViewControllers.first,
              let targetIndex = controllers.firstIndex(of: targetVC)
        else { return }
        topTabBarView.targetIndex = targetIndex
    }


    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let currentVC = pageViewController.viewControllers?.first,
              let currentPageIndex = controllers.firstIndex(of: currentVC)
        else { return }

        if currentPageIndex != topTabBarView.targetIndex {
            topTabBarView.targetIndex = currentPageIndex
        }
    }
}

extension MainHomeViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = controllers.firstIndex(of: viewController) else { return nil }
        let previousIdx = index - 1
        return previousIdx < 0
        ? nil
        : controllers[previousIdx]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = controllers.firstIndex(of: viewController) else { return nil }
        let nextIdx = index + 1
        return nextIdx == controllers.count
        ? nil
        : controllers[nextIdx]
    }
}
