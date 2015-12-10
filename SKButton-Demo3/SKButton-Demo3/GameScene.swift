//
//  GameScene.swift
//  SKButton-Demo3
//
//  Created by Brandon Groff on 12/10/15.
//  Copyright (c) 2015 Brandon Groff. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKButtonDelegate {
    
    var buttonOne: SKButton!
    var buttonTwo: SKButton!
    
    var buttonTapCount:Int = 0
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        //create some buttons
        self.buttonOne = SKButton(color: UIColor.greenColor())
        self.buttonTwo = SKButton(defaultButtonImage: "Button",
            clickedImageName: "Button_click",
            withText: "Text")
        
        //let's position them
        self.buttonOne.position = SKButtonPosition.CenterLeft(self.buttonOne)
        self.buttonTwo.position = SKButtonPosition.CenterRight(self.buttonTwo)
        
        //let's get real fancy, add a tint and a shrink effect
        self.buttonOne.tintColor = UIColor.whiteColor()
        self.buttonTwo.shrinkOnTap = true
        
        //set up those delegates!
        self.buttonOne.delegate = self
        self.buttonTwo.delegate = self
        
        self.addChild(self.buttonOne)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        //Some special effects
        if (self.buttonTapCount == 5){
            self.buttonOne.hide()
            self.buttonTwo!.showIn(self)
            
            self.buttonTapCount++
            // ^so we don't keep running these effects
        }
    }
    
    // This is an optional function
    func skButtonTouchBegan(sender: SKButton) {
        print("Started touching button \(sender.name)")
    }
    
    //IMPORTANT: This is required by the SKButtonDelegate and to recieve button touches
    func skButtonTouchEnded(sender: SKButton) {
        if (sender == self.buttonOne){ //direct comparison works!
            self.buttonTapCount++
        }
    }
}
