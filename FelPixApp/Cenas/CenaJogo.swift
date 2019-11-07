//
//  CenaJogo.swift
//  FelPixApp
//
//  Created by Gabriel Jacinto on 05/11/19.
//  Copyright © 2019 Gabriel Jacinto. All rights reserved.
//

import SpriteKit

class CenaJogo: SKScene {
    
    // MRK: - Properties
    
    var felpudo = SKSpriteNode()
    var _comecou: Bool = false
    
    // MARK: - Override
    
    override func didMove(to view: SKView) {
        let objetoDummyMoveCena = SKNode()
        let moveFundo = SKAction.moveBy(x: -self.size.width, y: 0, duration: 3)
        let reposicionaFundo = SKAction.moveBy(x: self.size.width, y: 0, duration: 0)
        let sequence = SKAction.sequence([moveFundo, reposicionaFundo])
        let moveFundoSempre = SKAction.repeatForever(sequence)
        
        //for var i: CGFloat = 0; i<3; +=1 {
        for i in 0..<3 {
            var imagemFundo: SKSpriteNode = SKSpriteNode()
            imagemFundo = SKSpriteNode (imageNamed: "bgGame")
            imagemFundo.size.width = self.size.width
            imagemFundo.size.height = self.size.height
            imagemFundo.position.x = self.size.width / 2.0 + self.size.width * CGFloat(i)
            imagemFundo.position.y = self.size.height / 2.0
            imagemFundo.run(moveFundoSempre)
            imagemFundo.zPosition = -1
            imagemFundo.alpha = 0.85
            imagemFundo.texture?.filteringMode = .nearest
            objetoDummyMoveCena.addChild(imagemFundo)
        }
        
        self.addChild(objetoDummyMoveCena)
        
        var arrayImagensFelpudo: [SKTexture] = []
        var animacaoFelpudoVoa = SKAction()
        
        for i in 1...6 {
            let imagem = SKTexture(imageNamed: "felpudoVoa\(i)")
            imagem.filteringMode = .nearest
            arrayImagensFelpudo.append(imagem)
        }
        
        animacaoFelpudoVoa = SKAction.animate(with: arrayImagensFelpudo, timePerFrame: 0.07, resize: false, restore: true)
        felpudo = SKSpriteNode (texture: arrayImagensFelpudo[1])
        felpudo.setScale(2.3)
        felpudo.position.x = self.size.width/3
        felpudo.position.y = self.size.height/2
        felpudo.zPosition = 10
        felpudo.run(SKAction.repeatForever(animacaoFelpudoVoa))
        
        self.addChild(felpudo)
        
        let chaoDummy = SKNode()
        chaoDummy.position = CGPoint(x: self.size.width/2, y: -100)
        chaoDummy.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width:self.frame.size.width, height:1))
        chaoDummy.physicsBody?.isDynamic = false
        chaoDummy.name = "Chao"
        
        self.addChild(chaoDummy)
        
        let tetoDummy = SKNode()
        tetoDummy.position = CGPoint(x:self.size.width/2, y:self.size.height+100)
        tetoDummy.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.frame.size.width, height: 1))
        tetoDummy.physicsBody?.isDynamic = false
        tetoDummy.name = "Chao"
        
        self.addChild(tetoDummy)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        if !_comecou {
            felpudo.physicsBody = SKPhysicsBody(circleOfRadius: felpudo.size.height / 2)
            felpudo.physicsBody?.isDynamic = true
            felpudo.physicsBody?.allowsRotation = false
            felpudo.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            felpudo.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 150))
            
            _comecou = true
        }
            
        else {
            felpudo.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            felpudo.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 150))
        }
    }
    
    override func update(_ currentTime: CFTimeInterval) {
        if _comecou {
            let num = felpudo.physicsBody!.velocity.dy as CGFloat
            felpudo.zRotation = self.empinada(min: -1, max: 0.5, valor: num * 0.001)
        }
    }
    
    // MARK: - Methods
    
    func empinada(min: CGFloat, max: CGFloat, valor: CGFloat) -> CGFloat {
        if ( valor > max ) {
            return max
        }
            
        else if ( valor < min ) {
            return min
        }
            
        else {
            return valor
        }
    //}
    
    //func sorteiaObjetos() {
    //    criaObjetoCanos()
    //    _ = Timer.scheduledTime
    //}
}
