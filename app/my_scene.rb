class MyScene < SKScene

  NAME_CATEGORY_BALL        = 'ball'.freeze
  NAME_CATEGORY_PADDLE      = 'paddle'.freeze
  NAME_CATEGORY_BLOCK       = 'block'.freeze
  NAME_CATEGORY_BLOCK_NODE  = 'blockNode'.freeze

  def initWithSize(size)
    super

    background = SKSpriteNode.spriteNodeWithImageNamed("backgrounds/bg")
    background.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2)
    self.addChild(background)

    self.physicsWorld.gravity = CGVectorMake(0.0, 0.0)

    # 1. Create a physics body that borders the screen
    border_body = SKPhysicsBody.bodyWithEdgeLoopFromRect(self.frame)
    # 2. Set physicsBody of scene to border_body
    self.physicsBody = border_body
    # 3. Set the fritction of that physicsBody to 0
    self.physicsBody.friction = 0.0

    # 1
    ball = SKSpriteNode.spriteNodeWithImageNamed("ball")
    ball.name = NAME_CATEGORY_BALL
    ball.position = CGPointMake(self.frame.size.width / 3, self.frame.size.height / 3)
    self.addChild(ball)

    # 2
    ball.physicsBody = SKPhysicsBody.bodyWithCircleOfRadius(ball.frame.size.width / 2).tap do |body|
      body.friction = 0.0         # 3
      body.restitution = 1.0      # 4
      body.linearDamping = 0.0    # 5
      body.allowsRotation = false # 6
    end

    ball.physicsBody.applyImpulse(CGVectorMake(10.0, -10.0))

    self
  end

  def update(current_time)
    # Called before each frame is rendered
  end
end
