class Keys
{
  private boolean wDown = false;
  private boolean aDown = false;
  private boolean sDown = false;
  private boolean dDown = false;
  private boolean upPressed = false;
  private boolean downPressed = false;
  private boolean leftPressed = false;
  private boolean rightPressed = false;
  
  public Keys(){}
  //player1 controlls
  public boolean wDown()
  {
    return wDown;
  }
  
  public boolean aDown()
  {
    return aDown;
  }
  
  public boolean sDown()
  {
    return sDown;
  }
  
  public boolean dDown()
  {
    return dDown;
  }
  
  
  //player2 controlls
  public boolean upPressed()
  {
    return upPressed;
  }
  
  public boolean downPressed()
  {
    return downPressed;
  }
  
  public boolean leftPressed()
  {
    return leftPressed;
  }
  
  public boolean rightPressed()
  {
    return rightPressed;
  }
  
  
  
  void onArrowPressed()
  {
    if(key == CODED)
    {
      if(keyCode == UP)
      {
        upPressed = true;
      }
      else if(keyCode == LEFT)
      {
        leftPressed = true;
      }
      else if(keyCode == DOWN)
      {
        downPressed = true;
      }
      else if(keyCode == RIGHT)
      {
        rightPressed = true;
      }
    }  
  }

  
  void onArrowReleased()
  {
    if(key == CODED)
    {
      if(keyCode == UP)
      {
        upPressed = false;
      }
      else if(keyCode == LEFT)
      {
        leftPressed = false;
      }
      else if(keyCode == DOWN)
      {
        downPressed = false;
      }
      else if(keyCode == RIGHT)
      {
        rightPressed = false;
      }
    }  
  }
  
  
  

  
  void onKeyPressed(char ch)
  {
    if(ch == 'W' || ch == 'w')
    {
      wDown = true;
    }
    else if (ch == 'A' || ch == 'a')
    {
      aDown = true;
    }
    else if(ch == 'S' || ch == 's')
    {
      sDown = true;
    }
    else if(ch == 'D' || ch == 'd')
    {
      dDown = true;
    }
  }
  
  void onKeyReleased(char ch)
  {
    if(ch == 'W' || ch == 'w')
    {
      wDown = false;
    }
    else if (ch == 'A' || ch == 'a')
    {
      aDown = false;
    }
    else if(ch == 'S' || ch == 's')
    {
      sDown = false;
    }
    else if(ch == 'D' || ch == 'd')
    {
      dDown = false;
    }
  }
}
