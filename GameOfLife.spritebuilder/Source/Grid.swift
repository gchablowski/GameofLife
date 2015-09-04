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
        
        totalAlive = Int(arc4random_uniform(3000))
        
        sizeX = Int(contentSizeInPoints.width)
        sizeY = Int(contentSizeInPoints.height)
        
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
        
            gridDictionary["\(randX)-\(randY)"] = cell
            //save the 8 other cell for the futur generation
           for j in 0..<8 {
                var CoordX = 0
                var CoordY = 0
                var cellDisable = Cell()

                switch (j)
                {
                case 0:
                    CoordX = randX-1
                    CoordY = randY-1
                    
                case 1:
                    CoordX = randX
                    CoordY = randY-1
                    
                case 2:
                    CoordX = randX+1
                    CoordY = randY-1
                    
                case 3:
                    CoordX = randX-1
                    CoordY = randY
                    
                case 4:
                    CoordX = randX+1
                    CoordY = randY
                    
                case 5:
                    CoordX = randX
                    CoordY = randY+1
                    
                case 6:
                    CoordX = randX-1
                    CoordY = randY+1
                    
                default:
                    CoordX = randX+1
                    CoordY = randY+1

                }

                
                cellDisable.x = CGFloat(CoordX)
                cellDisable.y = CGFloat(CoordY)
                cellDisable.visible = false
                
                gridDictionary["\(CoordX)-\(CoordY)"] = cellDisable
            }
            
        }
    }
}

