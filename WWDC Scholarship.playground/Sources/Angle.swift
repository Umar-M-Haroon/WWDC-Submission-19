import Foundation
import SpriteKit
class Angle{
    public static func ToRadians(degrees: CGFloat) -> CGFloat{
        return degrees * (CGFloat(Double.pi) / 180)
    }
}
