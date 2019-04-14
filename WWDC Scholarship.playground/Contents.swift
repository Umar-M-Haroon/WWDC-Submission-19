/*:Intro
 Hi WWDC Scholarship review team!
 
I hope you enjoy pinball!
 
Use the arrow keys for the bumpers. There are 3 lives (which can be changed in GameScore.swift)
 
Have Fun!
 
-Umar Haroon
 */
import PlaygroundSupport
import SpriteKit
func load(){

    let sceneView = SKView(frame: CGRect(x:0 , y:0, width: 380, height: 667))
    let scene = MenuScene(size: sceneView.frame.size)
    scene.scaleMode = .aspectFill
    // Present the scene
    sceneView.presentScene(scene)
     PlaygroundSupport.PlaygroundPage.current.liveView = sceneView
    PlaygroundSupport.PlaygroundPage.current.needsIndefiniteExecution = true
    
}
load()






