//
//  CenaLoja.swift
//  FelPixApp
//
//  Created by Gabriel Jacinto on 05/11/19.
//  Copyright © 2019 Gabriel Jacinto. All rights reserved.
//

import SpriteKit
import UIKit

class CenaLoja: SKScene {
    
    // MARK: - Properties
    
    var imagemFundo: SKSpriteNode!
    var botaoLojaTitulo: SKSpriteNode!
    var botaoLojaSemente: SKSpriteNode!
    var botaoLojaEstrela: SKSpriteNode!
    var botaoLojaSombra: SKSpriteNode!
    var botaoLojaRestaura: SKSpriteNode!
    var botaoSair: SKSpriteNode!
    
    
    // MARK: - Overrides
    
    override func didMove(to view: SKView) {
        setupImagemFundo()
        setupBotaoLojaTitulo()
        setupBotaoLojaSemente()
        setupBotaoLojaEstrela()
        setupBotaoLojaSombra()
        setupBotaoLojaRestaura()
        setupBotaoSair()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location: CGPoint! = touch.location(in: self)
            let nodeAtPoint = self.atPoint(location)
            
            if (nodeAtPoint.name == "botaoSair") {
                let transicao = SKTransition.crossFade(withDuration: 1)
                let cena = MenuInicio(size: self.size)
                self.view?.presentScene(cena, transition: transicao)
            }
        }
    }
    
    // MARK: - Methods
    
    func setupBotaoLojaTitulo() {
        botaoLojaTitulo = SKSpriteNode(imageNamed: "botaoLoja")
        botaoLojaTitulo.texture?.filteringMode = .nearest
        botaoLojaTitulo.setScale(2.3)
        //botaoLojaTitulo.position = CGPoint(x: self.size.width/2, y: self.size.height - botaoLojaTitulo.size.height/2 - 10)
        botaoLojaTitulo.position.x = self.size.width / 2
        botaoLojaTitulo.position.y = self.size.height * -2
        botaoLojaTitulo.zPosition = 1
        botaoLojaTitulo.alpha = 0.2
        
        let newY = self.size.height/2 - botaoLojaTitulo.size.height/2 + 260
        let animacaoEntra = SKAction.moveTo(y: newY, duration: 0.75)
        let animacaoAlpha = SKAction.fadeAlpha(to: 1, duration: 0.25)
        let animationSequence = SKAction.sequence([animacaoEntra, animacaoAlpha ])
        
        botaoLojaTitulo.run(animationSequence)
        
        self.addChild(botaoLojaTitulo)
    }
    
    func setupBotaoLojaSemente() {
        botaoLojaSemente = SKSpriteNode(imageNamed: "botaoLojaSemente")
        botaoLojaSemente.texture?.filteringMode = .nearest
        botaoLojaSemente.setScale(0.85)
        //botaoLojaSemente.position = CGPoint(x: self.size.width/2, y: botaoLojaTitulo.position.y - botaoLojaSemente.size.height/2 - 30)
        botaoLojaSemente.position.x = self.size.width / 2
        botaoLojaSemente.position.y = self.size.height * -2
        botaoLojaSemente.zPosition = 2
        botaoLojaSemente.alpha = 0.2
        
        let newY = self.size.height/2 - botaoLojaSemente.size.height/2 + 200
        let animacaoEntra = SKAction.moveTo(y: newY, duration: 0.75)
        let animacaoAlpha = SKAction.fadeAlpha(to: 1, duration: 0.25)
        let animationSequence = SKAction.sequence([SKAction.wait(forDuration: 0.5), animacaoEntra, animacaoAlpha ])
        
        botaoLojaSemente.run(animationSequence)
        
        self.addChild(botaoLojaSemente)
    }
    
    func setupBotaoLojaEstrela() {
        botaoLojaEstrela = SKSpriteNode(imageNamed: "botaoLojaEstrela")
        botaoLojaEstrela.texture?.filteringMode = .nearest
        botaoLojaEstrela.setScale(0.85)
        //botaoLojaEstrela.position = CGPoint(x: self.size.width/2, y: botaoLojaSemente.position.y - botaoLojaEstrela.size.height - 10)
        botaoLojaEstrela.position.x = self.size.width / 2
        botaoLojaEstrela.position.y = self.size.height * -2
        botaoLojaEstrela.zPosition = 2
        botaoLojaEstrela.alpha = 0.2
        
        let newY = self.size.height/2 - botaoLojaEstrela.size.height/2 + 70
        let animacaoEntra = SKAction.moveTo(y: newY, duration: 0.75)
        let animacaoAlpha = SKAction.fadeAlpha(to: 1, duration: 0.25)
        let animationSequence = SKAction.sequence([SKAction.wait(forDuration: 1.0), animacaoEntra, animacaoAlpha ])
        
        botaoLojaEstrela.run(animationSequence)
        
        self.addChild(botaoLojaEstrela)
    }
    
    func setupBotaoLojaSombra() {
        botaoLojaSombra = SKSpriteNode(imageNamed: "botaoLojaSombra")
        botaoLojaSombra.texture?.filteringMode = .nearest
        botaoLojaSombra.setScale(0.85)
        // botaoLojaSombra.position = CGPoint(x: self.size.width/2, y: botaoLojaEstrela.position.y - botaoLojaEstrela.size.height/2 - botaoLojaSombra.size.height/2 - 10)
        botaoLojaSombra.position.x = self.size.width / 2
        botaoLojaSombra.position.y = self.size.height * -2
        botaoLojaSombra.zPosition = 2
        botaoLojaSombra.alpha = 0.2
        
        let newY = self.size.height/2 - botaoLojaSombra.size.height/2 - 62
        let animacaoEntra = SKAction.moveTo(y: newY, duration: 0.75)
        let animacaoAlpha = SKAction.fadeAlpha(to: 1, duration: 0.25)
        let animationSequence = SKAction.sequence([SKAction.wait(forDuration: 1.5), animacaoEntra, animacaoAlpha ])
        
        botaoLojaSombra.run(animationSequence)
        
        self.addChild(botaoLojaSombra)
    }
    
    func setupBotaoLojaRestaura() {
        botaoLojaRestaura = SKSpriteNode(imageNamed: "botaoLojaRestaura")
        botaoLojaRestaura.texture?.filteringMode = .nearest
        botaoLojaRestaura.setScale(0.85)
        //botaoLojaRestaura.position = CGPoint(x: self.size.width/2, y: botaoLojaSombra.position.y - botaoLojaSombra.size.height/2 - botaoLojaRestaura.size.height/2 - 10)
        botaoLojaRestaura.position.x = self.size.width / 2
        botaoLojaRestaura.position.y = self.size.height * -2
        botaoLojaRestaura.zPosition = 2
        botaoLojaRestaura.alpha = 0.2
        
        let newY = self.size.height/2 - botaoLojaRestaura.size.height/2 - 160
        let animacaoEntra = SKAction.moveTo(y: newY, duration: 0.75)
        let animacaoAlpha = SKAction.fadeAlpha(to: 1, duration: 0.25)
        let animationSequence = SKAction.sequence([SKAction.wait(forDuration: 2.0), animacaoEntra, animacaoAlpha ])
        
        botaoLojaRestaura.run(animationSequence)
        
        self.addChild(botaoLojaRestaura)
    }
    
    func setupBotaoSair() {
        botaoSair = SKSpriteNode(imageNamed: "botaoSair")
        botaoSair.texture?.filteringMode = .nearest
        botaoSair.setScale(2.3)
        //botaoSair.position = CGPoint(x: self.size.width/2, y: botaoLojaRestaura.position.y - botaoLojaRestaura.size.height/2 - botaoSair.size.height/2 - 10)
        botaoSair.position.x = self.size.width / 2
        botaoSair.position.y = self.size.height * -2
        botaoSair.zPosition = 2
        botaoSair.alpha = 0.2
        
        let newY = self.size.height/2 - botaoSair.size.height/2 - 220
        let animacaoEntra = SKAction.moveTo(y: newY, duration: 0.75)
        let animacaoAlpha = SKAction.fadeAlpha(to: 1, duration: 0.25)
        let animationSequence = SKAction.sequence([SKAction.wait(forDuration: 2.5), animacaoEntra, animacaoAlpha ])
        
        botaoSair.run(animationSequence)
        
        botaoSair.name = "botaoSair"
        
        self.addChild(botaoSair)
    }
    
    func setupImagemFundo() {
        imagemFundo = SKSpriteNode(imageNamed: "bgAbout")
        imagemFundo.texture?.filteringMode = .nearest
        imagemFundo.zPosition = 0
        imagemFundo.size.width = self.size.width
        imagemFundo.size.height = self.size.height
        //imagemFundo.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        imagemFundo.position.x = self.size.width/2
        imagemFundo.position.y = self.size.height/2
        
        self.addChild(imagemFundo)
    }
}
