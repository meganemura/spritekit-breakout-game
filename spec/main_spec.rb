describe "Application 'spritekit-breakout-game'" do
  before do
    @app = UIApplication.sharedApplication
  end

  it "returns fun" do
    @app.should == :fun
  end
end
