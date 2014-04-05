class MyScene < SKScene

  NAME_CATEGORY_BALL        = 'ball'.freeze
  NAME_CATEGORY_PADDLE      = 'paddle'.freeze
  NAME_CATEGORY_BLOCK       = 'block'.freeze
  NAME_CATEGORY_BLOCK_NODE  = 'blockNode'.freeze

  attr_accessor :is_finger_on_paddle

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


    paddle = SKSpriteNode.alloc.initWithImageNamed("paddle")
    paddle.name = NAME_CATEGORY_PADDLE
    paddle.position = CGPointMake(CGRectGetMidX(self.frame), paddle.frame.size.height * 0.6)
    self.addChild(paddle)
    paddle.physicsBody = SKPhysicsBody.bodyWithRectangleOfSize(paddle.frame.size).tap do |body|
      body.restitution = 0.1
      body.friction = 0.4
      body.dynamic = false  # make physicsBody static
    end

    self
  end

  def touchesBegan(touches, withEvent: event)
    # Called when a touch begins
    touch = touches.anyObject
    touch_location = touch.locationInNode(self)

    body = self.physicsWorld.bodyAtPoint(touch_location)
    if body && body.node.name == NAME_CATEGORY_PADDLE
      puts "Began touch on paddle"
      is_finger_on_paddle = true
    end
  end

  def touchesMoved(touches, withEvent: event)
    # 1 Check whether user tapped paddle
    return unless is_finger_on_paddle

    # 2 Get touch location
    touch = touches.anyObject
    touch_location = touch.locationInNode(self)
    previous_location = touch.previousLocationInNode(self)
    # 3 Get node for paddle
    paddle = self.childNodeWithName(NAME_CATEGORY_PADDLE)
    # 4 Calculate new position along x for paddle
    paddle_x = paddle.position.x + (touch_location.x - previous_location.x)
    # 5 Limit x so that the paddle will not leave the screen to left or right
    paddle_x = [paddle_x, paddle.size.width / 2].max
    paddle_x = [paddle_x, self.size.width - paddle.size.width / 2].min
    # 6 Update position of paddle
    paddle.position = CGPointMake(paddle_x, paddle.position.y)
  end

  def touchesEnded(touches, withEvent: event)
    is_finger_on_paddle = false
  end

  def update(current_time)
    # Called before each frame is rendered
  end
end
