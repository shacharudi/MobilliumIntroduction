//
//  IntroductionController.swift
//  MobilliumIntroduction
//
//  Created by Ahmet İmirze on 12.04.2022.
//

import UIKit

// MARK: - IntroductionControllerDelegate
public protocol IntroductionControllerDelegate: AnyObject {
    func introductionController(_ controller: IntroductionController, willDisplay index: Int)
    func introductionController(_ controller: IntroductionController, didEndDisplaying index: Int)
    func didSkipButtonTapped(_ controller: IntroductionController)
    func didNextButtonTappedAtEndOfContents(_ controller: IntroductionController)
}

public extension IntroductionControllerDelegate {
    func introductionController(_ controller: IntroductionController, willDisplay index: Int) { }
    func introductionController(_ controller: IntroductionController, didEndDisplaying index: Int) { }
    func didSkipButtonTapped(_ controller: IntroductionController) { }
    func didNextButtonTappedAtEndOfContents(_ controller: IntroductionController) { }
}

// MARK: - IntroductionController
public class IntroductionController: UIViewController {
    
    public weak var delegate: IntroductionControllerDelegate?
    
    private class AutoSizeButton: UIButton {
        
        let padding = CGSize(width: 32, height: 16)
        
        override var intrinsicContentSize: CGSize {
            let size = super.intrinsicContentSize
            return CGSize(width: size.width + padding.width, height: size.height + padding.height)
        }
    }
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    private let skipButton: AutoSizeButton = {
        let button = AutoSizeButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(IntroductionCell.self, forCellWithReuseIdentifier: "IntroductionCell")
        collectionView.isPagingEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let config: IntroductionConfig
    
    public init(config: IntroductionConfig = IntroductionConfig()) {
        self.config = config
        super.init(nibName: nil, bundle: nil)
        self.modalTransitionStyle = .coverVertical
        self.modalPresentationStyle = .fullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        configureContents()
    }
    
    @objc
    private func skipButtonTapped(_ button: UIButton) {
        self.delegate?.didSkipButtonTapped(self)
    }
    
    @objc
    private func nextButtonTapped(_ button: UIButton) {
        if pageControl.currentPage + 1 < config.contents.count {
            collectionView.scrollToItem(at: IndexPath(item: pageControl.currentPage + 1, section: 0), at: .centeredHorizontally, animated: true)
        } else {
            self.delegate?.didNextButtonTappedAtEndOfContents(self)
        }
    }
}

// MARK: - Layout
extension IntroductionController {
    
    private func addSubviews() {
        addSkipButton()
        addNextButton()
        addPageControl()
        addCollectionView()
    }
    
    private func addSkipButton() {
        skipButton.addTarget(self, action: #selector(skipButtonTapped(_:)), for: .touchUpInside)
        view.addSubview(skipButton)
        
        NSLayoutConstraint.activate([
            skipButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            skipButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            skipButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func addNextButton() {
        nextButton.addTarget(self, action: #selector(nextButtonTapped(_:)), for: .touchUpInside)
        view.addSubview(nextButton)
        
        NSLayoutConstraint.activate([
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -48),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.45),
            nextButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
    
    private func addPageControl() {
        pageControl.numberOfPages = config.contents.count
        view.addSubview(pageControl)
        
        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -24),
            pageControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: -32),
            pageControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 32)
        ])
    }
    
    private func addCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: skipButton.bottomAnchor, constant: 32),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            collectionView.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: -2)
        ])
    }
}

// MARK: - Configure
extension IntroductionController {
    
    private func configureContents() {
        configureSkipButton()
        configureNextButton()
        configurePageControl()
    }
    
    private func configureSkipButton() {
        skipButton.setTitle(config.skipButton.title, for: .normal)
        skipButton.setTitleColor(config.skipButton.titleColor, for: .normal)
        skipButton.titleLabel?.font = config.skipButton.font
        
        if let attributedTitle = config.skipButton.attributedTitle {
            skipButton.setAttributedTitle(attributedTitle, for: .normal)
        }
        
        skipButton.isHidden = config.skipButton.isHidden
        
        if let additionalStyle = config.skipButton.additionalStyle {
            skipButton.backgroundColor = additionalStyle.backgroundColor
            skipButton.layer.cornerRadius = additionalStyle.borderRadius
            skipButton.layer.borderColor = additionalStyle.borderColor.cgColor
            skipButton.layer.borderWidth = additionalStyle.borderWidth
        }
    }
    
    private func configureNextButton() {
        nextButton.setTitle(config.nextButton.title, for: .normal)
        nextButton.setTitleColor(config.nextButton.titleColor, for: .normal)
        nextButton.titleLabel?.font = config.nextButton.font
        nextButton.layer.cornerRadius = config.nextButton.cornerRadius
        nextButton.backgroundColor = config.nextButton.backgroundColor
        
        if let attributedTitle = config.nextButton.attributedTitle {
            nextButton.setAttributedTitle(attributedTitle, for: .normal)
        }
        
        nextButton.isHidden = config.nextButton.isHidden
    }
    
    private func configurePageControl() {
        pageControl.currentPageIndicatorTintColor = config.pageControl.currentPageIndicatorTintColor
        pageControl.pageIndicatorTintColor = config.pageControl.pageIndicatorTintColor
        pageControl.isHidden = config.pageControl.isHidden
    }
}

// MARK: - UICollectionViewDataSource
extension IntroductionController: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return config.contents.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IntroductionCell", for: indexPath) as! IntroductionCell
        cell.configure(with: config.contents[indexPath.item])
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        delegate?.introductionController(self, willDisplay: indexPath.item)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        delegate?.introductionController(self, didEndDisplaying: indexPath.item)
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
extension IntroductionController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

// MARK: - UIScrollViewDelegate
extension IntroductionController: UIScrollViewDelegate {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = Int(round(scrollView.contentOffset.x/view.frame.width))
        pageControl.currentPage = pageIndex
        if pageIndex == config.contents.count - 1 {
            if config.skipButton.isSkipButtonHiddenWhenLastContentShown {
                skipButton.isHidden = true
            }
            if let lastAttributedTitle = config.nextButton.lastAttributedTitle {
                nextButton.setAttributedTitle(lastAttributedTitle, for: .normal)
            } else {
                nextButton.setTitle(config.nextButton.lastTitle, for: .normal)
            }
        } else {
            if config.skipButton.isSkipButtonHiddenWhenLastContentShown {
                skipButton.isHidden = false
            }
            if let attributedTitle = config.nextButton.attributedTitle {
                nextButton.setAttributedTitle(attributedTitle, for: .normal)
            } else {
                nextButton.setTitle(config.nextButton.title, for: .normal)
            }
        }
    }
}
