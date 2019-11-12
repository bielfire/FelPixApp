//
//  CenaJogo.swift
//  FelPixApp
//
//  Created by Gabriel Jacinto on 05/11/19.
//  Copyright © 2019 Gabriel Jacinto. All rights reserved.
//

import SpriteKit
import Foundation

class CenaJogo: SKScene, SKPhysicsContactDelegate {
    
    // MRK: - Properties
    
    var felpudo = SKSpriteNode()
    var _comecou: Bool = false
    var _acabou = false
    let objetoDummyMoveCena = SKNode()
    let grupoFelpudo: UInt32 = 1
    let grupoCano: UInt32 = 2
    let grupoMarcadores: UInt32 = 0
    var imagemFundo: SKSpriteNode = SKSpriteNode()
    
    // MARK: - Override
    
    override func didMove(to view: SKView) {
        self.backgroundColor = UIColor.black
        self.physicsWorld.contactDelegate = self
        
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
            
            felpudo.physicsBody?.categoryBitMask = grupoFelpudo
            felpudo.physicsBody?.contactTestBitMask = grupoCano
            felpudo.physicsBody?.collisionBitMask = grupoMarcadores
            
            _comecou = true
            _ = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(sorteiaObjetos), userInfo: nil, repeats: false)
            
        }
            
        else {
            felpudo.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            felpudo.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 150))
        }
    }
    
    override func update( _ currentTime: CFTimeInterval) {
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
    }
    @objc func sorteiaObjetos() {
        let sorteiaObjeto = Int(arc4random_uniform(2) + 1)
        if sorteiaObjeto == 1 {criaObjetoCanos()}
        if sorteiaObjeto == 2 {criaObjetoSemente()}
        _ = Timer.scheduledTimer(timeInterval: TimeInterval(3.5 / speed), target: self, selector: #selector(sorteiaObjetos), userInfo: nil, repeats: false)
        
    }
    @objc func criaObjetoCanos() {
        let vao = SKNode()
        let objetoCanoCima = SKSpriteNode(imageNamed: "canoCima")
        let objetoCanoBaixo = SKSpriteNode(imageNamed: "canoBaixo")
        
        let moveCano = SKAction.moveBy(x: -self.frame.size.width * 3, y: 0, duration: TimeInterval(4 / speed))
        let apagaCano = SKAction.removeFromParent()
        let sequenciaCano = SKAction.sequence([moveCano, apagaCano])
        let alturaVao = CGFloat(200)
        
        objetoCanoBaixo.setScale(3 * 0.75)
        objetoCanoCima.setScale(3 * 0.75)
        
        let numeroRandom = arc4random() % UInt32(100)
        let alturaRandom = CGFloat(numeroRandom) - 50
        
        objetoCanoBaixo.position.x = self.size.width + objetoCanoBaixo.size.width / 2 + 10
        objetoCanoBaixo.position.y = alturaRandom
        objetoCanoBaixo.texture!.filteringMode = .nearest
        objetoCanoBaixo.physicsBody = SKPhysicsBody(rectangleOf: objetoCanoBaixo.size)
        objetoCanoBaixo.physicsBody?.isDynamic = false
        objetoCanoBaixo.name = "cano"
        objetoCanoBaixo.run(sequenciaCano)
        
        objetoDummyMoveCena.addChild(objetoCanoBaixo)
        
        objetoCanoCima.position.x = objetoCanoBaixo.position.x
        objetoCanoCima.position.y = objetoCanoBaixo.position.y + objetoCanoCima.size.height + alturaVao
        objetoCanoCima.texture!.filteringMode = .nearest
        objetoCanoCima.physicsBody = SKPhysicsBody(rectangleOf: objetoCanoCima.size)
        objetoCanoCima.physicsBody?.isDynamic = false
        objetoCanoCima.name = "cano"
        objetoCanoCima.run(sequenciaCano)
        
        objetoDummyMoveCena.addChild(objetoCanoCima)
        
        vao.position.x = objetoCanoBaixo.position.x
        vao.position.y = objetoCanoBaixo.position.y + objetoCanoBaixo.size.height / 2 + alturaVao / 2
        vao.physicsBody = SKPhysicsBody(rectangleOf:CGSize(width: 3, height: self.size.height * 2))
        vao.physicsBody?.isDynamic = false
        vao.name = "vao"
        
        vao.physicsBody?.collisionBitMask = grupoMarcadores
        vao.physicsBody?.categoryBitMask = grupoMarcadores
        vao.physicsBody?.contactTestBitMask = grupoFelpudo
        
        vao.run(sequenciaCano)
        
        objetoDummyMoveCena.addChild(vao)
        
    }
    func criaObjetoSemente() {
        var itemSemente = SKSpriteNode (imageNamed: "semente1")
        let imagSeed1 = SKTexture(imageNamed: "semente1")
        let imagSeed2 = SKTexture(imageNamed: "semente2")
        let arrayImagensSemente: [SKTexture] = [imagSeed1, imagSeed2]
        let moveCano = SKAction.moveBy(x: -self.frame.size.width * 3, y: 0, duration: TimeInterval(4 / speed))
        let apagaCano = SKAction.removeFromParent()
        let sequenciaCano = SKAction.sequence([moveCano, apagaCano])
        
        itemSemente = SKSpriteNode(texture: imagSeed1)
        itemSemente.setScale(3 * 1.3)
        itemSemente.texture!.filteringMode = .nearest
        
        itemSemente.physicsBody = SKPhysicsBody(rectangleOf: itemSemente.size)
        itemSemente.physicsBody?.isDynamic = false
        itemSemente.physicsBody?.collisionBitMask = grupoMarcadores
        itemSemente.physicsBody?.categoryBitMask = grupoMarcadores
        itemSemente.physicsBody?.contactTestBitMask = grupoFelpudo
        itemSemente.name = "Semente"
        itemSemente.run(SKAction.repeatForever(SKAction.animate(withNormalTextures: arrayImagensSemente, timePerFrame: 0.35)))
        
        let objeParent = SKNode()
        let randomPosicaoItem = CGFloat(arc4random_uniform(100)) - 50
        objeParent.position.x = self.size.width + 100
        objeParent.position.y = self.size.height / 2 + randomPosicaoItem
        objeParent.run(sequenciaCano)
        objeParent.addChild(itemSemente)
        
        objetoDummyMoveCena.addChild(objeParent)
        
    }
    func didEnd(_ contact: SKPhysicsContact) {
        if contact.bodyA.categoryBitMask == grupoMarcadores || contact.bodyB.categoryBitMask == grupoMarcadores {
            if(contact.bodyA.node?.name == "vao") {
                contact.bodyA.node?.removeFromParent()
            }
        }
    }
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.categoryBitMask == grupoMarcadores || contact.bodyB.categoryBitMask == grupoMarcadores {
        }
        
        if (contact.bodyA.node?.name == "cano") {
            _acabou = true
            objetoDummyMoveCena.speed = 0
            imagemFundo.speed = 0
            felpudo.physicsBody?.applyImpulse(CGVector(dx: -300, dy: -50))
        }
    }
}
