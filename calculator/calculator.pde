//Shamus Sage| 15 Sept 26
Button[] numButtons = new Button[10];
Button[] opButtons = new Button[12];
float l, r, result, realresult;
char op;
boolean left, newEntry;
String displayVal;
int p;
void setup() {
  size(600, 600);
  l = 0.0;
  r = 0.0;
  result = 0.0;
  op = ' ';
  displayVal = "0.0";
  left = true;
  numButtons[9] = new Button(180, 160, 50, 50, '9');
  numButtons[8] = new Button(120, 160, 50, 50, '8');
  numButtons[7] = new Button(60, 160, 50, 50, '7');
  numButtons[6] = new Button(180, 220, 50, 50, '6');
  numButtons[5] = new Button(120, 220, 50, 50, '5');
  numButtons[4] = new Button(60, 220, 50, 50, '4');
  numButtons[3] = new Button(180, 280, 50, 50, '3');
  numButtons[2] = new Button(120, 280, 50, 50, '2');
  numButtons[1] = new Button(60, 280, 50, 50, '1');
  numButtons[0] = new Button(60, 340, 50, 50, '0');
  opButtons[0] = new Button(120, 400, 50, 50, '^');
  opButtons[1] = new Button(240, 160, 50, 50, '+');
  opButtons[2] = new Button(240, 220, 50, 50, '-');
  opButtons[3] = new Button(240, 280, 50, 50, '*');
  opButtons[4] = new Button(240, 340, 50, 50, '÷');
  opButtons[5] = new Button(120, 340, 50, 50, '.');
  opButtons[6] = new Button(240, 100, 50, 50, 'C');
  opButtons[7] = new Button(240, 40, 50, 50, '±');
  opButtons[8] = new Button(180, 340, 50, 50, '=');
  opButtons[9] = new Button(60, 400, 50, 50, '√');
  opButtons[10] = new Button(180, 400, 50, 50, 'D');
  opButtons[11] = new Button(240, 400, 50, 50, 'E');
}

void draw() {
  background(190);
  ellipse (150, 250, 300, 600);
  drawDisplay();
  for (int i = 0; i<numButtons.length; i++) {
    textSize(18);
    numButtons[i].display();
    numButtons[i].mouseOver(mouseX, mouseY);
  }
  for (int i = 0; i<opButtons.length; i++) {
    opButtons[i].display();
    opButtons[i].mouseOver(mouseX, mouseY);
  }
}

void drawDisplay() {
  rectMode(CENTER);
  rect(120, 60, 160, 80);
  fill(1);
  textSize(45);
  text(displayVal, 120, 70);
}

void mouseReleased() {
  for (int i = 0; i < numButtons.length; i++) {
    if (numButtons[i].hover) {
      handleEvent(numButtons[i].val, true);
    }
  }
  for (int i = 0; i < opButtons.length; i++) {
    if (opButtons[i].hover) {
      handleEvent(opButtons[i].val, false);
    }
  }

  // Display Variables
  println("L: " + l);
  println("R: " + r);
  println("Result: " + result);
  println("Left: " + left);
  println("Op: " + op);
}

void performCalc() {
  if (op == '+') {
    result = l + r;
  } else if (op == '-') {
    result = l - r;
  } else if (op == '÷') {
    result = l / r;
  } else if (op == '*') {
    result = l * r;
  } else if (op == '^') {
    result = pow(l, r);

    l = result;
  }
  left = !left;
}
void keyPressed() {
  println("Key code " +keyCode);
  if (key<106 || key>96) {
    handleEvent(key, true);
  } else if (key==107) {
    handleEvent(key, false);
  } else if (key ==10) {
    handleEvent(key,false);
  }
}

void handleEvent(char val, boolean isNum  ) {
  if (isNum == true) {
    String digit = str(val);

    if (newEntry || displayVal.equals("0.0")) {
      displayVal = digit;
      newEntry = false;
    } else {
      displayVal += digit;
    }

    if (left) {
      l = float(displayVal);
    } else {
      r = float(displayVal);
    }
  } else {
    char clicked = val;
    if (clicked == '=') {
      performCalc();
    } else if (clicked == '+' || clicked == '-' ||clicked == '*' || clicked == '/' || clicked == '^') {
      op = clicked;
      left = !left;
      newEntry = true;
      displayVal = str(op);
    } else if (clicked == '±') {
      if (left == true) {
        l *= -1;
        displayVal = str(l);
      } else {
        r *= -1;
        displayVal = str(r);
      }
    } else if (clicked == 'C') {
      // reset all variables
      l = 0.0;
      r = 0.0;
      result = 0.0;
      op = ' ';
      displayVal = "0.0";
      left = true;
      newEntry = true;
    } else if (clicked == '√') {
      if (left == true) {
        l = sqrt(l);
        displayVal = str(l);
      } else {
        r = sqrt(r);
        displayVal = str(r);
      }
    } else if (clicked == '^') {
      left=!left;
    }
  }
}
