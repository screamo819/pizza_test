//
//    MainViewController.swift
//    Qrooto
//
//    Created by Andrey Shemet on 16.11.2021.
//    Copyright (c) 2021 House of Apps. All rights reserved.
//

import UIKit
import RxSwift
import SkeletonView
import Lottie

final class MainViewController: UIViewController {
    private let disposeBag = DisposeBag()
    var input: MainViewInput!
    var output: MainViewOutput!
    fileprivate var isLoading = false
    private var refreshControl = UIRefreshControl()
    private var animationView: AnimationView?
    
    enum AnimationViewFrames: CGFloat {
        case start = 0
        case stop = 120
        case end = 125
    }
    
    private var notificationView: UIView = {
        let notifyView = UIView(frame: .zero)
        notifyView.addConstraints([
            notifyView.widthAnchor.constraint(equalTo: notifyView.heightAnchor),
            notifyView.heightAnchor.constraint(equalToConstant: 40)
        ])
        return notifyView
    }()
    
    @objc func notifyViewTapped() {
        output.didTapNotifyButton.onNext(())
    }
    
    private func setupAnimationView() {
        animationView = .init(name: "notification_icon_badge")
        animationView!.frame = .init(x: 0, y: 0, width: 40, height: 40)
        animationView!.contentMode = .scaleAspectFit
        
        let notifyViewTap = UITapGestureRecognizer(target: self, action: #selector(MainViewController.notifyViewTapped))
        animationView!.isUserInteractionEnabled = true
        animationView!.addGestureRecognizer(notifyViewTap)
        
        notificationView.addSubview(animationView!)
        animationView!.addConstraints([
            animationView!.widthAnchor.constraint(equalToConstant: 40),
            animationView!.heightAnchor.constraint(equalToConstant: 40)
        ])
        animationView!.currentFrame = AnimationViewFrames.start.rawValue
        notificationView.sendSubviewToBack(animationView!)
    }
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet private var cashbackTitle: UILabel!
    @IBOutlet private var navView: UIView!
    @IBOutlet private var tableView: UITableView!
    private let wrapperHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 0))
    private let headerView: MainHeaderView = R.nib.mainHeaderView.firstView(owner: nil)!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        localizeStrings()
        setupSearchController()
        setupView()
        setupRx()
        setupAnimationView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: notificationView)
        navigationController?.navigationBar.largeTitleItems(
            trailing: [
                notificationView
            ]
        )
        output.didAppear.onNext(())
        
        (self.tabBarController as? DashboardViewController)?.showTabBar()
    }
}

// MARK: - Actions
private extension MainViewController {
    @IBAction func didTapWalletButton() {
        output.didTapWallet.onNext(())
    }
}

// MARK: - Private
private extension MainViewController {
    func localizeStrings() {
        searchController.searchBar.placeholder = R.string.localizable.mainSearchBarPlaceholder()
        headerView.localizeStrings()
    }
    
    func setupSearchController() {
        searchController.hidesBottomBarWhenPushed = false
        searchController.searchBar.tintColor = R.color.orange()
        searchController.editButtonItem.tintColor = R.color.orange()
        searchController.searchBar.returnKeyType = .done
        searchController.searchBar.autocapitalizationType = .sentences
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.automaticallyShowsCancelButton = true
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.automaticallyShowsScopeBar = true
        searchController.searchBar.delegate = self

        navigationItem.hidesSearchBarWhenScrolling = true
        navigationItem.searchController = searchController
        
        definesPresentationContext = true
        searchController.searchResultsUpdater?.updateSearchResults(for: searchController)
    }
    
    func setupView() {
        tableView.register(R.nib.mainRectangleBannerTVCell)
        tableView.register(R.nib.mainRectanglesBannerTVCell)
        tableView.register(R.nib.mainSquareBannerTVCell)
        tableView.register(R.nib.mainSquaresBannerTVCell)
        tableView.register(R.nib.mainRowBannerTVCell)
        tableView.register(R.nib.mainEmptyTVCell)
        
        tableView.rowHeight = UITableView.automaticDimension
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        wrapperHeaderView.addSubview(headerView)
        wrapperHeaderView.addConstraints([
            headerView.leadingAnchor.constraint(equalTo: wrapperHeaderView.leadingAnchor),
            headerView.topAnchor.constraint(equalTo: wrapperHeaderView.topAnchor),
            headerView.trailingAnchor.constraint(equalTo: wrapperHeaderView.trailingAnchor),
            wrapperHeaderView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        ])
        updateHeaderView()
        tableView.tableFooterView = UIView()

        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        output.didTapSearchCancel.onNext(())
        self.refreshControl.endRefreshing()
    }
    
    func setupRx() {
        input.loading
            .subscribe(
                onNext: { [weak self] (isLoading) in
                    isLoading ? self?.showActivityIndicator() : self?.hideActivityIndicator(animated: true, completion: nil)
                }
            )
            .disposed(by: disposeBag)
        
        input.header
            .subscribe(
                onNext: { [weak self] (header) in
                    guard let self = self else { return }
                    
                    if let header = header {
                        self.headerView.setup(header)
                        self.updateHeaderView()
                    }
                    self.tableView.isHidden = false//header == nil
                }
            )
            .disposed(by: disposeBag)
        
        headerView.rx.filterSelected
            .subscribe(
                onNext: { [weak self] (index) in
                    self?.output.filterItemSelected.onNext(index)
                }
            )
            .disposed(by: disposeBag)
        
        headerView.rx.categorySelected
            .subscribe(
                onNext: { [weak self] (indexPath) in
                    self?.output.categoryItemSelected.onNext(indexPath)
                }
            )
            .disposed(by: disposeBag)
        
        input.reloadSections
            .subscribe(
                onNext: { [weak self] _ in
                    self?.tableView.reloadData()
                }
            )
            .disposed(by: disposeBag)
        
        input.notificationIsEmpty
            .subscribe(
                onNext: { [weak self] emptyNotify in
                    guard let self = self else { return }
                    guard let animationView = self.animationView else { return }
                    if emptyNotify {
                        animationView.animationSpeed = 1.5
                        animationView.play(fromFrame: AnimationViewFrames.start.rawValue, toFrame: AnimationViewFrames.end.rawValue, loopMode: .loop)
                    } else {
//                        animationView.play(fromFrame: AnimationViewFrames.stop.rawValue, toFrame: AnimationViewFrames.end.rawValue, loopMode: .none)
                        animationView.stop()
                    }
                }
            )
            .disposed(by: disposeBag)
        
        input.cashback
            .subscribe(
                onNext: { [weak self] cashback in
                    self?.navigationItem.title = cashback ?? R.string.localizable.mainTitle()
                }
            )
            .disposed(by: disposeBag)
        
// MARK: - showing in-app message with random discount is disabled -
        
//        input.bannerModel
//            .subscribe(
//                onNext: { [weak self] model in
//                    guard let self = self else { return }
//                    if let model = model {
//                        guard Main.shared?.states.tutorialIsShowed ?? true else { return }
//
//                        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1.0) {
//                            let controller = self.createWindowModalViewController(withModel: model)
//                            controller.presentOn(presentingViewController: self, animated: true, onDismiss: nil)
//                        }
//                    }
//                }
//            )
//            .disposed(by: disposeBag)
    }
    
    func updateHeaderView() {
        wrapperHeaderView.isSkeletonable = true
        wrapperHeaderView.layoutIfNeeded()
        wrapperHeaderView.frame.size.height = headerView.frame.height
        tableView.tableHeaderView = wrapperHeaderView
    }
}

extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
            output.searchText.onNext(searchController.searchBar.text)
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        output.didTapSearchCancel.onNext(())
    }
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        input.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        input.sections[section].cells.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = input.sections[indexPath.section].cells[indexPath.row]
        let cell: MainBaseTVCell!
        
        switch item {
        case .rectangle(let model):
            let _cell = tableView.dequeueReusableCell(withIdentifier: R.nib.mainRectangleBannerTVCell.self, for: indexPath)!
            _cell.setup(model)
            _cell.likeAction = { self.output.didTapLikeOnDiscount.onNext((indexPath, nil)) }
            _cell.unLikeAction = { self.output.didTapUnlikeOnDiscount.onNext((indexPath, nil)) }
            _cell.didTapInfo = { self.output.didTapItemInfoButton.onNext((indexPath, nil)) }
            cell = _cell
        case .rectangles(let models):
            let _cell = tableView.dequeueReusableCell(withIdentifier: R.nib.mainRectanglesBannerTVCell.self, for: indexPath)!
            _cell.setup(models)
            _cell.itemSelected = { [weak self, weak _cell] index in
                guard let cell = _cell else { return }
                guard let tableView = self?.tableView else { return }
                guard let indexPath = tableView.indexPath(for: cell) else { return }
                
                self?.output.didTapItem.onNext((indexPath, index))
            }
            _cell.likeActionTap = { [weak self, weak _cell] index in
                guard let cell = _cell else { return }
                guard let tableView = self?.tableView else { return }
                guard let indexPath = tableView.indexPath(for: cell) else { return }
                self?.output.didTapLikeOnDiscount.onNext((indexPath, index))
            }
            _cell.unlikeActionTap = { [weak self, weak _cell] index in
                guard let cell = _cell else { return }
                guard let tableView = self?.tableView else { return }
                guard let indexPath = tableView.indexPath(for: cell) else { return }
                self?.output.didTapUnlikeOnDiscount.onNext((indexPath, index))
            }
            _cell.infoItemTap = { [weak self, weak _cell] index in
                guard let cell = _cell else { return }
                guard let tableView = self?.tableView else { return }
                guard let indexPath = tableView.indexPath(for: cell) else { return }
                self?.output.didTapItemInfoButton.onNext((indexPath, index))
            }
            cell = _cell
        case .square(let model):
            let _cell = tableView.dequeueReusableCell(withIdentifier: R.nib.mainSquareBannerTVCell.self, for: indexPath)!
            _cell.setup(model)
            _cell.likeAction = { self.output.didTapLikeOnDiscount.onNext((indexPath, nil)) }
            _cell.unLikeAction = { self.output.didTapUnlikeOnDiscount.onNext((indexPath, nil)) }
            _cell.didTapActionButton = { self.output.didTapLinkButton.onNext((indexPath, nil))}
            _cell.didTapInfo = { self.output.didTapItemInfoButton.onNext((indexPath, nil)) }
            cell = _cell
        case .squares(let models):
            let _cell = tableView.dequeueReusableCell(withIdentifier: R.nib.mainSquaresBannerTVCell.self, for: indexPath)!
            _cell.setup(models)
            _cell.itemSelected = { [weak self, weak _cell] index in
                guard let cell = _cell else { return }
                guard let tableView = self?.tableView else { return }
                guard let indexPath = tableView.indexPath(for: cell) else { return }
                
                self?.output.didTapItem.onNext((indexPath, index))
            }
            _cell.infoItemTap = { [weak self, weak _cell] index in
                guard let cell = _cell else { return }
                guard let tableView = self?.tableView else { return }
                guard let indexPath = tableView.indexPath(for: cell) else { return }
                self?.output.didTapItemInfoButton.onNext((indexPath, index))
            }
            cell = _cell
        case .row(let model):
            let _cell = tableView.dequeueReusableCell(withIdentifier: R.nib.mainRowBannerTVCell.self, for: indexPath)!
            _cell.setup(model)
            _cell.likeAction = { self.output.didTapLikeOnDiscount.onNext((indexPath, nil)) }
            _cell.unLikeAction = { self.output.didTapUnlikeOnDiscount.onNext((indexPath, nil)) }
            _cell.didTapInfo = { self.output.didTapItemInfoButton.onNext((indexPath, nil)) }
            cell = _cell
        case .empty:
            let cell = tableView.dequeueReusableCell(withIdentifier: R.nib.mainEmptyTVCell.self, for: indexPath)!
            cell.setup()
            return cell
        }
        
        if isLoading {
            cell.showAnimatedSkeleton()
        } else {
            cell.hideSkeleton()
        }
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = input.sections[indexPath.section].cells[indexPath.row]
        switch item {
        case .rectangle, .square, .row:
            output.didTapItem.onNext((indexPath, nil))
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view: UIView?
        let model = input.sections[section]
        
        let headerView = R.nib.mainSectionHeaderView.firstView(owner: nil)
        headerView?.setup(input.sections[section])
        view = headerView
        headerView?.didTapSectionHeaderButton = { self.output.didTapSectionButton.onNext((model.sectionId))
        }
        
        switch model.type {
        case .empty:
            headerView?.moreButton.isHidden = true
        case .rectangle, .rectangles, .square, .squares, .row:
            headerView?.moreButton.isHidden = input.sections[section].total < 4
        }

        if isLoading {
            view?.showAnimatedSkeleton()
        }
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        52
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        CGFloat.leastNormalMagnitude
    }
}

// MARK: - SkeletonTableViewDataSource
extension MainViewController: SkeletonTableViewDataSource {
    func numSections(in collectionSkeletonView: UITableView) -> Int {
        input.sections.count
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        input.sections[section].cells.count
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        let item = input.sections[indexPath.section].cells[indexPath.row]
        switch item {
        case .rectangle:
            return R.nib.mainRectangleBannerTVCell.identifier
        case .rectangles:
            return R.nib.mainRectanglesBannerTVCell.identifier
        case .square:
            return R.nib.mainSquareBannerTVCell.identifier
        case .squares:
            return R.nib.mainSquaresBannerTVCell.identifier
        case .row:
            return R.nib.mainRowBannerTVCell.identifier
        case .empty:
            return R.nib.mainEmptyTVCell.identifier
        }
    }
}

// MARK: - SkeletonTableViewDelegate
extension MainViewController: SkeletonTableViewDelegate { }

// MARK: - show interactive banner
extension MainViewController {
    func createWindowModalViewController(withModel model: MainInteractiveBannerModel) -> WindowModalViewController {
        let controller = WindowModalViewController()

        controller.maxWidth = 340
        controller.minHeight = 500
        
        controller.contentView.backgroundColor = model.bgColor
        controller.title = model.title
        
        controller.firstLabel.text = model.textBeforeImg
        controller.firstLabel.textColor = model.textBeforeImgColor
        
        if let url = model.image {
            controller.imageView.setImage(with: url)
        }
        
        controller.secondLabel.text = model.textAfterImg
        controller.secondLabel.textColor = model.textAfterImgColor
        
        controller.actionButton.setTitle(model.actionButtonTitle, for: .normal)
        controller.actionButton.setTitleColor(model.actionButtonTitleColor, for: .normal)
        controller.actionButton.addTarget(self, action: #selector(tappedActionButton), for: .touchUpInside)
        controller.actionButton.backgroundColor = model.actionButtonBGColor
        
        controller.closeButton.setTitle(model.cancelButtonTitle, for: .normal)
        controller.closeButton.setTitleColor(model.cancelButtonTitleColor, for: .normal)
        
        return controller
    }

    @objc func tappedActionButton() {
        output.didTapInteractiveActionButton.onNext(())
    }
}
