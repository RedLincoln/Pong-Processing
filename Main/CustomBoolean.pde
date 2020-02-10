class CustomBoolean{
  private boolean state;
  
  public CustomBoolean(boolean state){
    this.state = state;
  }
  
  public CustomBoolean(){
    state = false;
  }
  
  public boolean getState(){
    return state;
  }
  
  public void setState(boolean state){
    this.state = state;
  }
}
