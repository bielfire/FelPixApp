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
    var score: Int = 0
    var distanciaPercorrida: Int = 0
    var numeroItemEstrelas: Int = 0
    var numeroItemSementes: Int = 0
    var hudSemente = SKSpriteNode()
    var hudEstrela = SKSpriteNode()
    var sementesLabel = SKLabelNode()
    var estrelasLabel = SKLabelNode()
    var distanciaLabel = SKLabelNode()
    var scoreLabel = SKLabelNode()
    var textoInicio = SKLabelNode()
    var estadoInvisivel = false
    var estadoInvencivel = false
    let autoScaleAndRemoveAction = SKAction.sequence([SKAction.scale(to: 3.5, duration: 0.15), SKAction.removeFromParent()])
    let alphaAction = SKAction.fadeAlpha(by: 0, duration: 0.15)
    
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
        
        hudSemente = SKSpriteNode(imageNamed: "semente1")
        hudEstrela = SKSpriteNode(imageNamed: "estrela")
        
        hudSemente.name = "hudSemente"
        hudEstrela.name = "hudEstrela"
        
        hudEstrela.texture!.filteringMode = .nearest
        hudSemente.texture!.filteringMode = .nearest
        
        hudSemente.size.width = 85
        hudSemente.size.height = 85
        hudEstrela.size.width = 85
        hudEstrela.size.height = 85
        
        hudEstrela.position.x = self.size.width - hudEstrela.size.width / 2 - 10
        hudEstrela.position.y = hudEstrela.size.height / 2 + 10
        hudSemente.position.x = hudSemente.size.width / 2 + 10
        hudSemente.position.y = hudSemente.size.height / 2 + 10
        
        distanciaLabel = SKLabelNode()
        distanciaLabel.fontName = "True Crimes"
        distanciaLabel.fontSize = 17
        distanciaLabel.text = "Distancia: \(distanciaPercorrida) m."
        distanciaLabel.position.x = 10
        distanciaLabel.position.y = self.frame.size.height - 30
        distanciaLabel.horizontalAlignmentMode = .left
        distanciaLabel.zPosition = 11
        
        sementesLabel = SKLabelNode()
        sementesLabel.fontName = "True Crimes"
        sementesLabel.fontSize = 47
        sementesLabel.fontColor = UIColor.orange
        
        sementesLabel.text = "\(numeroItemSementes)"
        hudSemente.zPosition = 12
        hudEstrela.zPosition = 12
        
        sementesLabel.zPosition = 12
        
        estrelasLabel = SKLabelNode()
        estrelasLabel.fontName = "True Crimes"
        estrelasLabel.fontSize = 47
        estrelasLabel.fontColor = UIColor.black
        estrelasLabel.text = "\(numeroItemEstrelas)"
        estrelasLabel.zPosition = 12
        
        sementesLabel.position.y -= 21
        estrelasLabel.position.y -= 21
        
        sementesLabel.name = "Hud Semente"
        estrelasLabel.name = "Hud Estrela"
        
        scoreLabel = SKLabelNode()
        scoreLabel.fontName = "True Crimes"
        scoreLabel.fontSize = 130
        scoreLabel.text = "0"
        scoreLabel.position.x = self.frame.midX
        scoreLabel.position.y = self.frame.size.height - 140
        scoreLabel.alpha = 0.65
        scoreLabel.zPosition = 11
        scoreLabel.text = "\(score)"
        
        self.addChild(scoreLabel)
        self.addChild(hudSemente)
        self.addChild(hudEstrela)
        self.addChild(distanciaLabel)
        hudSemente.addChild(sementesLabel)
        hudEstrela.addChild(estrelasLabel)
        
        textoInicio = SKLabelNode()
        textoInicio.fontName = "True Crimes"
        textoInicio.fontSize = 25
        textoInicio.text = "Toque para Iniciar"
        textoInicio.position.x = self.frame.midX
        textoInicio.position.y = self.frame.size.height / 2 + 50
        textoInicio.alpha = 0.65
        textoInicio.zPosition = 11
        self.addChild(textoInicio)
        
        scoreLabel.isHidden = true
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: AnyObject in touches {
            let location: CGPoint! = touch.location(in: self)
            let nodeAtPoint = self.atPoint(location)
            
            if (nodeAtPoint.name == "botaoReplay") {
                self.removeAllActions()
                let reveal = SKTransition.flipHorizontal(withDuration: 1)
                let scene = CenaJogo(size: self.size)
                self.view?.presentScene(scene, transition:reveal)
            }
            if (nodeAtPoint.name == "botaoInicio") {
                self.removeAllActions()
                let reveal = SKTransition.doorsCloseVertical(withDuration: 1)
                let scene = MenuInicio(size: self.size)
                self.view?.presentScene(scene, transition:reveal)
            }
            if (nodeAtPoint.name == "hudSemente") {
                if ((numeroItemSementes > 0) && !_acabou) {
                    numeroItemSementes -= 1
                    sementesLabel.text = "\(numeroItemSementes)"
                    ficaInvisivelOn()
                }
            }
            if  (nodeAtPoint.name == "hudEstrela") {
                if ((numeroItemEstrelas > 0) && !_acabou) {
                    numeroItemEstrelas -= 1
                    estrelasLabel.text = "\(numeroItemEstrelas)"
                    ficaInvencivelOn()
                }
            }
        }
        
        if !_acabou {
            if !_comecou {
                felpudo.physicsBody = SKPhysicsBody(circleOfRadius: felpudo.size.height / 3)
                felpudo.physicsBody?.isDynamic = true
                felpudo.physicsBody?.allowsRotation = false
                felpudo.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                felpudo.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 60))
                
                felpudo.physicsBody?.categoryBitMask = grupoFelpudo
                felpudo.physicsBody?.contactTestBitMask = grupoCano
                felpudo.physicsBody?.collisionBitMask = grupoMarcadores
                
                textoInicio.isHidden = true
                scoreLabel.isHidden = false
                _comecou = true
                _ = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(sorteiaObjetos), userInfo: nil, repeats: false)
                _ = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(contaDistancia), userInfo: nil, repeats: true)
            }
            else {
                felpudo.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                felpudo.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 60))
            }
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
        let sorteiaObjeto = Int(arc4random_uniform(10) + 1)
        if sorteiaObjeto == 1 {criaObjetoCanos()}
        if sorteiaObjeto == 2 {criaObjetoSemente()}
        if sorteiaObjeto == 3 {criaObjetoEstrela()}
        if sorteiaObjeto == 4 {criaObjetoFlecha()}
        
        _ = Timer.scheduledTimer(timeInterval: TimeInterval(3.5 / speed), target: self, selector: #selector(sorteiaObjetos), userInfo: nil, repeats: false)
    }
    // @objc func sorteiaObjetos() {
    //let sorteiaObjeto = Int(arc4random_uniform(10) + 1)
    
    //  if sorteiaObjeto < 5 {criaObjetoCanos()}
    //    if (sorteiaObjeto >= 5) &&  (sorteiaObjeto < 9) {criaObjetoFlecha()}
    //      if sorteiaObjeto == 9 {criaObjetoEstrela()}
    //        if sorteiaObjeto == 10 {criaObjetoSemente()}
    
    //          _ = Timer.scheduledTimer(timeInterval: TimeInterval(3.5 / speed), target: self, selector: #selector(sorteiaObjetos), userInfo: nil, repeats: false)
    // }
    
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
    
    func criaObjetoEstrela() {
        let itemEstrela = SKSpriteNode (imageNamed: "estrela")
        let moveCano = SKAction.moveBy(x: -self.frame.size.width * 3, y: 0, duration: TimeInterval(4 / speed))
        let apagaCano = SKAction.removeFromParent()
        let sequenciaCano = SKAction.sequence([moveCano, apagaCano])
        
        itemEstrela.setScale(3 * 1.3)
        itemEstrela.texture!.filteringMode = .nearest
        
        itemEstrela.physicsBody = SKPhysicsBody(rectangleOf: itemEstrela.size)
        itemEstrela.physicsBody?.isDynamic = false
        itemEstrela.physicsBody?.collisionBitMask = grupoMarcadores
        itemEstrela.physicsBody?.categoryBitMask = grupoMarcadores
        itemEstrela.physicsBody?.contactTestBitMask = grupoFelpudo
        itemEstrela.name = "Estrela"
        
        let objeParent = SKNode()
        let randomPosicaoItem = CGFloat(arc4random_uniform(100)) - 50
        objeParent.position.x = self.size.width + 100
        objeParent.position.y = self.size.height / 2 + randomPosicaoItem
        objeParent.run(sequenciaCano)
        objeParent.addChild(itemEstrela)
        
        objetoDummyMoveCena.addChild(objeParent)
    }
    
    func criaObjetoFlecha() {
        let itemFlecha = SKSpriteNode (imageNamed: "flecha")
        let moveCano = SKAction.moveBy(x: -self.size.width * 2, y: 0, duration: TimeInterval(2 / speed))
        let apagaCano = SKAction.removeFromParent()
        let sequenciaCano = SKAction.sequence([moveCano, apagaCano])
        
        itemFlecha.setScale(3 * 1.3)
        itemFlecha.texture!.filteringMode = .nearest
        
        itemFlecha.physicsBody = SKPhysicsBody(rectangleOf: itemFlecha.size)
        itemFlecha.physicsBody?.isDynamic = false
        itemFlecha.physicsBody?.collisionBitMask = grupoMarcadores
        itemFlecha.physicsBody?.categoryBitMask = grupoMarcadores
        itemFlecha.physicsBody?.contactTestBitMask = grupoFelpudo
        itemFlecha.name = "cano"
        
        let objeParent = SKNode()
        let randomPosicaoItem = CGFloat(arc4random_uniform(100)) - 50
        objeParent.position.x = self.size.width + 100
        objeParent.position.y = self.size.height / 2 + randomPosicaoItem
        objeParent.run(sequenciaCano)
        objeParent.addChild(itemFlecha)
        
        objetoDummyMoveCena.addChild(objeParent)
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        if !_acabou {
            if contact.bodyA.categoryBitMask == grupoMarcadores || contact.bodyB.categoryBitMask == grupoMarcadores {
                if(contact.bodyA.node?.name == "vao") {
                    score += 1
                    contact.bodyA.node?.removeFromParent()
                }
                scoreLabel.text = "\(score)"
            }
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.categoryBitMask == grupoMarcadores || contact.bodyB.categoryBitMask == grupoMarcadores {}
        
        let bodyANode = contact.bodyA.node
        
        if ((bodyANode?.name == "cano") && !estadoInvencivel && !estadoInvisivel) {
            
            _ = Timer.scheduledTimer(timeInterval: TimeInterval(1), target: self, selector: #selector(botoesGameOver), userInfo: nil, repeats: false)
            _acabou = true
            objetoDummyMoveCena.speed = 0
            imagemFundo.speed = 0
            felpudo.physicsBody?.applyImpulse(CGVector(dx: -100, dy: 0))
        }
        
        if(bodyANode?.name == "Semente") {
            numeroItemSementes += 1
            sementesLabel.text = "\(numeroItemSementes)"
            
            self.criaFumacinha(objetoPos: bodyANode!.parent!.position)
            bodyANode?.removeFromParent()
        }
        
        if(bodyANode?.name == "Estrela") {
            numeroItemEstrelas += 1
            estrelasLabel.text = "\(numeroItemEstrelas)"
            
            self.criaFumacinha(objetoPos: bodyANode!.parent!.position)
            bodyANode?.removeFromParent()
        }
    }
    
    //func criaFumacinha(objeto: SKNode) {
    func criaFumacinha(objetoPos: CGPoint) {
        let fumacinha = SKSpriteNode(imageNamed: "fumacinha")
        //fumacinha.position = objeto.position
        fumacinha.position = objetoPos
        fumacinha.run(autoScaleAndRemoveAction)
        fumacinha.run(alphaAction)
        fumacinha.texture!.filteringMode = .nearest
        fumacinha.zPosition = 20
        objetoDummyMoveCena.addChild(fumacinha)
    }
    
    @objc func contaDistancia() {
        if !_acabou {
            distanciaPercorrida += 1
            distanciaLabel.text = "Metros: \(distanciaPercorrida)"
        }
    }
    
    @objc func botoesGameOver() {
        
        var botaoInicio: SKSpriteNode = SKSpriteNode()
        var botaoReplay: SKSpriteNode = SKSpriteNode()
        botaoInicio = SKSpriteNode(imageNamed: "botaoSair")
        botaoInicio.texture!.filteringMode = .nearest
        botaoInicio.setScale(3)
        botaoInicio.position.x = self.size.width / 2
        botaoInicio.position.y = self.size.height / 2 - 30
        botaoInicio.name = "botaoInicio"
        
        botaoReplay = SKSpriteNode(imageNamed: "botaoReplay")
        botaoReplay.texture!.filteringMode = .nearest
        botaoReplay.setScale(3)
        botaoReplay.position.x = self.size.width / 2
        botaoReplay.position.y = self.size.height / 2 + 50
        botaoReplay.name = "botaoReplay"
        botaoInicio.position.x += 400
        botaoReplay.position.x += 400
        botaoInicio.zPosition = 12
        botaoReplay.zPosition = 12
        
        let acaoEntraBotao = SKAction.moveBy(x: -400, y: 0, duration: 0.5)
        botaoReplay.run(SKAction.sequence([SKAction.wait(forDuration: 0.1), acaoEntraBotao]))
        botaoInicio.run(SKAction.sequence([SKAction.wait(forDuration: 0.5), acaoEntraBotao]))
        
        self.addChild(botaoReplay)
        self.addChild(botaoInicio)
    }
    func ficaInvencivelOn() {
        if !estadoInvencivel {
            estadoInvencivel = true
            _ = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(ficaInvencivelOff), userInfo: nil, repeats: false)
            self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
            felpudo.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            apagaBotoesHud()
            self.backgroundColor = UIColor.white
            physicsWorld.speed = 2
            speed = 2
        }
    }
    @objc func ficaInvencivelOff() {
        if estadoInvencivel {
            estadoInvencivel = false
            felpudo.run(SKAction.sequence([SKAction.fadeAlpha(to: 1, duration: 0.5), SKAction.wait(forDuration: 0.5), SKAction.run( { () -> Void in})]))
            acendeBotoesHud()
            self.physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
            felpudo.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            felpudo.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 150))
            physicsWorld.speed = 1
            speed = 1
            self.backgroundColor = UIColor.black
        }
    }
    func ficaInvisivelOn() {
        if !estadoInvisivel {
            estadoInvisivel = true
            _ = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(ficaInvisivelOff), userInfo: nil, repeats: false)
            felpudo.run(SKAction.fadeAlpha(by: 0.25, duration: 0.5))
            apagaBotoesHud()
        }
    }
    @objc func ficaInvisivelOff() {
        if estadoInvisivel {
            felpudo.run(SKAction.sequence([SKAction.fadeAlpha(to: 1, duration: 0.5), SKAction.wait(forDuration: 0.5), SKAction.run({ () -> Void in self.estadoInvisivel = false
                self.acendeBotoesHud()
            })]))
        }
    }
    func apagaBotoesHud() {
        hudSemente.run(SKAction.fadeAlpha(to: 0.15, duration: 0.5))
        sementesLabel.run(SKAction.fadeAlpha(to: 0.15, duration: 0.5))
        
        hudEstrela.run(SKAction.fadeAlpha(to: 0.15, duration: 0.5))
        estrelasLabel.run(SKAction.fadeAlpha(to: 0.15, duration: 0.5))
        
        hudEstrela.name = "xxx"
        hudSemente.name = "xxx"
        sementesLabel.name = "xxx"
        estrelasLabel.name = "xxx"
    }
    func acendeBotoesHud() {
        hudSemente.run(SKAction.fadeAlpha(to: 1, duration: 0.5))
        sementesLabel.run(SKAction.fadeAlpha(to: 1, duration: 0.5))
        
        hudEstrela.run(SKAction.fadeAlpha(to: 1, duration: 0.5))
        estrelasLabel.run(SKAction.fadeAlpha(to: 1, duration: 0.5))
        
        hudEstrela.name = "hudEstrela"
        hudSemente.name = "hudSemente"
        sementesLabel.name = "hudSemente"
        estrelasLabel.name = "hudEstrela"
        
    }
}

