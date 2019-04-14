import Foundation
import SpriteKit
class BumperB: Bumper{

    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    internal override func InitializePhysicsBody(){
        guard let physicsBody = self.physicsBody else {return}
        physicsBody.isDynamic = false
        physicsBody.affectedByGravity = false
        physicsBody.allowsRotation = false
        physicsBody.categoryBitMask = PhysicsCategory.BumperCategory
        physicsBody.collisionBitMask = PhysicsCategory.BallCategory
        physicsBody.contactTestBitMask = PhysicsCategory.BallCategory
    }
    
    internal override func InitializeAnimationAction(){
        
        var semiActiveTexture = SKTexture(imageNamed: "LB1")
        var activeTexture = SKTexture(imageNamed: "LB2")
        
        if self.name == "Bumper 2B R"{
            semiActiveTexture = SKTexture(imageNamed: "LB2R")
            activeTexture = SKTexture(imageNamed: "LB2RA")
        }
        
        let textureList = [activeTexture, semiActiveTexture]
        animationAction = SKAction.animate(with: textureList, timePerFrame: 0.05)
        
        // Sets the default texture.
        self.texture = semiActiveTexture
    }
}
