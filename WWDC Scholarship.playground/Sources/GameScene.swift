import Foundation
import SceneKit
import GameplayKit

public class GameScene: SKScene, SKPhysicsContactDelegate{
    
    var screenWidth: CGFloat = 0.0
    var screenHeight: CGFloat = 0.0
    
    var entities = [GKEntity]()
    var graphs = [String: GKGraph]()
    
    //Labels
    
    private var scoreLabel: SKLabelNode!
    private var livesLabel: SKLabelNode!
    
    //Nodes for the ball and flippers
    private var ballNode: Ball!
    private var ballSpawnPointNode: SKNode!
    
    private var leftFlipper: Flipper!
    private var rightFlipper: Flipper!
    private var rightFlipper2: Flipper!
    
    
    

    //initialize scene
    
    override public func sceneDidLoad(){
        screenWidth = self.size.width
        screenHeight = self.size.height
        physicsWorld.contactDelegate = self
        
        
        FindNodes()
        FindUINodes()
        
    }
//on each update see if ball needs to be reset
    override public func update(_ currentTime: TimeInterval){
        
        // Takes a life if the ball has resetted.
        if (ballNode.CheckIfResetBall()){
            
            GameScore.instance.TakeLife()
            self.livesLabel.text = "Lives: \(GameScore.instance.Lives)"
        }
        
        if(GameScore.instance.Lives < 0){
            ChangeToGameOverScene()
        }
    }
    
// arrow keys for flippers (123 is left 124 is right)
    public override func keyDown(with event: NSEvent) {
        if event.keyCode == 123{
            Touch_TappedLeft()
        }else if event.keyCode == 124{
            Touch_TappedRight()
        }
    }
    public override func keyUp(with event: NSEvent) {
        if event.keyCode == 123{
            Touch_LetGoLeft()
        }else if event.keyCode == 124{
            Touch_LetGoRight()
        }
    }

    
    public func didBegin(_ contact: SKPhysicsContact){
        
        // Detects if something has collided with a flipper.
        if Collision.HasSomethingCollided(contact: contact,
                                          categoryBitMask: PhysicsCategory.FlipperCategory){
            let impulse = CGVector(dx: 10, dy: 700)
            leftFlipper.CheckIfApllyImpulse(ball: ballNode!, impulse: impulse)
            rightFlipper.CheckIfApllyImpulse(ball: ballNode!, impulse: impulse)
        }
        
        // Checks if the ball has collided with a bumper.
        if Collision.HasCollided(contact: contact, categoryA: Physics.BallCategory.rawValue,
                                 categoryB: Physics.BumperCategory.rawValue){
            let bumper: Bumper = Collision.GetNode(contact: contact)
            bumper.Collided()
            
            // Updates the game score.
            GameScore.instance.AddScore(scoreToAdd: bumper.PointsToGive)
            scoreLabel?.text = "Score: \(GameScore.instance.Score)"
            
            let label = SKLabelNode(text: "+\(bumper.pointsToGive)")
            label.position = CGPoint(x: bumper.position.x+70, y: bumper.position.y+20)
            
            addChild(label)
            
            
            let fadein = SKAction.fadeIn(withDuration: 0.2)
            let fadeOut = SKAction.fadeOut(withDuration: 0.5)
            let remove = SKAction.removeFromParent()
            label.run(SKAction.sequence([fadein,fadeOut,remove]))
            
        }
        
        
    }
    

    
    // Finds all scene nodes.
    private func FindNodes(){
        
        self.ballSpawnPointNode = childNode(withName: "Ball Spawn Point")!

        self.ballNode = childNode(withName: "//Ball") as? Ball
        
        self.ballNode.Initialize(spawnPoint: CGPoint(x: 301.0, y: -600.0), screenHeight: screenHeight)
        leftFlipper = childNode(withName: "//Left Flipper") as? Flipper
        
        rightFlipper = childNode(withName: "//Right Flipper") as? Flipper
        
        rightFlipper2 = childNode(withName: "//Upper Right Flipper") as? Flipper
        
        leftFlipper.Initialize(upperRotationLimit: 45, lowerRotationLimit: -45, actionDuration: 0.05)
        rightFlipper.Initialize(upperRotationLimit: -45, lowerRotationLimit: 45, actionDuration: 0.05)
        rightFlipper2.Initialize(upperRotationLimit: -45, lowerRotationLimit: 45, actionDuration: 0.08)
        
        
        let bumperA = childNode(withName: "Stage/Bumpers/Bumper A") as! Bumper
        let bumperB = childNode(withName: "Stage/Bumpers/Bumper B") as! Bumper
        let bumperC = childNode(withName: "Stage/Bumpers/Bumper C") as! Bumper
        let bumperD = childNode(withName: "Stage/Bumpers/Bumper D") as! Bumper
        bumperA.Initialize(pointsToGive: 15)
        bumperB.Initialize(pointsToGive: 15)
        bumperC.Initialize(pointsToGive: 15)
        bumperD.Initialize(pointsToGive: 15)
        
        let bumper2A = childNode(withName: "Stage/Bumpers/Bumper 2A") as! BumperB
        let bumper2B = childNode(withName: "Stage/Bumpers/Bumper 2B R") as! BumperB
        bumper2A.Initialize(pointsToGive: 25)
        bumper2B.Initialize(pointsToGive: 25)
        
        let light0 = childNode(withName: "Stage/Lights/Light0") as! Light
        let light1 = childNode(withName: "Stage/Lights/Light1") as! Light
        let light2 = childNode(withName: "Stage/Lights/Light2") as! Light
        
        light0.Initialize()
        light1.Initialize()
        light2.Initialize()
        
    }
    
    // Finds all UI scene nodes.
    private func FindUINodes(){
        self.scoreLabel = self.childNode(withName: "Score Label") as? SKLabelNode
        self.livesLabel = self.childNode(withName: "Lives Label") as? SKLabelNode
        self.livesLabel.text = "Lives: \(GameScore.instance.Lives)"
    }
    
    func Touch_TappedLeft(){
        leftFlipper.MoveUp()
    }
    
    func Touch_TappedRight(){
        rightFlipper.MoveUp()
        rightFlipper2.MoveUp()
    }
    
    private func Touch_LetGoLeft(){
        
        
        leftFlipper.MoveDown()
        rightFlipper.MoveDown()
        rightFlipper2.MoveDown()
    }
    
    private func Touch_LetGoRight(){
        
        
        leftFlipper.MoveDown()
        rightFlipper.MoveDown()
        rightFlipper2.MoveDown()
    }
    
    private func ChangeToGameOverScene(){
        
        let lossScene = EndScene(size: self.size)
        lossScene.scaleMode=scaleMode
        
        let transition = SKTransition.crossFade(withDuration: 0.5)
        self.view?.presentScene(lossScene,transition:transition)
    }
}
