// CUSTOM MOUSE CLICKING TOOL
boolean mouseChoose = false;
void mouseReleased() {
  mouseChoose = true;
  // set to false at the end of drawing phase
}

// GAME STUFF
int goingTo = 11;
boolean winByTwo = true;
boolean gameOver = false;
boolean rightTurn = true; // right is first
int rightScore = 0;
int leftScore = 0;
int serve = 2;
String victoryText = "";

// BUTTONS
enum Command {r, l, R, S, dGT, uGT, tWB};
int buttonAmount = 7;
// reset, swap, left score, right score, decrease goingTo, increase goingTo, toggle winByTwo
int[] ws = {90, 90, 350, 350, 20, 20, 70};
int[] hs = {40, 40, 60, 60, 20, 20, 30};
int[] xs = {500 - (int)((float)ws[0] / 2), 500 - (int)((float)ws[1] / 2), 500 - ws[2], 500, 35, 55, 910};
int[] ys = {0, hs[0], 350 - (int)((float)hs[2] / 2), 350 - (int)((float)hs[3] / 2), 25, 25, 30};
Command[] cs = {Command.R, Command.S, Command.l, Command.r, Command.dGT, Command.uGT, Command.tWB};
String[] labels = {"Reset", "Swap", "Left Team Score", "Right Team Score", "-", "+", "Toggle"};
Button[] buttons = {new Button(), new Button(), new Button(), new Button(), new Button(), new Button(), new Button()};

void setup()
{
  size(1000, 700);
  for (int i = 0; i < buttonAmount; i++)
  {
    buttons[i] = new Button(xs[i], ys[i], ws[i], hs[i], cs[i], labels[i]);
  }
}

void draw()
{
  background(255);
  
  if (!gameOver)
  {
    if (mousePressed)
    {
      for (int i = 0; i < buttonAmount; i++)
      {
        if (buttons[i].isMouseWithin() && !buttons[i].isPressed())
        {
          buttons[i].toggle();
        }
      }
    }
    if (mouseChoose)
    {
      for (int i = 0; i < buttonAmount; i++)
      {
        if (buttons[i].isMouseWithin())
        {
          // reset game
          if (buttons[i].getCommand() == Command.R)
          {
            rightTurn = true; // right is first
            rightScore = 0;
            leftScore = 0;
            serve = 2;
            buttons[1] = new Button(xs[1], ys[1], ws[1], hs[1], cs[1], labels[1]);
            buttons[4] = new Button(xs[4], ys[4], ws[4], hs[4], cs[4], labels[4]);
            buttons[5] = new Button(xs[5], ys[5], ws[5], hs[5], cs[5], labels[5]);
            buttons[6] = new Button(xs[6], ys[6], ws[6], hs[6], cs[6], labels[6]);
          }
          // swap
          else if (buttons[i].getCommand() == Command.S)
          {
            rightTurn = !rightTurn;
          }
          // left scored
          else if (buttons[i].getCommand() == Command.l)
          {
            if (!rightTurn)
            {
              leftScore++;
              if (leftScore >= goingTo && leftScore > rightScore + (winByTwo ? 1 : 0))
              {
                gameOver = true;
                victoryText = "Left Wins!";
              }
            }
            else
            {
              serve++;
              if (serve == 3)
              {
                serve = 1;
                rightTurn = false;
              }
            }
            buttons[1] = new Button();
            buttons[4] = new Button();
            buttons[5] = new Button();
            buttons[6] = new Button();
          }
          // right scored
          else if (buttons[i].getCommand() == Command.r)
          {
            if (rightTurn)
            {
              rightScore++;
              if (rightScore >= goingTo && rightScore > leftScore + (winByTwo ? 1 : 0))
              {
                gameOver = true;
                victoryText = "Right Wins!";
              }
            }
            else
            {
              serve++;
              if (serve == 3)
              {
                serve = 1;
                rightTurn = true;
              }
            }
            buttons[1] = new Button();
            buttons[4] = new Button();
            buttons[5] = new Button();
            buttons[6] = new Button();
          }
          // decrease goingTo
          else if(buttons[i].getCommand() == Command.dGT)
          {
            if (goingTo > 7)
              goingTo--;
          }
          // increase goingTo
          else if(buttons[i].getCommand() == Command.uGT)
          {
            goingTo++;
          }
          // toggle winByTwo
          else if(buttons[i].getCommand() == Command.tWB)
          {
            winByTwo = !winByTwo;
          }
        }
      }
    }
  }
  else
  {
    if (mousePressed)
    {
      for (int i = 0; i < buttonAmount; i++)
      {
        if (buttons[i].isMouseWithin() && !buttons[i].isPressed() && buttons[i].getCommand() == Command.R)
        {
          buttons[i].toggle();
        }
      }
    }
    if (mouseChoose)
    {
      for (int i = 0; i < buttonAmount; i++)
      {
        if (buttons[i].isMouseWithin())
        {
          // reset game
          if (buttons[i].getCommand() == Command.R)
          {
            gameOver = false;
            rightTurn = true; // right is first
            rightScore = 0;
            leftScore = 0;
            serve = 2;
            buttons[1] = new Button(xs[1], ys[1], ws[1], hs[1], cs[1], labels[1]);
            buttons[4] = new Button(xs[4], ys[4], ws[4], hs[4], cs[4], labels[4]);
            buttons[5] = new Button(xs[5], ys[5], ws[5], hs[5], cs[5], labels[5]);
            buttons[6] = new Button(xs[6], ys[6], ws[6], hs[6], cs[6], labels[6]);
          }
        }
      }
    }
  }
  
  // LABELS AND SUCH
  // turn indicator
  noStroke();
  fill(200, 255, 200);
  rect(rightTurn ? 500 : 0, 0, 500, 700);
  for (float w = 1; w < 56; w+=0.5)
  {
    fill(w + 200, 255, w + 200);
    ellipse(500, 350, 500 - w * 2, 700 - w * 2);
  }
  fill(255);
  rect(rightTurn ? 0 : 500, 0, 500, 700);
  
  // dashboard
  textAlign(CENTER);
  textSize(50);
  fill(0);
  text(leftScore, 250, 200);
  text(rightScore, 750, 200);
  text(serve, 500, 600);
  if (gameOver)
  {
    text(victoryText, 500, 300);
  }
  
  textSize(20);
  textAlign(LEFT);
  text("Going to " + goingTo, 10, 20);
  textAlign(RIGHT);
  text("Win by " + (winByTwo ? "two" : "one"), 990, 20);
  textAlign(CENTER);
  text("\"" + (rightTurn ? rightScore + " " + leftScore : leftScore + " " + rightScore) + " " + serve + "\"", 500, 670);
  
  for (int i = 0; i < buttonAmount; i++)
  {
    buttons[i].display();
  }
  
  mouseChoose = false;
}
