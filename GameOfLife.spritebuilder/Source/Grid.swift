//
//  Grid.swift
//  GameOfLife
//
//  Created by gérald chablowski on 04/09/2015.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

class Grid: CCSprite {
    var gridDictionary = [String: Cell]()
    
    var sizeX:Int = 0
    var sizeY:Int = 0
   
    var totalAlive = 0
    var generation = 0
    
    
    
    override func onEnter() {
        super.onEnter()
        
        setupGrid()
        
        userInteractionEnabled = true
    }
    
    func setupGrid() {
        
        //create a number of cell randomly
        totalAlive = Int(arc4random_uniform(3000))
        
        //get the size of the grid
        sizeX = Int(contentSizeInPoints.width)
        sizeY = Int(contentSizeInPoints.height)
        
        //create the cell
        for i in 0..<totalAlive {
            var randX = Int(arc4random_uniform(UInt32(sizeX)))
            var randY = Int(arc4random_uniform(UInt32(sizeY)))
            var cell = Cell()
            cell.x = CGFloat(randX)
            cell.y = CGFloat(randY)
            cell.position = CGPoint(x: cell.x, y: cell.y)
            cell.visible = true
            
            //add cell to the view
            addChild(cell)
            //add cell to our dictionary with a hash as key
            gridDictionary["\(randX)-\(randY)"] = cell
            
        }
    }
}

