// ColorSet.swift

import Foundation
import SwiftUI

// consider sub ColorSet
public struct ColorSet {
    
    public static var shared = ColorSet()
    
    let cardBackground = Color(hex: 0xFCFCFC)
    let cardTitle =  Color(hex:0x093C89)
    let tabBackground = Color(hex: 0xF2F2F2)

    // MARK: - Sheet

    let previewBackground = Color(hex:0x80A3D9).opacity(0.2)
    let extraInfoButton = Color.blue
    let storyFieldBorder = Color(hex: 0xCFBCB2)
    let alertBackground = Color(hex: 0xEFEFF1, alpha: 0.95)

    // MARK: - BookTab

    let bookTabTitle = Color(hex: 0x093C89)
    let addButton = Color(hex: 0x093C89)
    let storyRibbon = Color(hex:0x245296)
    let capsule = Capsule()

    // MARK: - StoryTab

    let star = Color(hex: 0xFFDD5E)
    let emojiBackground = Color(hex: 0xF6E5C5)

    // MARK: - ReportTab

    let reportTabTitle = Color(hex: 0x4B5FCD)
    public let colors = [
        Color(hex:0x093C89),
        Color(hex:0x245296),
        Color(hex:0x426DAD),
        Color(hex:0x638ECF),
        Color(hex:0x80A3D9),
        Color(hex:0x0277B4),
        Color(hex:0x24a0e0),
        Color(hex:0x60b5e2),
        Color(hex:0xa6d5ed),
        Color(hex:0x49CAE5),
        
        Color(hex:0x91dded),
        Color(hex:0xb6e7f2),
        Color(hex:0xD6FEFF),
        Color(hex:0x0a528a),
        Color(hex:0x1e8aa8),
        Color(hex:0x3fb1d1),
        Color(hex:0x5cc8e6),
        Color(hex:0x7ddbf5),
        Color(hex:0x07502c),
        Color(hex:0x147b49),
        
        Color(hex:0x2cb572),
        Color(hex:0x69ce9d),
        Color(hex:0xa9dbc2),
        Color(hex:0xfde144),
        Color(hex:0xeff787),
        Color(hex:0xeef4af),
        Color(hex:0xf0f2d4),
        Color(hex:0x70d204),
        Color(hex:0xa5fd44),
        Color(hex:0xcbf1a2),
        
        Color(hex:0xc8e1ad)
    ]

    // MARK: - Struct

    struct Capsule {
        let tag = Color(hex: 0xCB844A)
        let unselectedTag = Color(hex:0x80A3D9).opacity(0.6)
        let focus = Color(hex:0x245296)
        let unselectedFocus = Color(hex:0x80A3D9).opacity(0.6)
        let person = Color(hex: 0x785EAF)
    }
}

let defaultColorSet = ColorSet()
