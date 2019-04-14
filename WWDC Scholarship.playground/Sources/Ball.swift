import Foundation
import SpriteKit
class Ball: SKSpriteNode{
    private var spawnPoint: CGPoint = CGPoint(x: 0.0, y: 0.0)
    private var heighThreshold: CGFloat = 0.0

    init(){
        let texture = SKTexture(imageNamed: "Ball")
        let color = SKColor.white
        let size = CGSize(width: 1.0, height: 1.0)
        
        super.init(texture: texture, color: color, size: size)
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    public func Initialize(spawnPoint: CGPoint, screenHeight: CGFloat){
        
        guard let physicsBody = self.physicsBody else {return}
        self.spawnPoint = spawnPoint
        self.heighThreshold = -(screenHeight * 0.5) - self.size.height * 0.5

        physicsBody.isDynamic = true
        physicsBody.categoryBitMask = Physics.BallCategory.rawValue
        physicsBody.contactTestBitMask = Physics.FlipperCategory.rawValue | Physics.BumperCategory.rawValue
        
        physicsBody.collisionBitMask = Physics.FlipperCategory.rawValue | Physics.BumperCategory.rawValue
        texture = SKTexture(imageNamed: "Ball")
    }
    
    public func CheckIfResetBall() -> Bool{
        if self.position.y < heighThreshold{
            ResetBall()
            
            return true
        }
        
        return false
    }
    

    private func ResetBall(){
        guard let physicsBody = self.physicsBody else {return}
        
        
        let spawnPosition = spawnPoint
        self.position = spawnPosition
        
        physicsBody.velocity = CGVector(dx: 0, dy: 0)
        physicsBody.applyImpulse(CGVector(dx: 10, dy: 1000))
    }
}

