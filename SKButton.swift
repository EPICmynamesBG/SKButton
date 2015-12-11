/*!
SKButton.swift

Created by Brandon Groff on 12-10-2015.

Version: 1.1 - Beta

Copyright (c) 2015 Brandon Groff <mynamesbg@gmail.com>


Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:


The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.


THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

*/


import SpriteKit

/**
 An object that manages SKButton touches.
 */
@objc protocol SKButtonDelegate {
    /**
     Optional: notifies reciever when an SKButton is tapped down
     
     - parameter sender: an <i>SKButton</i>
     */
    optional func skButtonTouchBegan(sender: SKButton)
    /**
     Required: notifies reciever when an SKButton tap is released
     
     - parameter sender: an <i>SKButton</i>
     */
    func skButtonTouchEnded(sender: SKButton)
}

/**
 A simple button for SpriteKit.
 */

class SKButton: SKNode {
    
    /* ---- Private Properties ---- */
    /*!
    The visible node
    */
    private var defaultButton: SKSpriteNode
    /*!
    The hidden node that appears when SKButton object is tapped
    */
    private var onTapButton: SKSpriteNode
    /*!
    The semi-transparent node that applies the tint color
    */
    private var tintLayer: SKSpriteNode
    /*!
    The text node
    */
    private var label:SKLabelNode
    /*!
    The variable to help track when a touch is cancelled
    */
    private var touchCancelled: Bool = false
    /*!
    The variable to help determine if button shrinks on tap
    */
    private var shrinkOnTapPrivate: Bool = false
    
    /* ---- Public Properties ---- */
    
    /**
    The object that acts as a delegate for a SpriteKit Button.
    */
    var delegate: SKButtonDelegate?
    /**
     The offset of the text within the button
     */
    var textOffset: CGPoint {
        set (newOffset){
            self.label.position.x = 0 + newOffset.x
            self.label.position.y = 0 + newOffset.y
        }
        get {
            return self.label.position
        }
    }
    /**
     The text String printed in the button
     */
    var text: String {
        set (newText){
            self.label.text = newText
            if (self.label.frame.size.width > self.size.width){
                self.size.width = self.label.frame.size.width + 20
            }
        }
        get {
            return self.label.text!
        }
    }
    /**
     The tint color applied to the button
     */
    var tintColor: SKColor {
        set(newColor) {
            self.tintLayer.color = newColor
        }
        get {
            return self.tintLayer.color
        }
    }
    /**
     Font tuple of current font settings (read-only)
     */
    var font: (fontName: String?, fontColor: UIColor?, fontSize: CGFloat?) {
        get {
            return (self.fontName, self.fontColor, self.fontSize)
        }
    }
    /**
     The String name of the font used on the button text
     */
    var fontName:String {
        set (newFont){
            self.label.fontName = newFont
            if (self.label.frame.size.width > self.size.width){
                self.size.width = self.label.frame.size.width + 20
            }
        } get {
            return self.label.fontName!
        }
    }
    /**
     The CGFloat size of the text in the button
     */
    var fontSize:CGFloat {
        set (newFontSize){
            self.label.fontSize = newFontSize
            if (self.label.frame.size.width > self.size.width){
                self.size.width = self.label.frame.size.width + 20
            }
            
        } get {
            return self.label.fontSize
        }
    }
    /**
     The color of the button text
     */
    var fontColor: UIColor {
        set (newFontColor){
            self.label.fontColor = newFontColor
        } get {
            return self.label.fontColor!
        }
    }
    /**
     The size of the button in its parent
     */
    var size: CGSize {
        set (newSize){
            self.defaultButton.size = newSize
            self.onTapButton.size = newSize
            self.tintLayer.size = newSize
        }
        get {
            return self.defaultButton.size
        }
    }
    /**
     Controls whether or not the button will scale down on tap
     */
    var shrinkOnTap: Bool {
        set (newValue){
            self.shrinkOnTapPrivate = newValue
            if (self.shrinkOnTapPrivate){
                self.onTapButton.size = CGSize(width: self.defaultButton.size.width * 0.98, height: self.defaultButton.size.height * 0.98)
            } else {
                self.onTapButton.size = CGSize(width: self.defaultButton.size.width, height: self.defaultButton.size.height)
            }
        }
        get {
            return self.shrinkOnTapPrivate
        }
    }
    /**
     The color of the button
     */
    var color: UIColor {
        set (newValue){
            self.defaultButton.color = newValue
            self.onTapButton.color = newValue.darken()
            self.defaultButton.colorBlendFactor = 1.0
            self.onTapButton.colorBlendFactor = 1.0
        }
        get {
            return self.defaultButton.color
        }
    }
    
    /**
     Required so XCode doesn't throw warnings
     */
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     A complete SKButton initializer
     
     - parameter defaultButtonImage: the primary button appearance
     - parameter onTapButtonImage:   the on tap button appearance
     - parameter buttonText:         the buttons's text
     - parameter textOffset:         (x, y) offset of text within the button
     - parameter position:           (x, y) position of the button in the view
     
     - returns: an <i>SKButton</i>
     */
    init(defaultButtonImage: String, clickedImageName onTapButtonImage: String, withText buttonText: String, withTextOffset textOffset: CGPoint, atPosition position: CGPoint){
        //initialize properties
        
        if (defaultButtonImage == ""){
            self.defaultButton = SKSpriteNode()
            self.defaultButton.size = CGSize(width: 200, height: 100)
            self.defaultButton.color = SKButtonDefaults.buttonColor
            self.defaultButton.colorBlendFactor = 1
        } else {
            self.defaultButton = SKSpriteNode(imageNamed: defaultButtonImage)
            self.defaultButton.color = SKButtonDefaults.buttonColor
        }
        
        if (onTapButtonImage == "" && defaultButtonImage == ""){
            self.onTapButton = SKSpriteNode()
            self.onTapButton.size = CGSize(width: self.defaultButton.size.width, height: self.defaultButton.size.height)
            self.onTapButton.color = self.defaultButton.color.darken()
            self.onTapButton.colorBlendFactor = 1
        } else if (onTapButtonImage == ""){ //fallback for case of no second image
            let temp = SKSpriteNode(imageNamed: defaultButtonImage)
            temp.color = SKButtonDefaults.tapButtonColor
            temp.colorBlendFactor = 0.2
            self.onTapButton = temp
        } else {
            self.onTapButton = SKSpriteNode(imageNamed: onTapButtonImage)
            self.onTapButton.color = SKButtonDefaults.buttonColor
        }
        self.tintLayer = SKSpriteNode(color: SKButtonDefaults.tintColor, size: self.defaultButton.size)
        self.tintLayer.alpha = 0.25
        self.tintLayer.colorBlendFactor = SKButtonDefaults.tintColorBlend
        self.tintLayer.position = self.defaultButton.position
        self.tintLayer.zPosition = SKButtonDefaults.zPosition + 1
        
        
        self.onTapButton.hidden = true
        self.label = SKButton.createLabel(buttonText)
        
        
        super.init()
        
        self.name = "SKButton-\(SKButtonDefaults.BUTTON_ID++)"
        self.userInteractionEnabled = true
        
        addChild(self.defaultButton)
        addChild(self.onTapButton)
        addChild(self.tintLayer)
        self.label.position = CGPoint(x: self.defaultButton.position.x , y: self.defaultButton.position.y - 10)
        addChild(self.label)
        
        self.textOffset = textOffset
        self.text = buttonText
        
        self.position = position
        self.zPosition = SKButtonDefaults.zPosition
        self.zRotation = SKButtonDefaults.zRotation
        self.setScale(SKButtonDefaults.scale)
        self.hidden = SKButtonDefaults.hidden
        self.accessibilityLabel = SKButtonDefaults.accessibilityLabel
        self.alpha = SKButtonDefaults.alpha
        self.tintColor = SKButtonDefaults.tintColor
    }
    
    /**
     Convenience initialize for creating a SKButton
     
     - parameter defaultButtonImage: the primary button appearance
     - parameter onTapButtonImage:   the on tap button appearance
     - parameter buttonText:         the buttons's text
     - parameter textOffset:         (x, y) offset of text within the button
     
     - returns: an <i>SKButton</i>
     */
    
    convenience init(defaultButtonImage: String, clickedImageName onTapButtonImage: String, withText buttonText: String, withTextOffset textOffset: CGPoint) {
        self.init(defaultButtonImage: defaultButtonImage, clickedImageName: onTapButtonImage, withText: buttonText, withTextOffset: textOffset, atPosition: SKButtonDefaults.position)
    }
    
    /**
     Convenience initialize for creating a SKButton
     
     - parameter defaultButtonImage: the primary button appearance
     - parameter onTapButtonImage:   the on tap button appearance
     - parameter buttonText:         the buttons's text
     - parameter position:           (x, y) position of the button in the view
     
     - returns: an <i>SKButton</i>
     */
    
    convenience init(defaultButtonImage: String, clickedImageName onTapButtonImage: String, withText buttonText: String, atPosition position: CGPoint){
        self.init(defaultButtonImage: defaultButtonImage, clickedImageName: onTapButtonImage, withText: buttonText, withTextOffset: SKButtonDefaults.textOffset, atPosition: position)
    }
    
    /**
     Convenience initialize for creating a SKButton
     
     - parameter defaultButtonImage: the primary button appearance
     - parameter onTapButtonImage:   the on tap button appearance
     - parameter buttonText:         the buttons's text
     
     - returns: an <i>SKButton</i>
     */
    
    convenience init(defaultButtonImage: String, clickedImageName onTapButtonImage: String, withText buttonText: String){
        self.init(defaultButtonImage: defaultButtonImage, clickedImageName: onTapButtonImage, withText: buttonText, withTextOffset: SKButtonDefaults.textOffset, atPosition: SKButtonDefaults.position)
    }
    
    /**
     Convenience initialize for creating a SKButton
     
     - parameter defaultButtonImage: the primary button appearance
     - parameter onTapButtonImage:   the on tap button appearance
     - parameter position:           (x, y) position of the button in the view
     
     - returns: an <i>SKButton</i>
     */
    
    convenience init(defaultButtonImage: String, clickedImageName onTapButtonImage: String, atPosition position: CGPoint) {
        self.init(defaultButtonImage: defaultButtonImage, clickedImageName: onTapButtonImage, withText: SKButtonDefaults.buttonText, withTextOffset: SKButtonDefaults.textOffset, atPosition: position)
    }
    
    /**
     Convenience initialize for creating a SKButton
     
     - parameter defaultButtonImage: the button appearance
     - parameter onTapButtonImage:   the on tap button appearance
     
     - returns: an <i>SKButton</i>
     */
    
    convenience init(defaultButtonImage: String, clickedImageName onTapButtonImage: String) {
        self.init(defaultButtonImage: defaultButtonImage, clickedImageName: onTapButtonImage, withText: SKButtonDefaults.buttonText, withTextOffset: SKButtonDefaults.textOffset, atPosition: SKButtonDefaults.position)
    }
    
    /**
     Convenience initialize for creating a SKButton
     
     - parameter buttonImage: the button appearance
     - parameter position:    (x, y) position of the button in the view
     
     - returns: an <i>SKButton</i>
     */
    
    convenience init(buttonImage: String, atPosition position:CGPoint){
        self.init(defaultButtonImage: buttonImage, clickedImageName: "", withText: SKButtonDefaults.buttonText, withTextOffset: SKButtonDefaults.textOffset, atPosition: position)
    }
    
    /**
     Convenience initialize for creating a SKButton
     
     - parameter buttonImage: the button appearance
     
     - returns: an <i>SKButton</i>
     */
    
    convenience init(buttonImage: String) {
        self.init(defaultButtonImage: buttonImage, clickedImageName: "", withText: SKButtonDefaults.buttonText, withTextOffset: SKButtonDefaults.textOffset, atPosition: SKButtonDefaults.position)
    }
    
    /**
     Convenience initialize for creating a SKButton
     
     - parameter color: the button appearance color
     
     - returns: an <i>SKButton</i>
     */
    
    convenience init(color: UIColor){
        SKButtonDefaults.buttonColor = color
        self.init(defaultButtonImage: "", clickedImageName: "", withText: SKButtonDefaults.buttonText, withTextOffset: SKButtonDefaults.textOffset, atPosition: SKButtonDefaults.position)
    }
    
    /**
     Simple initializer for creating an SKButton with default values
     
     - returns: an <i>SKButton</i>
     */
    
    convenience override init () {
        self.init(defaultButtonImage: "", clickedImageName: "", withText: SKButtonDefaults.buttonText, withTextOffset: SKButtonDefaults.textOffset, atPosition: SKButtonDefaults.position)
    }
    
    /*!
    Generates the SKButton's text label
    
    - parameter text: the button's text
    
    - returns: an <i>SKLabelNode</i> that is the button's text
    */
    
    private class func createLabel(text: String) -> SKLabelNode{
        let newLabel:SKLabelNode = SKLabelNode()
        if (text == ""){
            newLabel.text = SKButtonDefaults.buttonText
        } else {
            newLabel.text = text
        }
        newLabel.zPosition = SKButtonDefaults.zPosition + 2
        newLabel.fontColor = SKButtonDefaults.fontColor
        newLabel.fontName = SKButtonDefaults.font
        newLabel.fontSize = SKButtonDefaults.fontSize
        return newLabel
    }
    
    /* ---- PUBLIC METHODS ---- */
    
    /**
    Sets the font of the SKButton
    
    - parameter name:  a string of the font name (Ex: "Helvetica")
    - parameter color: the text color
    - parameter size:  the font size
    */
    
    func setFont(name: String?, withColor color: UIColor?, withSize size: CGFloat?){
        if (name == nil){
            self.label.fontName = SKButtonDefaults.font
        } else {
            self.label.fontName = name
        }
        if (color == nil){
            self.label.fontColor = SKButtonDefaults.fontColor
        } else {
            self.label.fontColor = color
        }
        if (size == nil){
            self.label.fontSize = SKButtonDefaults.fontSize
        } else {
            self.label.fontSize = size!
        }
    }
    /**
     Fades the button out of the parent view
     */
    func hide() {
        self.runAction(SKButtonAnimations.disappearAnimation) { () -> Void in
            self.removeFromParent()
        }
    }
    /**
     Fades the button into the parent view
     
     - parameter parentScene: the scene the button will appear in
     */
    func showIn(parentScene: SKScene) {
        parentScene.addChild(self)
        self.runAction(SKButtonAnimations.appearAnimation)
    }
    
    /* ---- TOUCH ---- */
    
    /**
    Built in SKNode touchesBegan override
    
    - parameter touches: SKNode sent multitouch Set
    - parameter event:   SKNode send event
    */
    internal override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.onTapButton.hidden = false
        self.defaultButton.hidden = true
        self.delegate?.skButtonTouchBegan?(self)
    }
    /**
     Built in SKNode touchesEnded override
     
     - parameter touches: SKNode sent multitouch Set
     - parameter event:   SKNode send event
     */
    internal override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if (!self.touchCancelled){
            self.defaultButton.hidden = false
            self.onTapButton.hidden = true
            self.delegate?.skButtonTouchEnded(self)
        }
        self.touchCancelled = false
    }
    /**
     Built in SKNode touchesMoved override
     
     - parameter touches: SKNode sent multitouch Set
     - parameter event:   SKNode send event
     */
    internal override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if (self.touchCancelled == false){
            self.defaultButton.hidden = false
            self.onTapButton.hidden = true
            self.touchCancelled = true
        }
    }
    /**
     Built in SKNode touchesCancelled override
     
     - parameter touches: SKNode sent multitouch Set
     - parameter event:   SKNode send event
     */
    internal override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        self.defaultButton.hidden = false
        self.onTapButton.hidden = true
        self.touchCancelled = true
    }
}

/* ----- ASSITANT STRUCTS, FUNCTIONS, ETC ---- */

/**
*  A simple struct for getting the device's screen size
*/
struct Device {
    private static let screen: CGSize = UIScreen.mainScreen().bounds.size
    private static let screenDensity = UIScreen.mainScreen().nativeScale
    static let screenSize: CGSize = CGSize(width: Device.screen.width * Device.screenDensity, height: Device.screen.height * Device.screenDensity)
}

/**
 *  A struct containing all the default settings for an SKButton
 */
private struct SKButtonDefaults {
    static let accessibilityLabel: String = "Button"
    static let alpha: CGFloat = 1
    static var BUTTON_ID: Int = 0
    static let buttonText: String = ""
    static var buttonColor: SKColor = SKColor.yellowColor()
    static let tapButtonColor: SKColor = SKColor(red: 0, green: 0, blue: 0, alpha: 0.5)
    static let font:String = "Chalkduster"
    static let fontColor: UIColor = UIColor.blackColor()
    static let fontSize: CGFloat = 32
    static let hidden: Bool = false
    static let position: CGPoint = CGPoint(x: Device.screenSize.width / 2, y: Device.screenSize.height / 2)
    static let scale: CGFloat = 1
    static let textOffset: CGPoint = CGPoint(x: 0, y: 0)
    static let tintColor: UIColor = SKColor.clearColor()
    static let tintColorBlend: CGFloat = 1.0
    static let userInteractionEnabled = true
    static let zPosition: CGFloat = 1
    static let zRotation: CGFloat = 0
}
/**
 *  A struct containing animations used on an SKButton
 */
private struct SKButtonAnimations {
    static let appearAnimation: SKAction = SKAction.fadeInWithDuration(0.5)
    static let disappearAnimation: SKAction = SKAction.fadeOutWithDuration(0.5)
}

/// Simplified method to easily place SKButtons on screen
class SKButtonPosition {
    
    /**
     *  the margin from the screen edge that will be applied to all SKButtons placed after this is set and
     *  placed using the SKButtonPosition class functions
     */
    static var distanceFromScreenEdge: CGFloat = 0
    /**
     Place an SKButton at the Top-Left of a view
     
     - parameter button: an <i>SKButton</i>
     
     - returns: a calculated <i>CGPoint</i>
     */
    class func TopLeft(button: SKButton) -> CGPoint {
        let x = button.size.width / 2 + SKButtonPosition.distanceFromScreenEdge
        let y = Device.screenSize.height - (button.size.height / 2) - SKButtonPosition.distanceFromScreenEdge
        return CGPoint(x: x, y: y)
    }
    /**
     Place an SKButton at the Top-Center of a view
     
     - parameter button: an <i>SKButton</i>
     
     - returns: a calculated <i>CGPoint</i>
     */
    class func TopCenter(button: SKButton) -> CGPoint {
        let x = Device.screenSize.width / 2
        let y = Device.screenSize.height - (button.size.height / 2) - SKButtonPosition.distanceFromScreenEdge
        return CGPoint(x: x, y: y)
    }
    /**
     Place an SKButton at the Top-Right of a view
     
     - parameter button: an <i>SKButton</i>
     
     - returns: a calculated <i>CGPoint</i>
     */
    class func TopRight(button: SKButton) -> CGPoint {
        let x = Device.screenSize.width - (button.size.width / 2 + SKButtonPosition.distanceFromScreenEdge)
        let y = Device.screenSize.height - (button.size.height / 2) - SKButtonPosition.distanceFromScreenEdge
        return CGPoint(x: x, y: y)
    }
    /**
     Place an SKButton at the Center-Left of a view
     
     - parameter button: an <i>SKButton</i>
     
     - returns: a calculated <i>CGPoint</i>
     */
    class func CenterLeft(button: SKButton) -> CGPoint {
        let x = button.size.width / 2 + SKButtonPosition.distanceFromScreenEdge
        let y = Device.screenSize.height / 2
        return CGPoint(x: x, y: y)
    }
    /**
     Place an SKButton at the Center of a view
     
     - parameter button: an <i>SKButton</i>
     
     - returns: a calculated <i>CGPoint</i>
     */
    class func Center(button: SKButton) -> CGPoint {
        let x = Device.screenSize.width / 2
        let y = Device.screenSize.height / 2
        return CGPoint(x: x, y: y)
    }
    /**
     Place an SKButton at the Center-Right of a view
     
     - parameter button: an <i>SKButton</i>
     
     - returns: a calculated <i>CGPoint</i>
     */
    class func CenterRight(button: SKButton) -> CGPoint {
        let x = Device.screenSize.width - (button.size.width / 2 + SKButtonPosition.distanceFromScreenEdge)
        let y = Device.screenSize.height / 2
        return CGPoint(x: x, y: y)
    }
    /**
     Place an SKButton at the Bottom-Left of a view
     
     - parameter button: an <i>SKButton</i>
     
     - returns: a calculated <i>CGPoint</i>
     */
    class func BottomLeft(button: SKButton) -> CGPoint {
        let x = button.size.width / 2 + SKButtonPosition.distanceFromScreenEdge
        let y = button.size.height / 2 + SKButtonPosition.distanceFromScreenEdge
        return CGPoint(x: x, y: y)
    }
    /**
     Place an SKButton at the Bottom-Center of a view
     
     - parameter button: an <i>SKButton</i>
     
     - returns: a calculated <i>CGPoint</i>
     */
    class func BottomCenter(button: SKButton) -> CGPoint {
        let x = Device.screenSize.width / 2
        let y = button.size.height / 2 + SKButtonPosition.distanceFromScreenEdge
        return CGPoint(x: x, y: y)
    }
    /**
     Place an SKButton at the Top-Right of a view
     
     - parameter button: an <i>SKButton</i>
     
     - returns: a calculated <i>CGPoint</i>
     */
    class func BottomRight(button: SKButton) -> CGPoint {
        let x = Device.screenSize.width - (button.size.width / 2 + SKButtonPosition.distanceFromScreenEdge)
        let y = button.size.height / 2 + SKButtonPosition.distanceFromScreenEdge
        return CGPoint(x: x, y: y)
    }
}

// MARK: - A private UIColor extension
private extension UIColor {
    /**
     Gets the RGB and Alpha values from a UIColor
     
     - returns: a Tuple of (R, G, B, A) as <i>CGFloats</i>
     */
    func rgb() -> (red:CGFloat, green:CGFloat, blue:CGFloat, alpha:CGFloat)? {
        var fRed : CGFloat = 0
        var fGreen : CGFloat = 0
        var fBlue : CGFloat = 0
        var fAlpha: CGFloat = 0
        if self.getRed(&fRed, green: &fGreen, blue: &fBlue, alpha: &fAlpha) {
            let iRed = CGFloat(fRed * 255.0)
            let iGreen = CGFloat(fGreen * 255.0)
            let iBlue = CGFloat(fBlue * 255.0)
            let iAlpha = CGFloat(fAlpha * 255.0)
            
            return (red:iRed, green:iGreen, blue:iBlue, alpha:iAlpha)
        } else {
            // Could not extract RGBA components:
            return nil
        }
    }
    /**
     A debugging string of a UIColor's RGBA
     
     - returns: a debugging <i>String<i/>
     */
    func toString() -> String {
        let RGB = self.rgb()!
        return "Red: \(RGB.red), Green: \(RGB.green), Blue: \(RGB.blue), Alpha: \(RGB.alpha)"
    }
    /**
     Darkens a color by a factor of 50
     
     - returns: a darkened <i>UIColor</i>
     */
    func darken() -> UIColor {
        let current = self.rgb()
        let darkenBy:CGFloat = 50.0
        if (current != nil){
            var newRed: CGFloat = current!.red - darkenBy
            var newGreen: CGFloat = current!.green - darkenBy
            var newBlue: CGFloat = current!.blue - darkenBy
            let alpha: CGFloat = current!.alpha
            if (newRed < 0){
                newRed = 0.0
            }
            if (newGreen < 0){
                newGreen = 0.0
            }
            if (newBlue < 0){
                newBlue = 0.0
            }
            let newColor = UIColor(red: newRed / 255, green: newGreen / 255, blue: newBlue / 255, alpha: alpha / 255)
            return newColor
            
        } else {
            return UIColor.clearColor()
        }
    }
}
