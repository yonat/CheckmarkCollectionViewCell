//
//  CheckmarkCollectionViewCellDemoUITests.swift
//  CheckmarkCollectionViewCellDemoUITests
//
//  Created by Yonat Sharon on 05.02.2019.
//  Copyright © 2019 Yonat Sharon. All rights reserved.
//

import XCTest

// swiftlint:disable force_cast
class CheckmarkCollectionViewCellDemoUITests: XCTestCase {
    override func setUp() {
        super.setUp()
        XCUIApplication().launch()
    }

    func testCellReuse() {
        let app = XCUIApplication()
        let collectionView = app.collectionViews.element(boundBy: 0)
        let firstCell = collectionView.cells.firstMatch
        let firstCheckmark = firstCell.images["checkmark"]
        XCTAssert(firstCheckmark.exists)

        XCTAssertEqual(firstCheckmark.value as! String, "unchecked")
        firstCell.tap()
        sleep(1)
        XCTAssertEqual(firstCheckmark.value as! String, "checked")

        collectionView.swipeUp()
        sleep(1)
        collectionView.swipeDown()
        sleep(1)

        XCTAssertEqual(firstCheckmark.value as! String, "checked")
        firstCell.tap()
        sleep(1)
        XCTAssertEqual(firstCheckmark.value as! String, "unchecked")
    }
}

// swiftlint:enable force_cast
