import Foundation
import SpriteKit
public class Collision{
    public static func HasCollided(contact: SKPhysicsContact, categoryA: UInt32, categoryB: UInt32) -> Bool{
        let bodyA: SKPhysicsBody = contact.bodyA
        let bodyB: SKPhysicsBody = contact.bodyB
        
        if (bodyA.categoryBitMask == categoryA && bodyB.categoryBitMask == categoryB){
            return true
        }
        if (bodyA.categoryBitMask == categoryB && bodyB.categoryBitMask == categoryA){
            return true
        }
        return false
    }
    
    public static func HasSomethingCollided(contact: SKPhysicsContact, categoryBitMask: UInt32) -> Bool{
        let bodyA: SKPhysicsBody = contact.bodyA
        let bodyB: SKPhysicsBody = contact.bodyB
        
        if (bodyA.categoryBitMask == categoryBitMask){
            return true
        }
        
        if (bodyB.categoryBitMask == categoryBitMask){
            return true
        }
        
        return false
    }
    
    public static func GetNode<T>(contact: SKPhysicsContact) -> T{
        if let component = contact.bodyA.node as? T{
            return component
        }
        
        if let component = contact.bodyB.node as? T{
            return component
        }
        
        fatalError()
    }
}
