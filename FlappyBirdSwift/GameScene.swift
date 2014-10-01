//
//  GameScene.swift
//  FlappyBirdSwift
//
//  Created by Oscar Calles on 30/09/14.
//  Copyright (c) 2014 Oscar Calles. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var bird = SKSpriteNode()
    var pipeUpTexture = SKTexture()
    var pipeDownTexture = SKTexture()
    var PipesMoveAndRemove = SKAction()
    var sunTexture = SKTexture()
    var sunsMoveAndRemove = SKAction()
    
    // Parameters
    let pipeGap = 150.0
    let sunGap = 150.0
    //let velocityOfSuns = 0.01
    // random number (1-6) for sequence of pickup objects
    var numberOfObjectsToPick = arc4random_uniform(6) + 1

    


    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */

        //Physics
        self.physicsWorld.gravity = CGVectorMake(0.0, -5.0)
        
        // Bird
        var BirdTexture = SKTexture(imageNamed:"Bird")
        BirdTexture.filteringMode = SKTextureFilteringMode.Nearest
        
        bird = SKSpriteNode(texture: BirdTexture)
        bird.setScale(0.5)
        bird.position = CGPoint(x:self.frame.size.width * 0.35, y:self.frame.size.height * 0.6)
        
        bird.physicsBody = SKPhysicsBody(circleOfRadius: bird.size.height/2.0)
        bird.physicsBody?.dynamic = true
        bird.physicsBody?.allowsRotation = false
        
        self.addChild(bird)
        
        // Ground
        var groundTexture = SKTexture(imageNamed: "ground")
        var sprite = SKSpriteNode(texture: groundTexture)
        sprite.setScale(2.0)
        sprite.position = CGPointMake(self.size.width/2.0, sprite.size.height/2.0)
        self.addChild(sprite)
        
        var ground = SKNode()
        ground.position = CGPointMake(0, groundTexture.size().height)
        ground.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(self.frame.size.width, groundTexture.size().height * 2.0))
        ground.physicsBody?.dynamic = false
        self.addChild(ground)
        
        // Pipes
/*
        //Create the Pipes
        
        pipeUpTexture = SKTexture(imageNamed: "pipeUp2")
        pipeDownTexture = SKTexture(imageNamed: "pipeDown2")
        
        // Movements of pipes
        let distanceToMove = CGFloat(self.frame.size.width + 2.0 * pipeUpTexture.size().width)
        let movePipes = SKAction.moveByX(-distanceToMove, y: 0.0, duration: NSTimeInterval(0.01 * distanceToMove))
        let removePipes = SKAction.removeFromParent()
        
        PipesMoveAndRemove = SKAction.sequence([movePipes, removePipes])
        
        // Spawn pipes
        let spawn = SKAction.runBlock({() in self.spawnPipes()})
        let delay = SKAction.waitForDuration(NSTimeInterval(2.0))
        let spawnThenDelay = SKAction.sequence([spawn, delay])
        let spawnThenDelayForEver = SKAction.repeatActionForever(spawnThenDelay)
        self.runAction(spawnThenDelayForEver)
*/
        
        //Good Objects to pickup with sounds
        
        // Create
        sunTexture = SKTexture(imageNamed: "sun")
        
        // Movements of suns
        let distanceToMove2 = CGFloat(self.frame.size.width + 2.0 * sunTexture.size().width)
        let moveSuns = SKAction.moveByX(-distanceToMove2, y: 0.0, duration: NSTimeInterval(0.01 * distanceToMove2))
        let removeSuns = SKAction.removeFromParent()

        sunsMoveAndRemove = SKAction.sequence([moveSuns, removeSuns])
        
        // Spawn suns
        let spawn2 = SKAction.runBlock({() in self.spawnSuns()})
        let delay2 = SKAction.waitForDuration(NSTimeInterval(0.5))
        let spawnThenDelay2 = SKAction.sequence([spawn2, delay2])
        var numberOfObjectsToPick = (Int)(arc4random_uniform(6) + 1)
        let spawnThenDelayRandomTimes = SKAction.repeatAction(spawnThenDelay2, count:numberOfObjectsToPick)
        let andPause = SKAction.waitForDuration(NSTimeInterval(3))
        let spawnThenDelayRandomTimesAndPause = SKAction.sequence([spawnThenDelayRandomTimes, andPause])
        let spawnThenDelayRandomTimesAndPauseForever = SKAction.repeatActionForever(spawnThenDelayRandomTimesAndPause)
        
        
        self.runAction(spawnThenDelayRandomTimesAndPauseForever)
        
        
    }
    
    func spawnPipes() {
        
        let pipePair = SKNode()
        pipePair.position = CGPointMake(self.frame.size.width + pipeUpTexture.size().width * 2 ,0)
        pipePair.zPosition = -10
        
        let height = UInt32(self.frame.size.height / 4 )
        let y = arc4random() % height + height
        
        let pipeDown = SKSpriteNode(texture: pipeDownTexture)
        pipeDown.setScale(2.0)
        pipeDown.position = CGPointMake(0.0, CGFloat(y) + pipeDown.size.height + CGFloat(pipeGap))
        
        pipeDown.physicsBody = SKPhysicsBody(rectangleOfSize: pipeDown.size)
        pipeDown.physicsBody?.dynamic = false
        pipePair.addChild(pipeDown)
        
        let pipeUp = SKSpriteNode(texture: pipeUpTexture)
        pipeUp.setScale(2.0)
        pipeUp.position = CGPointMake(0.0, CGFloat(y))
        
        pipeUp.physicsBody = SKPhysicsBody(rectangleOfSize: pipeUp.size)
        pipeUp.physicsBody?.dynamic = false
        pipePair.addChild(pipeUp)
        
        pipePair.runAction(PipesMoveAndRemove)
        self.addChild(pipePair)
        
        
    
    }
    
    func spawnSuns(){
        let sunPair = SKNode()
        sunPair.position = CGPointMake(self.frame.size.width + sunTexture.size().width * 2 ,0)
        sunPair.zPosition = -10
        
        let height = UInt32(self.frame.size.height / 3 )
        let y = arc4random() % height + height
        
        let sunDown = SKSpriteNode(texture: sunTexture)
        sunDown.setScale(0.4)
        sunDown.position = CGPointMake(0.0, CGFloat(y) + sunDown.size.height + CGFloat(sunGap))
        
        sunDown.physicsBody = SKPhysicsBody(rectangleOfSize: sunDown.size)
        sunDown.physicsBody?.dynamic = false
        sunPair.addChild(sunDown)
        
        let sunUp = SKSpriteNode(texture: sunTexture)
        sunUp.setScale(0.4)
        sunUp.position = CGPointMake(0.0, CGFloat(y))
        
        sunUp.physicsBody = SKPhysicsBody(rectangleOfSize: sunUp.size)
        sunUp.physicsBody?.dynamic = false
        sunPair.addChild(sunUp)
        
        sunPair.runAction(sunsMoveAndRemove)
        self.addChild(sunPair)
        
        
        
    }
    
    
    
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            
            bird.physicsBody?.velocity = CGVectorMake(0, 0)
            bird.physicsBody?.applyImpulse(CGVectorMake(0, 25))
            
            
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
