//
//  AppDelegate.swift
//  CheckmarkCollectionViewCellDemo
//
//  Created by Yonat Sharon on 08.10.2018.
//  Copyright © 2018 Yonat Sharon. All rights reserved.
//

import CheckmarkCollectionViewCell
import UIKit

class CheckmarkCollectionViewController: UICollectionViewController {
    let cellColors = (0 ..< 42).map { _ in UIColor.randomColor(brightness: 1) } // swiftlint:disable:this numbers_smell

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.allowsMultipleSelection = true
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellColors.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CheckmarkCollectionViewCell", for: indexPath)
        cell.contentView.backgroundColor = cellColors[indexPath.item]
        return cell
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        CheckmarkCollectionViewCell.appearance().checkmarkLocation = [NSLayoutConstraint.Attribute.top, NSLayoutConstraint.Attribute.left]
        return true
    }
}

extension UIColor {
    public class func randomColor(hue: CGFloat? = nil, saturation: CGFloat? = nil, brightness: CGFloat? = nil) -> UIColor {
        let hue = hue ?? CGFloat(arc4random() % 256) / 256 //  0.0 to 1.0
        let saturation = saturation ?? CGFloat(arc4random() % 128) / 256 + 0.5 //  0.5 to 1.0, away from white
        let brightness = brightness ?? CGFloat(arc4random() % 128) / 256 + 0.5 //  0.5 to 1.0, away from black
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
    }
}
