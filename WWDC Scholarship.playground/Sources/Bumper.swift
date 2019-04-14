import Foundation
import SpriteKit
class Bumper: SKSpriteNode{
    public var PointsToGive: Int{
        get{
            return pointsToGive
        }
    }
    
    internal var pointsToGive: Int = 0
    internal var animationAction: SKAction?
    

    init(){
        let texture = SKTexture(imageNamed: "Bumperinactive.png")
        let color = SKColor.white
        let size = CGSize(width: 1.0, height: 1.0)
        
        super.init(texture: texture, color: color, size: size)
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    public func Initialize(pointsToGive: Int){
        self.pointsToGive = pointsToGive
        
        InitializePhysicsBody()
        InitializeAnimationAction()
        
        
    }

    public func Collided(){
        self.run(animationAction!)
    }
    

    internal func InitializePhysicsBody(){
        guard let physicsBody = self.physicsBody else {return}
        
        physicsBody.isDynamic = false
        physicsBody.affectedByGravity = false
        physicsBody.allowsRotation = false
        
        physicsBody.categoryBitMask = PhysicsCategory.BumperCategory
        physicsBody.collisionBitMask = PhysicsCategory.BallCategory
        physicsBody.contactTestBitMask = PhysicsCategory.BallCategory
    }
    
    internal func InitializeAnimationAction(){
        let inactiveTexture = SKTexture(imageNamed: "Bumperinactive")
        let activeTexture = SKTexture(imageNamed: "BumperActive")
        
        let textureList = [activeTexture, inactiveTexture]
        animationAction = SKAction.animate(with: textureList, timePerFrame: 0.05)
        
        // Sets the default texture.
        self.texture = inactiveTexture
    }
}

