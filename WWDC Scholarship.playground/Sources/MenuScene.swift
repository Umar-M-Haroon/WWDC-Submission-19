import Foundation
import SpriteKit
public class MenuScene:SKScene{

    override public func didMove(to view: SKView){
        backgroundColor = SKColor.black
        DrawText()
    }
    
    override public func sceneDidLoad(){
        GameScore.instance.reset()
    }
    
    public override func keyDown(with event: NSEvent) {
        let newScene = GameScene(fileNamed: "GameScene")
        newScene?.scaleMode=scaleMode

        let transition = SKTransition.crossFade(withDuration: 1.0)
        self.view?.presentScene(newScene!, transition: transition)
    }

    private func DrawText(){
        let titleLabel = SKLabelNode(text:"Pinball")
        SetFontSettings(label: titleLabel, fontColor: SKColor.white, fontSize: 70)
        titleLabel.position = CGPoint(x:self.frame.size.width/2, y:self.frame.size.height/2 + 50)
        
        
        let authorLabel = SKLabelNode(text:"By: Umar Haroon")
        SetFontSettings(label: authorLabel, fontColor: SKColor.white, fontSize: 40)
        authorLabel.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2 - 20)
        
        
        let tipLabel=SKLabelNode(text:"Press any key to Begin")
        SetFontSettings(label: tipLabel, fontColor: SKColor.white, fontSize: 40)
        tipLabel.position=CGPoint(x: self.frame.size.width/2, y: tipLabel.fontSize)
        
        self.addChild(titleLabel)
        self.addChild(authorLabel)
        self.addChild(tipLabel)
    }
    
    private func SetFontSettings(label: SKLabelNode, fontColor: SKColor, fontSize: Int){
        label.fontColor = fontColor
        label.fontSize = CGFloat(fontSize)
    }
}
