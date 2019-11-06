//
//  CenaJogo.swift
//  FelPixApp
//
//  Created by Gabriel Jacinto on 05/11/19.
//  Copyright © 2019 Gabriel Jacinto. All rights reserved.
//

import SpriteKit

class CenaJogo: SKScene {
    
    //Override
    
    
    override func didMove(to view: SKView) {
        self.backgroundColor = UIColor.blue
        
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
        
        var felpudo = SKSpriteNode()
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
    }
}
