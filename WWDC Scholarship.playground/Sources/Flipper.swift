import Foundation
import SpriteKit
class Flipper: SKSpriteNode{
    private var isUp = false
    private var lowerRotationLimit: CGFloat = 0.0
    private var upperRotationLimit: CGFloat = 0.0
    
    private var upRotation: CGFloat = 0.0
    private var lowerRotation: CGFloat = 0.0
    
    private var actionDuration: TimeInterval = TimeInterval()
    private var upRotationAction: SKAction = SKAction()
    private var downRotationAction: SKAction = SKAction()
    
    private var shouldApplyImpulse: Bool = false
    

    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    

    
    public func Initialize(upperRotationLimit: CGFloat, lowerRotationLimit: CGFloat, actionDuration: CGFloat){
        self.isUp = false
        self.upperRotationLimit = upperRotationLimit
        self.lowerRotationLimit = lowerRotationLimit
        
        self.upRotation = Angle.ToRadians(degrees: upperRotationLimit)
        self.lowerRotation = Angle.ToRadians(degrees: lowerRotationLimit)
        
        self.actionDuration = TimeInterval(actionDuration)
        self.upRotationAction = SKAction.rotate(byAngle: upRotation, duration: self.actionDuration)
        self.downRotationAction = SKAction.rotate(byAngle: lowerRotation, duration: self.actionDuration)
        guard let physicsBody = self.physicsBody else {return}
        physicsBody.isDynamic = false
        physicsBody.categoryBitMask = Physics.FlipperCategory.rawValue
        physicsBody.collisionBitMask = Physics.BallCategory.rawValue
        physicsBody.contactTestBitMask = Physics.BallCategory.rawValue
        
        if name == "Left Flipper"{
            texture = SKTexture(imageNamed: "leftb")
        }
    }
    
    public func MoveUp(){
        if !isUp{
            isUp = true
            self.shouldApplyImpulse = true
            self.run(upRotationAction, completion: {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.1, execute: {
                    //delayed disable of shouldApplyImpulse to improve the ball being hit on the flipper
                    self.shouldApplyImpulse = false
                })
            })
        }
    }
    
    public func MoveDown(){
        if isUp{
            self.run(downRotationAction)
            isUp = false
        }
    }
    
    public func CheckIfApllyImpulse(ball: Ball, impulse: CGVector){
        if shouldApplyImpulse{
            ball.physicsBody?.applyImpulse(impulse)
        }
    }
}
