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
    self
  end

  def update(current_time)
    # Called before each frame is rendered
  end
end
