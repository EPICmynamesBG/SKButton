# SKButton
---

## What is this?

If you've ever used the iOS SpriteKit, you've probably realized that there are a number of interface objects you can create extended from the <i>SKNode</i> class: an <i>SKSpriteNode</i>, <i>SKLabelNode</i>, <i>SKAudioNode</i>, etc. But what is missing is one of the most important interface modules: the button! Thus, <b><i>SKButton</i></b> came to exist. <b><i>SKButton</i></b> makes it possible for SpriteKit developers to easily place an interactive button in their game. 

### Practical Use Cases

A <b><i>SKButton</i></b> could be useful in many cases of game development, including main menus, pause menus, game over screens, or even as a part of the game. The options are endless!

## About

<b><i>SKButton</i></b> is written using current <i>Swift 2.1.1</i> syntax. At this time, I do not plan on creating an <i>Objective-C</i> version unless I recieve requests to do so. The <b><i>SKButton</i></b> class provides all of the features of an <i>SKNode</i> and even some added ones, like `tintColor` and `shrinkOnTap`.

## How-To

With the <i>SKButton.swift</i> file are 4 demo XCode projects to help introduce users to the use of an <b><i>SKButton</i></b>. But to get started using your own project, first open up a current or new XCode Project that uses SpriteKit. Next (after downloading the repo or zip file), simply drag and drop or copy the <i>SKButton.swift</i> file into your project. That's it! Now you can began creating buttons in SpriteKit!

## An Example

a. Create an XCode Project > iOS Game using SpriteKit.

b. In <i>GameViewController</i>, under `viewDidLoad()`, delete the default code and replace it with the below.
```Swift
      let skView: SKView = self.view as! SKView
      skView.showsFPS = true
      skView.showsNodeCount = true
      let scene = GameScene(size: Device.screenSize)
      scene.scaleMode = .AspectFill
      skView.presentScene(scene)
```
c. Now go to <i>GameScene</i>, and under `didMoveToView(view: SKSView)`, create a <b><i>SKButton</i></b> using the following.
```Swift
      let myButton = SKButton()
      self.addChild(myButton)
```
d. You may notice that touching the button does nothing. Now go up to the top of the file, and next to `GameScene: SKScene`, append `SKButtonDelegate`. It should look like this now: `GameScene: SKScene, SKButtonDelegate`.

e. XCode is now generating an error from an unimplemented delegate method. Scroll down, and below the `didMoveToView` function, add the below.
```Swift
      func skButtonTouchEnded(sender: SKButton){
        print("I've been clicked!")
      }
```
f. Run the project, and now when the button is clicked, you should see "I've been clicked!" appear in the console.

## *SKButton* Properties
*Inherits all properties from an SKNode*
- [SKNode Apple Docs](https://developer.apple.com/library/ios/documentation/SpriteKit/Reference/SKNode_Ref/index.html#//apple_ref/occ/clm/SKNode/nodeWithFileNamed:)
- [SKNode U3DXT Docs](http://u3dxt.com/api/html/T_U3DXT_iOS_Native_SpriteKit_SKNode.htm)

*Added properties*
* `color: UIColor`
* `delegate: SKButtonDelegate`
* `font: Tuple (fontName, fontColor, fontSize) (Read-only)`
* `fontColor: UIColor`
* `fontName: String`
* `fontSize: CGFloat`
* `size: CGSize`
* `shrinkOnTap: Bool`
* `text: String`
* `textOffset: CGPoint`
* `tintColor: UIColor`

## *SKButton* Methods
*Inherits all methods from an SKNode*
- [SKNode Apple Docs](https://developer.apple.com/library/ios/documentation/SpriteKit/Reference/SKNode_Ref/index.html#//apple_ref/occ/clm/SKNode/nodeWithFileNamed:)
- [SKNode U3DXT Docs](http://u3dxt.com/api/html/T_U3DXT_iOS_Native_SpriteKit_SKNode.htm)

*Initialization*
* `SKButton()`
* `SKButton(color: UIColor)`
* `SKButton(buttonImage: String)`
* `SKButton(buttonImage: String, atPosition position:CGPoint)`
* `SKButton(defaultButtonImage: String, clickedImageName onTapButtonImage: String)`
* `SKButton(defaultButtonImage: String, clickedImageName onTapButtonImage: String, atPosition position: CGPoint)`
* `SKButton(defaultButtonImage: String, clickedImageName onTapButtonImage: String, withText buttonText: String)`
* `SKButton(defaultButtonImage: String, clickedImageName onTapButtonImage: String, withText buttonText: String, atPosition position: CGPoint)`
* `SKButton(defaultButtonImage: String, clickedImageName onTapButtonImage: String, withText buttonText: String, withTextOffset textOffset: CGPoint)`
* `SKButton(defaultButtonImage: String, clickedImageName onTapButtonImage: String, withText buttonText: String, withTextOffset textOffset: CGPoint, atPosition position: CGPoint)`

*Added Methods*
* `setFont(name: String?, withColor color: UIColor?, withSize size: CGFloat?)`
* `hide()`
* `showIn(parentScene: SKScene)`

## SKButtonPosition - a positioning helper
Note: SKButtonPosition can only be used correctly when the GameViewController initializes the GameScene with `GameScene(size: Device.screenSize)`
*Variables*
* `distanceFromScreenEdge: CGFloat`
  * like a margin in HTML/CSS, this is used to space buttons from the edge when using the `SKButtonPosition` functions. Must be set prior to calling a `SKButtonPosition` function to be applied.

*Functions (Static)*
* `TopLeft(button: SKButton) -> CGPoint`
* `TopCenter(button: SKButton) -> CGPoint`
* `TopRight(button: SKButton) -> CGPoint`
* `CenterLeft(button: SKButton) -> CGPoint`
* `Center(button: SKButton) -> CGPoint`
* `CenterRight(button: SKButton) -> CGPoint`
* `BottomLeft(button: SKButton) -> CGPoint`
* `BottomCenter(button: SKButton) -> CGPoint`
* `BottomRight(button: SKButton) -> CGPoint`
** Note: These function use a VerticalHorizontal() positioning standard.**

## Requesting Features and Submitting Bugs

To submit a suggestion for a new or revised feature, simply submit an issue titled: [Feature Request] featureName.

Simliarly, to submit a bug, simply submit an issue with the bug name and a description of the bug and what you did to fid it. Code chunks and screenshots are helpful!

## Limitations and Future

Please see the issues tab for known bugs. 

This project is currently limited only by my personal use experience with SpriteKit. Suggestions are greatly appreciated!

In the future, this project will continue to become more robust. An Objective-C implementation may be made if users submit a feature request.

## License

SKButton is published under MIT License. See the LICENSE file for more.
