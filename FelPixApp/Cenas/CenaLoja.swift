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
    
    // MARK: - Methods
    
    func setupBotaoLojaTitulo() {
        botaoLojaTitulo = SKSpriteNode(imageNamed: "botaoLoja")
        botaoLojaTitulo.texture?.filteringMode = .nearest
        botaoLojaTitulo.setScale(2.3)
        botaoLojaTitulo.position = CGPoint(x: self.size.width/2, y: self.size.height - botaoLojaTitulo.size.height/2 - 10)
        botaoLojaTitulo.zPosition = 1
        
        self.addChild(botaoLojaTitulo)
    }
    
    func setupBotaoLojaSemente() {
        botaoLojaSemente = SKSpriteNode(imageNamed: "botaoLojaSemente")
        botaoLojaSemente.texture?.filteringMode = .nearest
        botaoLojaSemente.setScale(0.85)
        botaoLojaSemente.position = CGPoint(x: self.size.width/2, y: botaoLojaTitulo.position.y - botaoLojaSemente.size.height/2 - 30)
        botaoLojaSemente.zPosition = 2
        
        self.addChild(botaoLojaSemente)
    }
    
    func setupBotaoLojaEstrela() {
        botaoLojaEstrela = SKSpriteNode(imageNamed: "botaoLojaEstrela")
        botaoLojaEstrela.texture?.filteringMode = .nearest
        botaoLojaEstrela.setScale(0.85)
        botaoLojaEstrela.position = CGPoint(x: self.size.width/2, y: botaoLojaSemente.position.y - botaoLojaEstrela.size.height - 10)
        botaoLojaEstrela.zPosition = 2
        
        self.addChild(botaoLojaEstrela)
    }
    
    func setupBotaoLojaSombra() {
        botaoLojaSombra = SKSpriteNode(imageNamed: "botaoLojaSombra")
        botaoLojaSombra.texture?.filteringMode = .nearest
        botaoLojaSombra.setScale(0.85)
        botaoLojaSombra.position = CGPoint(x: self.size.width/2, y: botaoLojaEstrela.position.y - botaoLojaEstrela.size.height/2 - botaoLojaSombra.size.height/2 - 10)
        botaoLojaSombra.zPosition = 2
        
        self.addChild(botaoLojaSombra)
    }
    
    func setupBotaoLojaRestaura() {
        botaoLojaRestaura = SKSpriteNode(imageNamed: "botaoLojaRestaura")
        botaoLojaRestaura.texture?.filteringMode = .nearest
        botaoLojaRestaura.setScale(0.85)
        botaoLojaRestaura.position = CGPoint(x: self.size.width/2, y: botaoLojaSombra.position.y - botaoLojaSombra.size.height/2 - botaoLojaRestaura.size.height/2 - 10)
        botaoLojaRestaura.zPosition = 2
        
        self.addChild(botaoLojaRestaura)
    }
    
    func setupBotaoSair() {
        botaoSair = SKSpriteNode(imageNamed: "botaoSair")
        botaoSair.texture?.filteringMode = .nearest
        botaoSair.setScale(2.3)
        botaoSair.position = CGPoint(x: self.size.width/2, y: botaoLojaRestaura.position.y - botaoLojaRestaura.size.height/2 - botaoSair.size.height/2 - 10)
        botaoSair.zPosition = 2
        
        self.addChild(botaoSair)
    }
    
    func setupImagemFundo() {
        imagemFundo = SKSpriteNode(imageNamed: "bgAbout")
        imagemFundo.texture?.filteringMode = .nearest
        imagemFundo.zPosition = 0
        imagemFundo.size.width = self.size.width
        imagemFundo.size.height = self.size.height
        imagemFundo.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        
        self.addChild(imagemFundo)
    }
}

