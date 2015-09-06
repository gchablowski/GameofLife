//
//  Grid.swift
//  GameOfLife
//
//  Created by gérald chablowski on 04/09/2015.
//  Copyright (c) 2015 Apportable. All rights reserved.
//
import Foundation

class Grid: CCSprite {
    var gridDictionary = [String: Cell]()
    
    var sizeX:Int = 0
    var sizeY:Int = 0
    
    var totalAlive:Int = 0
    var generation:Int = 0
    
    override func onEnter() {
        super.onEnter()
        
        setupGrid()
        
        //userInteractionEnabled = true
    }
    
    func setupGrid() {
        //get the size of the grid
        sizeX = Int(contentSizeInPoints.width)
        sizeY = Int(contentSizeInPoints.height)
        
        //create a number of cell randomly
        totalAlive = Int(arc4random_uniform(10000))
        generation = 0
        
        if gridDictionary.count > 0{
            removeAllChildren()
            gridDictionary.removeAll()
        }
        
        //create the cell
        for i in 0..<totalAlive {
            
            var randX = Float(arc4random_uniform(UInt32(sizeX/2))+arc4random_uniform(UInt32(sizeX/2)))
            var randY = Float(arc4random_uniform(UInt32(sizeY/2))+arc4random_uniform(UInt32(sizeY/2)))
            
            var cell = createNewCell(randX, y: randY)
            //add cell to the view
            addChild(cell)
            
            //add cell to our dictionary with a hash as key
            gridDictionary["\(randX)-\(randY)"] = cell
        }
        
        totalAlive = gridDictionary.count
    }
    
    func evolveStep() {
        removeAllChildren()
        var gridNewDictionary = [String: Cell]()
        //treat the celle alive
        for (key, cell)in gridDictionary {
            var neightborsCount = countNeightbors(Float(cell.x), y:Float(cell.y))
            if neightborsCount != 0 {
                if neightborsCount == 2 || neightborsCount == 3 {
                    //add cell to the view
                    addChild(cell)
                    //add cell to our dictionary with a hash as key
                    gridNewDictionary["\(cell.x)-\(cell.y)"] = cell
                }
                
                //test neightbours
                for j in 0..<8{
                    var keyNeightBour = keyNeightbors(j, x: Float(cell.x), y: Float(cell.y))
                    
                    if nil == gridDictionary[keyNeightBour.keyname] {
                        neightborsCount = countNeightbors(keyNeightBour.CoordX, y:keyNeightBour.CoordY)
                        
                        if neightborsCount  == 3 {
                            var cellNew = createNewCell(keyNeightBour.CoordX, y: keyNeightBour.CoordY)
                            //add cell to the view
                            addChild(cellNew)
                            
                            //add cell to our dictionary with a hash as key
                            gridNewDictionary[keyNeightBour.keyname] = cellNew
                        }
                    }
                }
            }
        }
        
        gridDictionary.removeAll()
        gridDictionary = gridNewDictionary
        
        //update for the label
        totalAlive = gridDictionary.count
        generation++
    }
    
    func createNewCell(x: Float, y: Float) -> Cell {
        var cell = Cell()
        cell.x = CGFloat(x)
        cell.y = CGFloat(y)
        cell.position = CGPoint(x: cell.x, y: cell.y)
        cell.visible = true
        
        return cell
    }
    
    func countNeightbors(x: Float, y: Float) -> Int {
        var neightborsCount:Int = 0
        
        neightborsCount = Int(nil != gridDictionary[keyNeightbors(0, x: x, y: y).keyname])
        neightborsCount += Int(nil != gridDictionary[keyNeightbors(1, x: x, y: y).keyname])
        neightborsCount += Int(nil != gridDictionary[keyNeightbors(2, x: x, y: y).keyname])
        neightborsCount += Int(nil != gridDictionary[keyNeightbors(3, x: x, y: y).keyname])
        neightborsCount += Int(nil != gridDictionary[keyNeightbors(4, x: x, y: y).keyname])
        neightborsCount += Int(nil != gridDictionary[keyNeightbors(5, x: x, y: y).keyname])
        neightborsCount += Int(nil != gridDictionary[keyNeightbors(6, x: x, y: y).keyname])
        neightborsCount += Int(nil != gridDictionary[keyNeightbors(7, x: x, y: y).keyname])
        
        return neightborsCount
    }
    
    func keyNeightbors(NumberNeightbour: Int, x: Float, y: Float) -> (CoordX:Float, CoordY:Float, keyname:String) {
        var keyname:String
        var CoordX:Float
        var CoordY:Float
        //get the name of the neighbour
        switch (NumberNeightbour)
        {
        case 0:
            keyname = "\(x-1)-\(y-1)"
            CoordX=x-1
            CoordY=y-1
        case 1:
            keyname = "\(x)-\(y-1)"
            CoordX=x
            CoordY=y-1
        case 2:
            keyname = "\(x+1)-\(y-1)"
            CoordX=x+1
            CoordY=y-1
        case 3:
            keyname = "\(x-1)-\(y)"
            CoordX=x-1
            CoordY=y
        case 4:
            keyname = "\(x+1)-\(y)"
            CoordX=x+1
            CoordY=y
        case 5:
            keyname = "\(x)-\(y+1)"
            CoordX=x
            CoordY=y+1
        case 6:
            keyname = "\(x-1)-\(y+1)"
            CoordX=x-1
            CoordY=y+1
        default:
            keyname = "\(x+1)-\(y+1)"
            CoordX=x+1
            CoordY=y+1
        }
        //If the coodinate are negative
        if CoordX < 0 || CoordY < 0 {
            CoordX = Float(sizeX) - CoordX
            CoordY = Float(sizeY) - CoordY
            keyname = "\(CoordX)-\(CoordY)"
        }
        return (CoordX:CoordX, CoordY:CoordY, keyname:keyname)
    }
    
}

