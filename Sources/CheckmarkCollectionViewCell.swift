//
//  CheckmarkCollectionViewCell.swift
//  Cell with checkbox when it isSelected, empty circle when not.
//
//  Created by Yonat Sharon on 08.10.2018.
//  Copyright © 2018 Yonat Sharon. All rights reserved.
//

import SweeterSwift
import UIKit

@IBDesignable open class CheckmarkCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties

    @IBInspectable open dynamic var selectedImage: UIImage? = UIImage(podAssetName: "checked") { didSet { updateCheckmarkImage() } }
    @IBInspectable open dynamic var deselectedImage: UIImage? = UIImage(podAssetName: "unchecked") { didSet { updateCheckmarkImage() } }

    @IBInspectable open dynamic var checkmarkSize: CGFloat = 24 {
        didSet {
            checkmarkView.constrain(.width, to: checkmarkSize)
        }
    }

    @IBInspectable open dynamic var checkmarkMargin: CGFloat = 8 {
        didSet {
            checkmarkConstraints.forEach {
                let sign = $0.constant / abs($0.constant)
                $0.constant = checkmarkMargin * sign
            }
        }
    }

    /// Set of `NSLayoutConstraint.Attribute` specifying how to locate the checkmark in relation to the cell
    @objc open dynamic var checkmarkLocation: NSSet = [NSLayoutConstraint.Attribute.bottom, NSLayoutConstraint.Attribute.right] {
        didSet {
            guard checkmarkView.superview == contentView else { return }
            contentView.removeConstraints(checkmarkConstraints)
            checkmarkConstraints = checkmarkLocation.compactMap { $0 as? NSLayoutConstraint.Attribute }.map { attribute in
                contentView.constrain(checkmarkView, at: attribute, diff: attribute.inwardSign * checkmarkMargin)
            }
        }
    }

    // MARK: - Subviews

    public let checkmarkView: UIImageView = {
        let checkmarkView = UIImageView()
        checkmarkView.contentMode = .scaleAspectFit
        checkmarkView.layoutMargins = .zero
        checkmarkView.translatesAutoresizingMaskIntoConstraints = false
        checkmarkView.heightAnchor.constraint(equalTo: checkmarkView.widthAnchor).isActive = true
        checkmarkView.accessibilityLabel = "checkmark"
        return checkmarkView
    }()

    var checkmarkConstraints: [NSLayoutConstraint] = []

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
        checkmarkView.accessibilityValue = isSelected ? "checked" : "unchecked"
    }

    private func setup() {
        contentView.addSubview(checkmarkView)
        updateCheckmarkImage()
        checkmarkSize = { checkmarkSize }()
        checkmarkLocation = { checkmarkLocation }()
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
