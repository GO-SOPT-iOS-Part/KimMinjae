//
//  MainHomeViewController.swift
//  SOPTving
//
//  Created by 김민재 on 2023/04/30.
//

import UIKit

final class MainHomeViewController: BaseViewController {

    // MARK: - Properties

    private var currentPageIndex = 0 {
        didSet {
            setFirstVCinPageViewController(currIndex: oldValue, targetIndex: currentPageIndex)
        }
    }

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

    private lazy var controllers: [UIViewController] = TopTabBarView.TopTab.allCases.map({ $0.viewController })

    // MARK: - View Life Cycle

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        setLayout()
        setPageViewController()
    }

    // MARK: - UI & Layout

    override func setLayout() {

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
        topTabBarView.setIndicatorBar(to: targetIndex)
    }

    private func setStickyViewIsHidden(flag: Bool) {
        topTabBarView.isHidden = !flag
        stickyTabBarView.isHidden = flag
        backgroundView.isHidden = flag
    }
}

extension MainHomeViewController: TopTabBarViewProtocol {
    func moveToTargetViewController(index: Int) {
        self.currentPageIndex = index
    }
}

extension MainHomeViewController: NavigationBarViewProtcol {
    func moveToMain() {
        setFirstVCinPageViewController(currIndex: currentPageIndex, targetIndex: 0)
    }

    func moveToMyPage() {
        let viewController = ModuleFactory.shared.makeMyPageViewController()
        self.navigationController?.pushViewController(viewController, animated: false)
    }
}

extension MainHomeViewController: HomeViewControllerProtocol {

    func updateScrollViewOffset(y: CGFloat) {
        navigationBarView.transform = CGAffineTransform(translationX: 0, y: -y)
        topTabBarView.transform = CGAffineTransform(translationX: 0, y: -y)

        if y >= navigationBarView.frame.minY {
            navigationBarView.isHidden = true
        } else {
            navigationBarView.isHidden = false
        }

        if y >= topTabBarView.frame.minY {
            setStickyViewIsHidden(flag: false)
            backgroundView.alpha = (y / 498)
        } else {
            setStickyViewIsHidden(flag: true)
            backgroundView.alpha = 1 - (y / 498) // smaller
        }
    }
}

extension MainHomeViewController: UIPageViewControllerDelegate {

    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        guard let targetVC = pendingViewControllers.first,
              let targetIndex = controllers.firstIndex(of: targetVC)
        else { return }
        topTabBarView.setIndicatorBar(to: targetIndex)
    }


    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let currentVC = pageViewController.viewControllers?.first,
              let currentPageIndex = controllers.firstIndex(of: currentVC)
        else { return }

        if !topTabBarView.checkIsBarAndPageInSameIndex(for: currentPageIndex) {
            topTabBarView.setIndicatorBar(to: currentPageIndex)
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
