//
//  GameViewController.swift
//  FelPixApp
//
//  Created by Gabriel Jacinto on 22/10/19.
//  Copyright © 2019 Gabriel Jacinto. All rights reserved.
//

import UIKit
import SpriteKit

struct GameNotification {
    static let criarAlertPlayer = Notification.Name("funcaoCriarAlertPlayer")
}


var distanciaPercorrida: Int = 0
var recordePontos: Int = 0
var recordeDistancia: Int = 0
var numeroItemEstrelas: Int = 0
var numeroItemSementes: Int = 0
var comprouPlayerSombra: Bool = true
var playerSombraSelecionado: Bool = false
var somClica = SKAction.playSoundFileNamed("somClick.mp3", waitForCompletion: false)


class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let size = UIScreen.main.bounds.size
        let scene = MenuInicio(size: size)
        scene.scaleMode = .aspectFill
        
        let skView = self.view as! SKView
        skView.showsNodeCount = false
        skView.showsPhysics = true
        skView.ignoresSiblingOrder = true
        skView.presentScene(scene)
        
        SKTAudio.sharedInstance().playBackgroundMusic(filename: "musicaLoop.mp3")
        
        NotificationCenter.default.addObserver(self, selector: #selector(disparaAlertaSelectPlayer), name: GameNotification.criarAlertPlayer, object: nil)
    }
    
    @objc func iniciarCenaGame() {
        let transicao = SKTransition.doorway(withDuration: 1)
        let cena = CenaJogo(size: UIScreen.main.bounds.size)
        
        let skView = self.view as! SKView
        skView.showsNodeCount = false
        skView.showsPhysics = true
        skView.ignoresSiblingOrder = true
        skView.presentScene(cena, transition: transicao)
    }
    
    @objc func disparaAlertaSelectPlayer(notification: NSNotification) {
        let alertController = UIAlertController(title: "Escolha seu Player", message: "Selecione um Jogador", preferredStyle: .actionSheet)
        let acaoA = UIAlertAction(title: "felpudo", style: UIAlertAction.Style.default) {
            UIAlertAction in
            
            playerSombraSelecionado = false
            self.iniciarCenaGame()
        }
        
        let acaoB = UIAlertAction(title: "sombra", style: UIAlertAction.Style.default) {
            UIAlertAction in
            
            playerSombraSelecionado = true
            self.iniciarCenaGame()
        }
        
        let acaoC = UIAlertAction(title:"cancelar", style:UIAlertAction.Style.cancel ) {
            UIAlertAction in
        }
        
        alertController.addAction(acaoA)
        alertController.addAction(acaoB)
        alertController.addAction(acaoC)
        
        self.present(alertController, animated:true, completion:nil)
    }
    
    
    
    //override func shoudAutorotate() -> Bool {
    //        return true
    
    //    }
    //override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
    //    if UIDevice.current.userInterfaceIdiom == .phone {
    //        return .allButUpsideDown
    //    } else {
    //            return .all
    //        }
    //
    //}
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}


