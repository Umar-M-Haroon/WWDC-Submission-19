import Foundation
import SpriteKit
class Light: SKSpriteNode{

    init(){
        let texture = SKTexture(imageNamed: "LightInactive")
        let color = SKColor.white
        let size = CGSize(width: 1.0, height: 1.0)
        
        super.init(texture: texture, color: color, size: size)
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    public func Initialize(){
        let randomNum = Float.random(in: 0.3...4)
        let randomTime:TimeInterval = TimeInterval(randomNum)
        
        let inactiveTexture = SKTexture(imageNamed: "LightInactive")
        let activeTexture = SKTexture(imageNamed: "LightActive")
        
        let textureList = [activeTexture, inactiveTexture]
        let animationAction = SKAction.animate(with: textureList, timePerFrame: randomTime)
        self.run(SKAction.repeatForever(animationAction))
        
        // Sets the default texture.
        self.texture = inactiveTexture
    }
}
