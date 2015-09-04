//
//  Cell.swift
//  GameOfLife
//
//  Created by gérald chablowski on 04/09/2015.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

class Cell: CCSprite {
    var x: CGFloat = 0
    var y: CGFloat = 0
    
    convenience override init() {
        self.init(imageNamed: "Assets/cell.png")
        anchorPoint = CGPoint(x: 0, y: 0)
    }

}
