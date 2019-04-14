import Foundation

class GameScore{
    // Singleton
    static let instance = GameScore(lives: 3)
    
    var Lives: Int
    var Score: Int
    
    var HasLives: Bool{
        get{
            return Lives > 0
        }
    }
    

    init(lives: Int){
        Lives = lives
        Score = 0
    }
    

    public func AddScore(scoreToAdd: Int){
        Score += scoreToAdd
    }
    
    public func TakeLife(){
        Lives -= 1
    }
    public func reset(){
        Lives = 3
        Score = 0
    }
}
