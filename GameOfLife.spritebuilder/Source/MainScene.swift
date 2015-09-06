//
//  MainScene.swift
//  GameOfLife
//
//  Created by gérald chablowski on 04/09/2015.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

class MainScene: CCNode {
    
    weak var grid: Grid!
    weak var generationLabel: CCLabelTTF!
    weak var populationLabel: CCLabelTTF!
    
    var timer = CCTimer()
    
    override func onEnter() {
        super.onEnter()
        
        populationLabel.string = "\(grid.totalAlive)"
    }
    
    func play() {
        schedule("step", interval: CCTime(0.5))
    }
    
    func stop() {
        unschedule("step")
        grid.setupGrid()
        
        generationLabel.string = "\(grid.generation)"
        populationLabel.string = "\(grid.totalAlive)"
    }
    
    func step() {
        
            grid.evolveStep()
        
        
        generationLabel.string = "\(grid.generation)"
        populationLabel.string = "\(grid.totalAlive)"
    }
    
}
