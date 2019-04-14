import Foundation
import SpriteKit
class EndScene:SKScene{

    override public func didMove(to view: SKView){
        backgroundColor = SKColor.black
        DrawGameOverScreen()
    }
    override func keyDown(with event: NSEvent) {
        
        let newScene = MenuScene(size:self.size)
        newScene.scaleMode = scaleMode
        
        let transition=SKTransition.crossFade(withDuration: 0.7)
        self.view?.presentScene(newScene,transition:transition)
    }
    private func DrawGameOverScreen(){
        let gameOverLabel=SKLabelNode(text:"Game Over")
        SetFontSettings(label: gameOverLabel, fontColor: SKColor.white, fontSize: 70)
        gameOverLabel.position=CGPoint(x:self.frame.size.width/2, y:self.frame.size.height/2)
        
        let scoreDisplayLabel=SKLabelNode(text:"Score: \(GameScore.instance.Score)")
        SetFontSettings(label: scoreDisplayLabel, fontColor: SKColor.white, fontSize: 40)
        scoreDisplayLabel.position=CGPoint(x:self.frame.size.width/2,
                                           y:(self.frame.size.height/2) - scoreDisplayLabel.fontSize)
        
        let tipLabel=SKLabelNode(text:"Press any key to Retry")
        SetFontSettings(label: tipLabel, fontColor: SKColor.white, fontSize: 40)
        tipLabel.position=CGPoint(x:self.frame.size.width/2,y:tipLabel.fontSize)
        
        self.addChild(gameOverLabel)
        self.addChild(scoreDisplayLabel)
        self.addChild(tipLabel)
    }
    
    private func SetFontSettings(label: SKLabelNode, fontColor: SKColor, fontSize: Int){
        
        label.fontColor = fontColor
        label.fontSize = CGFloat(fontSize)
    }
}
