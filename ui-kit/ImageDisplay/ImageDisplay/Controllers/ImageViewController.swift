//
//  ImageViewController.swift
//  ImageDisplay
//
//  Created by Lukasz Fabia on 18/06/2025.
//

import UIKit

private let filename = "Image"

class ImageViewController: UIViewController {
    
    // MARK: setup components
    
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.bounces = true
        
        sv.alwaysBounceHorizontal = true
        sv.alwaysBounceVertical = true
        
        sv.minimumZoomScale = 0.1
        sv.maximumZoomScale = 5
        return sv
    }()
    
    private let imageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: filename))
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    // MARK: overriden funcs
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDelegates()
        
        setupView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        findImageCenter()
    }
    
    // MARK: setup view, delegates
    
    private func setupDelegates() {
        scrollView.delegate = self
    }
    
    private func setupView() {
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        
        scrollView.contentSize = imageView.bounds.size
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
    
    private func findImageCenter() {
        let scaledImageSize = getScaledImageSize()
        
        let scrollViewSize = scrollView.bounds.size
        
        let insets = computeInsets(for: scrollViewSize, scaledImageSize: scaledImageSize)
        
        let offsetX = computeScrollOffset(forDimension: scaledImageSize.width, in: scrollViewSize.width, inset: insets.left)
        let offsetY = computeScrollOffset(forDimension: scaledImageSize.height, in: scrollViewSize.height, inset: insets.top)
        
        let contentOffset = CGPoint(x: offsetX, y: offsetY)
        
        UIView.animate(withDuration: 0.1) {
            self.scrollView.contentInset = insets
            self.scrollView.contentOffset = contentOffset
        }
        
        scrollView.alwaysBounceHorizontal = scaledImageSize.width > scrollViewSize.width
    }
    
    // MARK: help functions
    
    private func getScaledImageSize() -> CGSize {
        let originalSize = imageView.bounds.size
        let scale = scrollView.zoomScale
        return .init(width: originalSize.width * scale, height: originalSize.height * scale)
    }
    
    private func computeInsets(for scrollViewSize: CGSize, scaledImageSize: CGSize) -> UIEdgeInsets {
        let horizontal = max((scrollViewSize.width - scaledImageSize.width) / 2, 0)
        let vertical = max((scrollViewSize.height - scaledImageSize.height) / 2, 0)
        return .init(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }
    
    /// Computes offset in dimension x or y
    /// Params:
    ///  - `scaled`: width or height of the scaled image
    ///  - `scrollViewDim`: width or height of the scroll view (must be in same dim like `scaled`)
    ///  - `inset`: used when image is smaller then scroll view we will move it to the center (adding margins)
    ///  Returns: offset in given dim
    private func computeScrollOffset(forDimension scaled: CGFloat, in scrollViewDim: CGFloat, inset: CGFloat) -> CGFloat {
        return scaled > scrollViewDim ? (scaled - scrollViewDim) / 2 : -inset
    }
}

/// Impl o scroll view delegate
extension ImageViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    /// image always stay centered when i zoom in and out
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        print("i am centering image")
        findImageCenter()
    }
}
