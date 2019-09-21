import java.util.Date;
int toolbarHeight = 125;
int headerHeight = 100;
int displayHeight = 1200;
int displayWidth = 700;
int currBranches = 0;
PImage[] images = new PImage[6];
PImage sprout;
PImage calendar;
PImage clipboard;
PImage checkmark;
String currWindow = "Tree";
int treeAnimationStart = 7;
PImage topLogo;
//Tom
String[] monthNames = {"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"};
int[]    monthDays  = {31,        28,         31,      30,      31,    30,     31,     31,       30,          31,        30,         31        };
String[] weekDays = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"};
ArrayList<MonthDay> holidays;
int currentMonth;
int currentYear;
float plannerWidth = 0;
float margin = 50;
float topLabelMargin = 100;
float calendarWidth = width - plannerWidth - (margin * 2);
float calendarHeight = height-500 - (margin * 2) - topLabelMargin;
float spacing = 5;
float publiconstant1;
float publiconstant2;

//KP
String[] mission = new String[5];
boolean[] taskCheck = new boolean[5];
Task[] currentTasks = new Task[5];

void setup(){
  size(700, 1200);
  topLogo = loadImage("top_logo.png");
  
  //Tree
  images[0] = loadImage("stage0.png");
  images[1] = loadImage("stage1.png");
  images[2] = loadImage("stage2.png");
  images[3] = loadImage("stage3.png");
  images[4] = loadImage("stage4.png");
  images[5] = loadImage("stage5.png");
  sprout = loadImage("sprout.png");
  checkmark = loadImage("checkmark.png");
  calendar = loadImage("calendar.png");
  clipboard = loadImage("clipboard.png");
  
  //TASKS
  mission[1] = "Vegetarian Day!";
  mission[2] = "Use Public Transport";
  mission[3] = "No plastic bag";
  mission[4] = "Shower in 10 minutes";
  mission[0] = "Unplug your devices";
  for (int i=0;i<=4;i++){
    currentTasks[i]=new Task(displayWidth/14,17*displayHeight/120+183*displayHeight*i/1200,mission[i]);
    
    
  //CALENDAR
  

  println(getoday());
  
  holidays = new ArrayList<MonthDay>();
  holidays.add(new Holiday("New Year's Day", 1, 1));
  holidays.add(new Holiday("Independence\nDay", 7, 4));
  holidays.add(new Holiday("Halloween", 10, 31));
  holidays.add(new Holiday("Veterans' Day", 11, 11));
  holidays.add(new Holiday("Christmas", 12, 25));
  holidays.add(new MonthDay() {
    public String getName() {return "Martin Luther\nKing Jr. Day";}
    public int getMonth() {return 1;}
    public int getDay() {return getDayInMonth(currentYear, currentMonth, 2, 3);}
  });
  holidays.add(new MonthDay() {
    public String getName() {return "Presidents' Day";}
    public int getMonth() {return 2;}
    public int getDay() {return getDayInMonth(currentYear, currentMonth, 2, 3);}
  });
  holidays.add(new MonthDay() {
    public String getName() {return "Mothers' Day";}
    public int getMonth() {return 5;}
    public int getDay() {return getDayInMonth(currentYear, currentMonth, 1, 2);}
  });
  holidays.add(new MonthDay() {
    public String getName() {return "Fathers' Day";}
    public int getMonth() {return 6;}
    public int getDay() {return getDayInMonth(currentYear, currentMonth, 1, 3);}
  });
  holidays.add(new MonthDay() {
    public String getName() {return "Memorial Day";}
    public int getMonth() {return 5;}
    public int getDay() {return lastDayInMonth(currentYear, currentMonth, 2);}
  });
  holidays.add(new MonthDay() {
    public String getName() {return "Labor Day";}
    public int getMonth() {return 9;}
    public int getDay() {return getDayInMonth(currentYear, currentMonth, 2, 1);}
  });
  holidays.add(new MonthDay() {
    public String getName() {return "Columbus Day";}
    public int getMonth() {return 10;}
    public int getDay() {return getDayInMonth(currentYear, currentMonth, 2, 2);}
  });
  holidays.add(new MonthDay() {
    public String getName() {return "Thanksgiving";}
    public int getMonth() {return 11;}
    public int getDay() {return getDayInMonth(currentYear, currentMonth, 5, 4);}
  });
  
  currentMonth = month() - 1;
  currentYear = year();
  }
  
}


void draw(){
  textAlign(LEFT);
  tint(255, 255);
  background(255, 248, 224);
  rectMode(CORNER);
  imageMode(CORNER);
  image(topLogo, 0, 25, 700, 100);
  fill(255);
  rect(0, displayHeight - toolbarHeight, 220, displayHeight);
  rect(220, displayHeight - toolbarHeight, 480, displayHeight);
  rect(480, displayHeight - toolbarHeight, 600, displayHeight);
  imageMode(CENTER);
  fill(0);
  image(sprout, 110, displayHeight - toolbarHeight/2, 100, 100); 
  image(clipboard, 350, displayHeight - toolbarHeight/2, 100, 100); 
  image(calendar, 590, displayHeight - toolbarHeight/2, 100, 100); 
  
  fill(255);
  rectMode(CORNER);
  switch(currWindow){
    case "Tree":
      drawTree();
      break;
    case "Tasks":
      drawTasks();
      break;
    case "Calendar":
      drawCalendar();
      break;
    }
     
  
  
}
void drawCalendar() {
  
  translate(0, 100);
  textFont(createFont("ArialMT-48", 12));
  textAlign(CENTER, CENTER);
  smooth();
  //Date Metrics
  String monthName = monthNames[currentMonth];
  int daysInMonth = int(monthDays[currentMonth]);
  if(currentMonth == 1 && isLeapYear(currentYear)) daysInMonth ++;
  int dayOfMonth = -1;
  int dayOfWeek = -1;
  String dayOfWeekName = "";

  if(currentMonth == month() - 1 && currentYear == year()) {
    dayOfMonth = day();
    dayOfWeek = int((new Date()).getDay());
    dayOfWeekName = weekDays[dayOfWeek];
  }

  Date date = new Date();
  date.setYear(currentYear);
  date.setMonth(currentMonth);
  date.setDate(1);
  int startingDayOfMonth = date.getDay(); //int(7 - (dayOfMonth % 7)); //NOT WORKING!
  String startingDayOfMonthName = weekDays[startingDayOfMonth];

  //Celendar Metrics
  int numRows = ceil((startingDayOfMonth + daysInMonth) / 7);
  margin = 50;
  topLabelMargin = 100;
  calendarWidth = width - plannerWidth - (margin * 2);
  calendarHeight = height-500 - (margin * 2) - topLabelMargin;
  spacing = 5;
  float boxWidth = (calendarWidth - (6 * spacing)) / 7;
  float boxHeight = (calendarHeight - ((numRows - 1) * spacing)) / (numRows+2);
  publiconstant1=boxWidth;
  publiconstant2=boxHeight;

  if(mouseInArrowRange()) {
    noStroke();

    if(mouseOverArrow(-1) || mouseOverArrow(-2)) fill(255);
    else fill(204);
    triangle((width - plannerWidth) / 2 - (width - plannerWidth) / 10 * 3.5, margin + topLabelMargin / 10 * 3, (width - plannerWidth) / 2 - (width - plannerWidth) / 10 * 3, margin + topLabelMargin / 10 * 2, (width - plannerWidth) / 2 - (width - plannerWidth) / 10 * 3, margin + topLabelMargin / 10 * 4);

    if(mouseOverArrow(1) || mouseOverArrow(2)) fill(255);
    else fill(204);
    triangle((width - plannerWidth) / 2 + (width - plannerWidth) / 10 * 3.5, margin + topLabelMargin / 10 * 3, (width - plannerWidth) / 2 + (width - plannerWidth) / 10 * 3, margin + topLabelMargin / 10 * 2, (width - plannerWidth) / 2 + (width - plannerWidth) / 10 * 3, margin + topLabelMargin / 10 * 4);

    if(mouseOverArrow(-2)) fill(255);
    else fill(204);
    triangle((width - plannerWidth) / 2 - (width - plannerWidth) / 10 * 4.1, margin + topLabelMargin / 10 * 3, (width - plannerWidth) / 2 - (width - plannerWidth) / 10 * 3.6, margin + topLabelMargin / 10 * 2, (width - plannerWidth) / 2 - (width - plannerWidth) / 10 * 3.6, margin + topLabelMargin / 10 * 4);

    if(mouseOverArrow(2)) fill(255);
    else fill(204);
    triangle((width - plannerWidth) / 2 + (width - plannerWidth) / 10 * 4.1, margin + topLabelMargin / 10 * 3, (width - plannerWidth) / 2 + (width - plannerWidth) / 10 * 3.6, margin + topLabelMargin / 10 * 2, (width - plannerWidth) / 2 + (width - plannerWidth) / 10 * 3.6, margin + topLabelMargin / 10 * 4);
  }

  fill(0);
  stroke(204);
  textSize(42);

  text(monthName + " " + currentYear, (width - plannerWidth) / 2, margin + topLabelMargin / 10 * 3);

  fill(0);
  textSize(12);

  for(int i = 0; i < weekDays.length; i ++)
    text(weekDays[i], margin + (spacing * i) + (boxWidth * i) + boxWidth / 2, margin + topLabelMargin / 10 * 7);

  line(margin, margin + topLabelMargin / 10 * 8.5, width - plannerWidth - margin, margin + topLabelMargin / 10 * 8.5);

  stroke(0);

  float xoff = startingDayOfMonth;
  float yoff = 0;
  for(int i = 0; i < daysInMonth; i ++) {
    String curDayOfWeekName = weekDays[int(xoff)];
    float x = margin + (spacing * xoff) + (boxWidth * xoff);
    float y = margin + topLabelMargin + (spacing * yoff) + (boxHeight * yoff);

    noStroke();
    fill(255);

    ellipse(x + 43, y + 43, boxWidth, boxHeight);

    stroke(0);
    if((i + 1) == dayOfMonth) fill(255);
    else fill(255);

    ellipse(x+40, y+40, boxWidth, boxHeight);

    fill(0);
    textSize(24);

    text(i + 1, x + boxWidth / 2, y + boxHeight / 2);

    textSize(9);

    float yH = 0;
    for(MonthDay holiday : holidays) {
      if(currentMonth + 1 == holiday.getMonth() && i + 1 == holiday.getDay()) {
        text(holiday.getName(), x + boxWidth / 2, y + boxHeight / 20 * 17 - (textAscent() + textAscent()) * yH);
        yH ++;
      }
    }

    xoff = (xoff + 1) % 7;
    if(xoff == 0) yoff ++;
  }

  if(!isToday()) {
    if(overTodayButton()) fill(255);
    else fill(204);
    textSize(12);

    text("Today", (width - plannerWidth) / 2, height-500 - margin / 2);

    if(mousePressed && overTodayButton()) goToToday();
  }

  noStroke();

  //if(overPlannerScroller() || pressedPlannerScroller) fill(255);
  //else fill(204);
  //
  //rect(width - plannerWidth - 10, margin + topLabelMargin + calendarHeight / 5, 10, calendarHeight / 5 * 3);

  if(plannerWidth > 50) {
    fill(51);

    ellipse(width - plannerWidth + 43, margin + topLabelMargin + 43, plannerWidth - margin, height-500 - margin * 2 - topLabelMargin);

    stroke(0);
    fill(204);

    ellipse(width - plannerWidth+40, margin + topLabelMargin+40, plannerWidth - margin, height-500 - margin * 2 - topLabelMargin);
  }
  //if(!mousePressed) pressedPlannerScroller = false;
  //if(pressedPlannerScroller) plannerWidth = constrain(width - mouseX, 0, 350);
  drawTasks(5);
  translate(0, -100);
}

void drawTree(){
  fill(255);
  if(treeAnimationStart < 255){
  treeAnimationStart += 8; 
  tint(255, treeAnimationStart);
  }
  imageMode(CENTER);
  image(images[currBranches], displayWidth/2, displayHeight-toolbarHeight - 850/2);
} 


void drawTasks(){
  for(int i=0; i<= 4; i++){
    currentTasks[i].draw();
 }
 
}

         
void keyPressed(){
  currWindow = "Tasks";
  
  
}

void switchWindow(String window){
  switch(window){
    case "Calendar":
      break;
    case "Tasks":
      break;
    case "Tree":
      treeAnimationStart = 0;
      break;
  }
  currWindow = window;
}

void onTaskCheck(){
  currBranches += 1;
  
  
  
}
  

void mouseReleased(){
  
  if(mouseY > displayHeight - toolbarHeight){
    if(mouseX > 220){
      if(mouseX > 480)
        switchWindow("Calendar");
      else
        switchWindow("Tasks");        
    }else
      switchWindow("Tree");
    return;
  }
  
  switch(currWindow){
    case "Tasks":
      for(Task t : currentTasks){
        if(t.coordsIn(mouseX, mouseY))
          onTaskCheck();}
      break;
    case "Tree":
      break;
    case "Calendar":
      if(mouseInArrowRange()) {
        if(mouseOverArrow(-2)) currentYear --;
        if(mouseOverArrow(-1)) {
          currentMonth --;
          if(currentMonth < 0) {
            currentYear --;
            currentMonth = 11;
          }
        }
        if(mouseOverArrow(1)) {
          currentMonth ++;
          if(currentMonth > 11) {
            currentYear ++;
            currentMonth = 0;
          }
        }
        if(mouseOverArrow(2)) currentYear ++;
      }
      break;  
  }
}


public class Task{
  int xPosition;
  int yPosition;
  boolean check = false;
  String thisMission;
  public Task(int mXPosition, int mYPosition, String mThisMission){
    xPosition = mXPosition;
    yPosition = mYPosition;
    thisMission = mThisMission;
  }
  
  
  //Checks if mouse x1 and x2 are within task's checkbox
  boolean coordsIn(int x1, int y1){
   boolean b = false;
   if(x1>xPosition+475*displayWidth/700 && x1 <xPosition+475*displayWidth/700+displayWidth/10 && y1>yPosition+45*displayHeight/1200 && y1 < yPosition+45*displayHeight/1200+displayHeight*7/120){
     b = !check;
     check = !check;
   }
   return b;
 }
  
 void draw(){
  fill(255);
  rect(xPosition,yPosition,6*displayWidth/7,150*displayHeight/1200,20);
  fill(100);
  rect(xPosition+475*displayWidth/700,yPosition+45*displayHeight/1200,displayWidth/10,displayHeight*7/120,7);
  textSize(40);
  fill(0);
  text(thisMission,xPosition+37*displayWidth/700,yPosition+85*displayHeight/1200);
 if(check){
    imageMode(CORNER);
    image(checkmark,xPosition+475*displayWidth/700,yPosition+45*displayHeight/1200,displayWidth/10,displayHeight*7/120);
  }
 }
  void toggleChecked(){
    check = !check;
  }
 
}



//MORE CALENDAR STUFF

 public boolean mouseOverArrow(int arrow) {
  switch(arrow) {
  case -2:
    return (mouseInArrowRange() && mouseX > ((width - plannerWidth) / 2 - (width - plannerWidth) / 10 * 4.1) && (mouseX < (width - plannerWidth) / 2 - (width - plannerWidth) / 10 * 3.6));
  case -1:
    return (mouseInArrowRange() && mouseX > ((width - plannerWidth) / 2 - (width - plannerWidth) / 10 * 3.5) && (mouseX < (width - plannerWidth) / 2 - (width - plannerWidth) / 10 * 3));
  case 1:
    return (mouseInArrowRange() && mouseX < ((width - plannerWidth) / 2 + (width - plannerWidth) / 10 * 3.5) && (mouseX > (width - plannerWidth) / 2 + (width - plannerWidth) / 10 * 3));
  case 2:
    return (mouseInArrowRange() && mouseX < ((width - plannerWidth) / 2 + (width - plannerWidth) / 10 * 4.1) && (mouseX > (width - plannerWidth) / 2 + (width - plannerWidth) / 10 * 3.6));
  }

  return false;
}

public boolean mouseInArrowRange() {
  return (mouseY > (margin + topLabelMargin / 10 * 2) && mouseY < (margin + topLabelMargin / 10 * 4));
}

public boolean isLeapYear(int year) {
  if(year % 400 == 0) return true;
  else if(year % 100 == 0) return false;
  else if(year % 4 == 0) return true;
  else return false;
}


public int getDayInMonth(int year, int month, int dayOfWeek, int num) {
  Date date = new Date();
  date.setYear(year);
  date.setMonth(month);
  date.setDate(1);

  int startingDayOfMonth = date.getDay();

  return 7 * (dayOfWeek > startingDayOfMonth ? num - 1 : num) + (dayOfWeek) - startingDayOfMonth;
}

public int lastDayInMonth(int year, int month, int dayOfWeek) {
  int daysInMonth = int(monthDays[month]);
  if(month == 1 && isLeapYear(year)) daysInMonth ++;

  Date date = new Date();
  date.setYear(year);
  date.setMonth(month);
  date.setDate(daysInMonth);

  int lastDayOfMonth = date.getDay();

  return daysInMonth - (lastDayOfMonth - dayOfWeek) - (dayOfWeek - 1 > lastDayOfMonth ? 7 : 0) - 1;
}

public void goToToday() {
  currentYear = year();
  currentMonth = month() - 1;
}

public boolean isToday() {
  return (currentYear == year() && currentMonth == month() - 1);
}

public boolean overTodayButton() {
  textSize(12);
  float textWidth = 60;
  float textHeight = textAscent() + textDescent() + 20;

  return (mouseX > (width - plannerWidth) / 2 - textWidth / 2 && mouseX < (width - plannerWidth) / 2 + textWidth / 2 && mouseY > height - margin / 2 - textHeight / 2 && mouseY < height - margin / 2 + textHeight / 2);
}

public boolean overPlannerScroller() {
  return (mouseY > margin + topLabelMargin && mouseY < margin + topLabelMargin + calendarHeight && mouseX > width - plannerWidth - 15 && mouseX < width - plannerWidth + 5);
}

public class Holiday extends MonthDay {
  int month;
  int day;

  Holiday(String n, int m, int d) {
    name = n;
    month = m;
    day = d;
  }

  public int getMonth() {
    return month;
  }

  public int getDay() {
    return day;
  }
}

abstract class MonthDay {
  String name;

  MonthDay() {}

  public String getName() {
    return name;
  }

  abstract int getMonth();
  abstract int getDay();
}
/*
reference: <iframe src="https://www.openprocessing.org/sketch/70731/embed/"
width="700" height="600"></iframe>
*/
public void drawTasks(int count) {
  count = currBranches;
  Date date = new Date();
  date.setYear(year());
  date.setMonth(month());
  date.setDate(1);
  int startingDayOfMonth = date.getDay();
  int today=getoday()-2;
  int xoff=startingDayOfMonth;
  int yoff=0;
  for (int i=2; i<today+1; i++) {
    xoff=(xoff+1)%7;
    if (xoff==0) yoff++;
  }
  float x1= margin + (spacing * xoff) + (publiconstant1 * (xoff+0.5));
    float x2 = margin + topLabelMargin + (spacing *(yoff)) + (publiconstant2*(yoff+0.5));
    fill(255);
    ellipse(x1, x2, publiconstant1, publiconstant2);
    int x=5;
  for (int i=0; i<5; i++){
    if (count==0) {
      fill(255, 255, 255);
      stroke(5);
    arc(x1, x2, publiconstant1, publiconstant2, i*2*PI/5.0, (i+1)*2*PI/5.0, PIE);
    }
    else {
      if (i<count) fill(10, (i)*50, 10, 150);
      else fill(255, 255, 255);
      stroke(5);
      arc(x1, x2, publiconstant1, publiconstant2, i*2*PI/5.0, (i+1)*2*PI/5.0, PIE);
    }
    x+=50;
  }
}
import java.text.SimpleDateFormat;

public int getoday() {
  SimpleDateFormat sdf = new SimpleDateFormat("dd/M/yyyy");
  String date1 = sdf.format(new Date());
  int day=Integer.parseInt(date1.substring(0, 2));
  return day;
}
