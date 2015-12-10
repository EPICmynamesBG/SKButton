//
//  GameScene.swift
//  SKButton-Demo2
//
//  Created by Brandon Groff on 12/10/15.
//  Copyright (c) 2015 Brandon Groff. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKButtonDelegate {
    
    var myButtonArray = [SKButton]()
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        //Different ways to initialize an SKButton
        self.myButtonArray.append(SKButton())
        
        self.myButtonArray.append(SKButton(
            buttonImage: "Button"))
        
        self.myButtonArray.append(SKButton(
            buttonImage: "Button",
            atPosition: CGPoint(x: 100,y: 100)))
        
        self.myButtonArray.append(SKButton(
            color: UIColor.orangeColor()))
        
        self.myButtonArray.append(SKButton(
            defaultButtonImage: "Button",
            clickedImageName: "Button_click"))
        
        self.myButtonArray.append(SKButton(
            defaultButtonImage: "Button",
            clickedImageName: "Button_click",
            atPosition: CGPoint(x: 150, y: 150)))
            
        self.myButtonArray.append(SKButton(
            defaultButtonImage: "Button",
            clickedImageName: "Button_click",
            withText: "Text!"))
        
        self.myButtonArray.append(SKButton(
            defaultButtonImage: "Button",
            clickedImageName: "Button_click",
            withText: "Text again!",
            atPosition: CGPoint(x: 200, y: 200)))
        
        self.myButtonArray.append(SKButton(
            defaultButtonImage: "Button",
            clickedImageName: "Button_click",
            withText: "Text x 2!",
            withTextOffset: CGPoint(x: 5, y: 10)))
        
        self.myButtonArray.append(SKButton(
            defaultButtonImage: "Button",
            clickedImageName: "Button_click",
            withText: "The Last One",
            withTextOffset: CGPoint(x: 2, y: 5),
            atPosition: CGPoint(x: 250, y: 250)))
        
        
        //add my buttons to the view
        for button:SKButton in self.myButtonArray {
            //add the delegate first so we can get clicks!
            button.delegate = self
            
            self.addChild(button)
        }
        
/* -- THINGS TO NOTICE AT RUNTIME --
* 1. Many buttons are stacked in the middle of the view. This is because *
* the default position is center, and we didn't move them.
* 2. On each button click, each button has a unique name.
* 3. The next is overflowing from some of our buttons. That is because our
* button is too small and our font size too large. Both of these can be changed
* though using button.size and button.fontSize. Similarly, a larger button image
* could also be provided.
*/
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    //IMPORTANT: This is required by the SKButtonDelegate and to recieve button touches
    func skButtonTouchEnded(sender: SKButton) {
        print(sender.name)
    }
}
