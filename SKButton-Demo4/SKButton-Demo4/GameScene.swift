//
//  GameScene.swift
//  SKButton-Demo4
//
//  Created by Brandon Groff on 12/10/15.
//  Copyright (c) 2015 Brandon Groff. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKButtonDelegate {
    
    var buttonOne: SKButton!
    var screenTaps: Int = 1
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        self.buttonOne = SKButton(color: UIColor.orangeColor())
        
        //Note: Because I didn't initialize my GameScene using size: Device.screenSize,
        // the default button centered in view position will not work
        
        //manually set the position
        self.buttonOne.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        // change the size of the button
        self.buttonOne.size = CGSize(width: 300, height: 100)
        
        //change all the font properties
        self.buttonOne.setFont("Avenir",
            withColor: UIColor.whiteColor(),
            withSize: 22)
        
        //let's check the font properties
        print(self.buttonOne.font)
        
        //add some text
        self.buttonOne.text = "Some text"
        
        //tintColor, coming up
        self.buttonOne.tintColor = UIColor.yellowColor()
        
        //shrink effect, yes
        self.buttonOne.shrinkOnTap = true
        
        //shift the text
        self.buttonOne.textOffset = CGPoint(x: -2, y: 10)
        
        //rotate it using radians
        self.buttonOne.zRotation = CGFloat(M_PI / 4)
        
        self.buttonOne.delegate = self
        
        self.addChild(self.buttonOne)
        
        self.addLabels()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch in touches {
            let _ = touch.locationInNode(self)
            self.screenTaps++
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        // some simple animations
        if (self.screenTaps % 4 == 2){
            self.screenTaps++
            self.buttonOne.hide()
        } else if (self.screenTaps % 4 == 0){
            self.screenTaps++
            self.buttonOne.showIn(self)
        }
    }
    
    // recieved when button is initially pressed down
    func skButtonTouchBegan(sender: SKButton) {
        print("Beginning button touch")
    }
    
    //IMPORTANT: This is required by the SKButtonDelegate and to recieve button touches
    func skButtonTouchEnded(sender: SKButton) {
        self.createExplosion()
    }
    
    // a simple explosion animation, for demos sake
    func createExplosion() {
        var deviceResolution = "@2x"
        if (self.size.height > 1000){
            deviceResolution = "@3x"
        }
        
        let randomX = CGFloat(arc4random_uniform(UInt32(self.size.width - 50.0))) + 25.0
        let randomY = CGFloat(arc4random_uniform(UInt32(self.size.height - 50.0))) + 25.0
        let randomPoint = CGPoint(x: randomX, y: randomY)
        let explosionAtlas = SKTextureAtlas(named: "Explosion")
        var motionFrames = [SKTexture]()
        let numImages = explosionAtlas.textureNames.count / 3
        for (var i = 1; i <= numImages; i++){
            let textureName = "explosion.\(i)\(deviceResolution).png"
            motionFrames.append(explosionAtlas.textureNamed(textureName))
        }
        let firstFrame = motionFrames[0]
        let explosion = SKSpriteNode(texture: firstFrame)
        explosion.position = randomPoint
        explosion.name = "explosion"
        explosion.zPosition = 10
        if (deviceResolution == "@3x"){
            explosion.setScale(1.5)
        }
        let explodeAction = SKAction.animateWithTextures(motionFrames, timePerFrame: 0.025, resize: false, restore: true)
        explosion.runAction(explodeAction) { () -> Void in
            explosion.removeFromParent()
        }
        
        self.addChild(explosion)
    }
    
    // some simple labels, for demos sake
    func addLabels() {
        let label1 = SKLabelNode(text: "Button = explosion")
        let label2 = SKLabelNode(text: "Anywhere else = button effect")
        label1.fontName = "Chalkduster"
        label2.fontName = "Chalkduster"
        label1.position = CGPoint(x: self.size.width / 2, y: 3 * self.size.height / 4)
        label2.position = CGPoint(x: self.size.width / 2, y: self.size.height / 4)
        label1.fontSize = 22
        label2.fontSize = 24
        label1.fontColor = .blackColor()
        label2.fontColor = .blackColor()
        label1.zPosition = 2
        label2.zPosition = 2
        self.addChild(label1)
        self.addChild(label2)
    }
}
