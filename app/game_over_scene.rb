class GameOverScene < SKScene

  alias_method :super_initWithSize, :initWithSize

  def initWithSize(size, player_won: is_won)
    super_initWithSize(size)

    background = SKSpriteNode.spriteNodeWithImageNamed("backgrounds/bg")
    background.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2)
    self.addChild(background)

    # 1
    label = SKLabelNode.labelNodeWithFontNamed("Arial")
    label.fontSize = 42
    label.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
    label.text = is_won ? "Game Won" : "Game Over"
    self.addChild(label)

    self
  end

  def touchesBegan(touches, withEvent: event)
    breakout_game_scene = MyScene.alloc.initWithSize(self.size)
    # 2
    self.view.presentScene(breakout_game_scene)
  end

end
