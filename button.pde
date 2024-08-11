class Button
{
  private int x;
  private int y;
  private int w;
  private int h;
  private Command c = Command.R;
  private String text = "";
  private boolean pressed = false;
  
  public Button()
  {
    x = 0;
    y = 0;
    w = 90;
    h = 40;
  }
  
  public Button(int x, int y, Command c, String text)
  {
    this.x = x;
    this.y = y;
    w = 90;
    h = 40;
    this.c = c;
    this.text = text;
  }
  
  public Button(int x, int y, int w, int h, Command c, String text)
  {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.c = c;
    this.text = text;
  }
  
  public boolean isMouseWithin()
  {
    if (mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h && text != "")
    {
      return true;
    }
    return false;
  }
  
  public Command getCommand()
  {
    return c;
  }
  
  public boolean isPressed()
  {
    return pressed;
  }
  
  public void display()
  {
    if (text != "")
    {
      stroke(pressed ? 200 : 100);
      fill(pressed ? 100 : 200);
      rect(x, y, w, h); // w90 h40
      fill(pressed ? 200 : 0);
      textAlign(CENTER);
      textSize((float)h * 0.75);
      text(text, x + (float)w / 2, y + (float)h * 0.75);
      pressed = false;
    }
  }
  
  public void toggle()
  {
    pressed = !pressed;
  }
}
