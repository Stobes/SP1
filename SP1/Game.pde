import java.util.Random;

class Game
{
  private Random rnd;
  private int width;
  private int height;
  private int[][] board;
  private Keys keys;
  private int player1Life;
  private int player2Life;
  private int maxLife;
  private Dot player1;
  private Dot player2;
  private Dot[] enemies;
  private Dot[] food;
  private boolean gameOver;


  Game(int width, int height, int numberOfEnemies, int numberOfFood)
  {
    if (width < 10 || height < 10)
    {
      throw new IllegalArgumentException("Width and height must be at least 10");
    }
    if (numberOfEnemies < 0)
    {
      throw new IllegalArgumentException("Number of enemies must be positive");
    } 
    if (numberOfFood < 2)
    {
      throw new IllegalArgumentException("Number of food must be at least 2");
    }
    this.rnd = new Random();
    this.board = new int[width][height];
    this.width = width;
    this.height = height;
    keys = new Keys();
    player1 = new Dot(0, 0, width-1, height-1);
    player2 = new Dot(1, 0, width-1, height-1);
    food = new Dot[numberOfFood];
    for (int i = 0; i < numberOfFood; ++i)
    {
      food[i] = new Dot((int)random(0, width-1), (int)random(0, height-1), width-1, height-1);
    }
    enemies = new Dot[numberOfEnemies];
    for (int i = 0; i < numberOfEnemies; ++i)
    {
      enemies[i] = new Dot(width-1, height-1, width-1, height-1);
    }
    this.player1Life = 100;
    this.player2Life = 100;
    this.maxLife = 100;
    this.gameOver = false;
  }


  public int getWidth()
  {
    return width;
  }

  public int getHeight()
  {
    return height;
  }

  //player life
  public int getPlayer1Life()
  {
    return player1Life;
  }
  
  public int getPlayer2Life()
  {
    return player2Life;
  }
  
  
  public void onKeyPressed(char ch)
  {
    keys.onKeyPressed(ch);
  }

  public void onKeyReleased(char ch)
  {
    keys.onKeyReleased(ch);
  }
  public void onArrowPressed()
  {
    keys.onArrowPressed();
  }
  public void onArrowReleased()
  {
    keys.onArrowReleased();
  }

  public void update()
  {
    checkGameOver();
    updatePlayer1();
    updatePlayer2();
    updateEnemies();
    updateFood();
    checkForCollisions();
    clearBoard();
    populateBoard();
  }



  public int[][] getBoard()
  {
    //ToDo: Defensive copy?
    return board;
  }

  private void clearBoard()
  {
    for (int y = 0; y < height; ++y)
    {
      for (int x = 0; x < width; ++x)
      {
        board[x][y]=0;
      }
    }
  }

  private void updatePlayer1()
  {
    //Update player1
    if (keys.wDown() && !keys.sDown())
    {
      player1.moveUp();
    }
    if (keys.aDown() && !keys.dDown())
    {
      player1.moveLeft();
    }
    if (keys.sDown() && !keys.wDown())
    {
      player1.moveDown();
    }
    if (keys.dDown() && !keys.aDown())
    {
      player1.moveRight();
    }
  }

  private void updatePlayer2()
  {
    //Update player2
    if (keys.upPressed() && !keys.downPressed())
    {
      player2.moveUp();
    }
    if (keys.leftPressed() && !keys.rightPressed())
    {
      player2.moveLeft();
    }
    if (keys.downPressed() && !keys.upPressed())
    {
      player2.moveDown();
    }
    if (keys.rightPressed() && !keys.leftPressed())
    {
      player2.moveRight();
    }
  }
  
  private boolean checkGameOver()
  {
    if(player1Life <= 0)
    {
      text("player1 life has reached 0, player2 wins!",2/width,2/height);
      board[player1.getX()][player1.getY()] = 0;
      noLoop();
      gameOver = true;
      return gameOver;
    }
    else if(player2Life <= 0)
    {
      text("player2 life has reached 0, player1 wins!",2/width,2/height); 
      board[player2.getX()][player2.getY()] = 0;
      noLoop();
      gameOver = true;
      return gameOver;
    }
    else
    {
      return gameOver;
    }
  }
  
  

  private void updateEnemies()
  {
    for (int i = 0; i < enemies.length; ++i)
    {
      //Should we follow or move randomly?
      //2 out of 3 we will follow..
      if (rnd.nextInt(3) < 2)
      {
        //We follow, but who?
        int dxp2 = player2.getX() - enemies[i].getX();
        int dyp2 = player2.getY() - enemies[i].getY();
        int dxp1 = player1.getX() - enemies[i].getX();
        int dyp1 = player1.getY() - enemies[i].getY();
        
        
        if(sqrt(sq(dxp1) + sq(dyp1)) < (sqrt(sq(dxp2) + sq(dyp2))))
        {
            if (abs(dxp1) > abs(dyp1))
            {
              if (dxp1 > 0)
              {
                //Player1 is to the right
                enemies[i].moveRight();
              } 
              else
              {
                //Player1 is to the left
                enemies[i].moveLeft();
              }
            } 
            else if (dyp1 > 0)
            {
              //Player1 is down;
              enemies[i].moveDown();
            } 
            else
            {//Player1 is up;
              enemies[i].moveUp();
            }
        }
        else
        {
          if (abs(dxp2) > abs(dyp2))
            {
              if (dxp2 > 0)
              {
                //Player2 is to the right
                enemies[i].moveRight();
              } 
              else
              {
                //Player2 is to the left
                enemies[i].moveLeft();
              }
            } 
            else if (dyp2 > 0)
            {
              //Player2 is down;
              enemies[i].moveDown();
            } 
            else
            {//Player2 is up;
              enemies[i].moveUp();
            }
        }
      }
     
      //We move randomly
      else
      {
        int move = rnd.nextInt(4);
        if (move == 0)
        {
          //Move right
          enemies[i].moveRight();
        } else if (move == 1)
        {
          //Move left
          enemies[i].moveLeft();
        } else if (move == 2)
        {
          //Move up
          enemies[i].moveUp();
        } else if (move == 3)
        {
          //Move down
          enemies[i].moveDown();
        }
      }
    }
  }


  private void updateFood()
  {
    for (int i = 0; i < food.length; ++i)
    {
      //Should we run or move randomly?
      //2 out of 3 we will run..
      if (rnd.nextInt(3) < 2)
      {
        //We run
        int dxp2 = player2.getX() - food[i].getX();
        int dyp2 = player2.getY() - food[i].getY();
        int dxp1 = player1.getX() - food[i].getX();
        int dyp1 = player1.getY() - food[i].getY();
        
        
        if(sqrt(sq(dxp1) + sq(dyp1)) < (sqrt(sq(dxp2) + sq(dyp2))))
        {
            if (abs(dxp1) > abs(dyp1))
            {
              if (dxp1 > 0)
              {
                //Player1 is to the right
                food[i].moveLeft();
              } 
              else
              {
                //Player1 is to the left
                food[i].moveRight();
              }
            } 
            else if (dyp1 > 0)
            {
              //Player1 is down;
              food[i].moveUp();
            } 
            else
            {//Player1 is up;
              food[i].moveDown();
            }
        }
        else
        {
          if (abs(dxp2) > abs(dyp2))
            {
              if (dxp2 > 0)
              {
                //Player2 is to the right
                food[i].moveLeft();
              } 
              else
              {
                //Player2 is to the left
                food[i].moveRight();
              }
            } 
            else if (dyp2 > 0)
            {
              //Player2 is down;
              food[i].moveUp();
            } 
            else
            {//Player2 is up;
              food[i].moveDown();
            }
        }
      } 
      else
      {
        //We move randomly
        int move = rnd.nextInt(4);
        if (move == 0)
        {
          //Move right
          food[i].moveRight();
        } else if (move == 1)
        {
          //Move left
          food[i].moveLeft();
        } else if (move == 2)
        {
          //Move up
          food[i].moveUp();
        } else if (move == 3)
        {
          //Move down
          food[i].moveDown();
        }
      }
    }
  }

  private void populateBoard()
  {
    //Insert player
    board[player1.getX()][player1.getY()] = 1;
    board[player2.getX()][player2.getY()] = 4;
    //Insert enemies
    for (int i = 0; i < enemies.length; ++i)
    {
      board[enemies[i].getX()][enemies[i].getY()] = 2;
    }
    //Insert Food
    for (int i = 0; i < food.length; ++i)
    {
      board[food[i].getX()][food[i].getY()] = 3;
    }
  }



  private void checkForCollisions()
  {
    //Check enemy collisions
    for (int i = 0; i < enemies.length; ++i)
    {
      if (enemies[i].getX() == player1.getX() && enemies[i].getY() == player1.getY())
      {
        //We have player1 collision
        --player1Life;
      }
      else if (enemies[i].getX() == player2.getX() && enemies[i].getY() == player2.getY())
      {
        //We have player2 collision
        --player2Life;
      }
    }
    //Check food collisions
    for (int i = 0; i < food.length; ++i)
    {
      if (food[i].getX() == player1.getX() && food[i].getY() == player1.getY())
      {
        food[i] = new Dot((int)random(0, width-1), (int)random(0, height-1), width-1, height-1);
        if (player1Life >= maxLife)
        {
          //We have player1 collision
          player1Life = 100;
        }
        else
        {
          player1Life += 5;
        }
      }
      else if (food[i].getX() == player2.getX() && food[i].getY() == player2.getY())
      {
        food[i] = new Dot((int)random(0, width-1), (int)random(0, height-1), width-1, height-1);
        if (player2Life >= maxLife)
        {
          //We have player2 collision
          player2Life = 100;
        }
        else
        {
          player2Life += 5;
        }
      }
    }
  }
}
