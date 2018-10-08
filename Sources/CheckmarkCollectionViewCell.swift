//
//  CheckmarkCollectionViewCell.swift
//  Cell with checkbox when it isSelected, empty circle when not.
//
//  Created by Yonat Sharon on 08.10.2018.
//  Copyright © 2018 Yonat Sharon. All rights reserved.
//

import MiniLayout
import UIKit

@IBDesignable open class CheckmarkCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties

    @IBInspectable open var selectedImage: UIImage? = UIImage(podAssetName: "checked") { didSet { updateCheckmarkImage() } }
    @IBInspectable open var deselectedImage: UIImage? = UIImage(podAssetName: "unchecked") { didSet { updateCheckmarkImage() } }

    @IBInspectable open var checkmarkSize: CGFloat = 24 {
        didSet {
            checkmarkView.constrain(.width, to: checkmarkSize)
            checkmarkView.constrain(.height, to: checkmarkSize)
        }
    }

    @IBInspectable open var checkmarkMargin: CGFloat = 8 {
        didSet {
            for attribute in checkmarkLocation {
                contentView.constrain(checkmarkView, at: attribute, diff: attribute.inwardSign * checkmarkMargin)
            }
        }
    }

    open var checkmarkLocation: Set<NSLayoutConstraint.Attribute> = [.bottom, .right] {
        didSet {
            checkmarkMargin = { checkmarkMargin }()
        }
    }

    // MARK: - Subviews

    public let checkmarkView: UIImageView = {
        let checkmarkView = UIImageView()
        checkmarkView.contentMode = .scaleAspectFit
        checkmarkView.layoutMargins = .zero
        checkmarkView.translatesAutoresizingMaskIntoConstraints = false
        return checkmarkView
    }()

    // MARK: - Overrides

    open override var isSelected: Bool {
        didSet {
            let animation = CATransition()
            animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            animation.duration = 0.1
            checkmarkView.layer.add(animation, forKey: CATransitionType.fade.rawValue)

            updateCheckmarkImage()
        }
    }

    open override func layoutSubviews() {
        super.layoutSubviews()
        if contentView != checkmarkView.superview {
            setup()
        } else if checkmarkView != contentView.subviews.last {
            contentView.bringSubviewToFront(checkmarkView)
        }
    }

    // MARK: - Privates

    private func updateCheckmarkImage() {
        checkmarkView.image = (isSelected ? selectedImage : deselectedImage)?.withRenderingMode(.alwaysTemplate)
    }

    private func setup() {
        contentView.addSubview(checkmarkView)
        updateCheckmarkImage()
        checkmarkSize = { checkmarkSize }()
        checkmarkMargin = { checkmarkMargin }()
    }
}

extension NSLayoutConstraint.Attribute {
    var inwardSign: CGFloat {
        switch self {
        case .top, .topMargin: return 1
        case .bottom, .bottomMargin: return -1
        case .left, .leading, .leftMargin, .leadingMargin: return 1
        case .right, .trailing, .rightMargin, .trailingMargin: return -1
        default: return 1
        }
    }
}

extension UIImage {
    convenience init?(podAssetName: String) {
        let podBundle = Bundle(for: CheckmarkCollectionViewCell.self)
        guard let url = podBundle.url(forResource: "CheckmarkCollectionViewCell", withExtension: "bundle") else { return nil }
        self.init(named: podAssetName, in: Bundle(url: url), compatibleWith: nil)
    }
}
