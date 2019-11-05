//
//  MenuInicio.swift
//  FelPixApp
//  Created by Gabriel Jacinto


import SpriteKit
import UIKit

class MenuInicio: SKScene {

    // MARK: - Properties
    
    var imagemFundo: SKSpriteNode!
    var recordePontos: Int = 0
    var recordeDistancia: Int = 0
    
    // MARK: - Overrides
    
    override func didMove(to view: SKView) {
        setupScene()
        setupIamgemFundo()
        setupBotaoIniciar()
        setupBotaoRanking()
        setupsetupBotaoLoja()
        setupBotaoSobre()
        setupLabelRecorde()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let posicaoTocada: CGPoint! = touch.location(in: self)
            let objetoTocado = self.atPoint(posicaoTocada)
            
            if objetoTocado.name == "botaoIniciar" {
                print("Tocou botao iniciar!")
            }
            
            if objetoTocado.name == "botaoRanking" {
                print("Tocou botao Ranking!")
            }
            
            if objetoTocado.name == "botaoLoja" {
                print("Tocou botao Loja!")
            }
            
            if objetoTocado.name == "botaoSobre" {
                print("Tocou botao Sobre!")
            }
            
            //            else {
            //                print("Nao e botao iniciar. \( objetoTocado.name ?? "naoIndentificado")")
            //            }
        }
    }
    
    // MARK: - Methods
    
    func setupScene() {
        self.backgroundColor = UIColor.black
    }
    
    func setupIamgemFundo() {
        imagemFundo = SKSpriteNode(imageNamed: "bgIntro")
        imagemFundo.size.width = self.size.width
        imagemFundo.size.height = self.size.height
        imagemFundo.name = "imagemFundo"
        
        let imgemFundoX = self.size.width / 2
        let imgemFundoY = self.size.height / 2
        
        imagemFundo.texture?.filteringMode = .nearest
        imagemFundo.position = CGPoint(x: imgemFundoX, y: imgemFundoY)
        
        self.addChild(imagemFundo)
    }
    
    func setupBotaoIniciar() {
        let botao = SKSpriteNode(imageNamed: "botaoIniciar")
        botao.texture?.filteringMode = .nearest
        botao.position.y = -20
        botao.position.x = 400
        botao.setScale(2)
        botao.zPosition = 1
        botao.alpha = 0.2
        botao.name = "botaoIniciar"
        
        let animacaoEntra = SKAction.moveTo(x:0, duration: 0.75)
        let animacaoAlpha = SKAction.fadeAlpha(to: 1, duration: 0.25)
        let animationSequence = SKAction.sequence([animacaoEntra, animacaoAlpha])
        
        botao.run(animationSequence)
        
        imagemFundo.addChild(botao)
    }
    
    func setupBotaoRanking() {
        let botao = SKSpriteNode(imageNamed: "botaoRanking")
        botao.texture?.filteringMode = .nearest
        botao.position.y = -70
        botao.position.x = 400
        botao.setScale(2)
        botao.zPosition = 2
        botao.alpha = 0.2
        botao.name = "botaoRanking"
        
        let animacaoEntra = SKAction.moveTo(x:0, duration: 0.75)
        let animacaoAlpha = SKAction.fadeAlpha(to: 1, duration: 0.25)
        let animationSequence = SKAction.sequence([SKAction.wait(forDuration: 0.5), animacaoEntra, animacaoAlpha ])
        
        botao.run(animationSequence)
        
        imagemFundo.addChild(botao)
    }
    
    func setupsetupBotaoLoja() {
        let botao = SKSpriteNode(imageNamed: "botaoLoja")
        botao.texture?.filteringMode = .nearest
        botao.position.y = -120
        botao.position.x = 400
        botao.setScale(2)
        botao.zPosition = 3
        botao.alpha = 0.2
        botao.name = "botaoLoja"
        
        let animacaoEntra = SKAction.moveTo(x:0, duration: 0.75)
        let animacaoAlpha = SKAction.fadeAlpha(to: 1, duration: 0.25)
        let animationSequence = SKAction.sequence([SKAction.wait(forDuration: 1.0), animacaoEntra, animacaoAlpha ])
        botao.run(animationSequence)
        
        imagemFundo.addChild(botao)
    }
    
    func setupBotaoSobre() {
        let botao = SKSpriteNode(imageNamed: "botaoSobre")
        botao.texture?.filteringMode = .nearest
        botao.position.y = -170
        botao.position.x = 400
        botao.setScale(2)
        botao.zPosition = 4
        botao.alpha = 0.2
        botao.name = "botaoSobre"
        
        let animacaoEntra = SKAction.moveTo(x:0, duration: 0.75)
        let animacaoAlpha = SKAction.fadeAlpha(to: 1, duration: 0.25)
        let animationSequence = SKAction.sequence([SKAction.wait(forDuration: 1.5), animacaoEntra, animacaoAlpha ])
        
        botao.run(animationSequence)
        
        imagemFundo.addChild(botao)
    }
    
    func setupLabelRecorde() {
        let labelRecordes = SKLabelNode(fontNamed: "True Crimes")
        labelRecordes.fontSize = 17
        labelRecordes.text = "Recordes: \(recordePontos) pontos -\(recordeDistancia) metros"
        labelRecordes.position = CGPoint(x: self.size.width/2, y: self.size.height - 20)
        labelRecordes.zPosition = 2
        self.addChild(labelRecordes)
        
    }
}
