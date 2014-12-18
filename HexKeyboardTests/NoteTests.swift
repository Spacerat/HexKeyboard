//
//  NoteTests.swift
//  HexKeyboard
//
//  Created by Joseph Atkins-Turkish on 13/12/2014.
//  Copyright (c) 2014 Joseph Atkins-Turkish. All rights reserved.
//

import UIKit
import XCTest


class NoteTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testIndexZeroIsC() {
        let note = Note(index: 0)
        XCTAssertEqual(note.name, "C", "Note 0 should be C")
    }
    
    func testSemitoneIntervals() {
        let n0 = Note(hexRow: 0, column: -2)
        let n1 = Note(hexRow: 0, column: 0)
        let n2 = Note(hexRow: 0, column: 2)
        XCTAssert(n1.index == n2.index-1, "Columns separated by a distance of two should be semitones apart")
        XCTAssert(n0.index == n1.index-1, "Semitone interval to column should work")
    }

    func testEquality() {
        XCTAssert((Note(index: 0) == Note(index: 0)), "Notes with equal indexes should compare equal")
    }
    
    func testComparison() {
        XCTAssert(Note(index: 10) > Note(index:4), "Higher notes should compare larger")
        XCTAssert(Note(index: 4) < Note(index:10), "Lower notes should compare smaller")
    }
    
    func testNoteIntervalArithmetic() {
        XCTAssert((Note(index: 3) + Interval(semitones: 6)).index == 9, "Should be able to add intervals")
        XCTAssert((Note(index: 9) - Interval(semitones: 6)).index == 3, "Should be able to subtract intervals")
    }
    
}
