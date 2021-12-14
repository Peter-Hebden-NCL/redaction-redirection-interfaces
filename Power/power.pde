//importing video capture library
//Processing Library VideoExport by Abe Pazos. (c) 2017
import com.hamoid.*;
VideoExport videoExport;

//before and after for each page
PImage page_a;
PImage page_b;

//chance of a particular point burning away
int chance;
//the current point being considered
int current;

//all pages, before and after
String[] pages = { "page1.jpg", "page2.jpg", "page3.jpg", "page4.jpg", "page5.jpg", "page6.jpg", "page7.jpg", "page8.jpg", };
String[] poems = { "poem1.jpg", "poem2.jpg", "poem3.jpg", "poem4.jpg", "poem5.jpg", "poem6.jpg", "poem7.jpg", "poem8.jpg" };
//the current page
int page_count;

//pause before starting burn on each page
int  start_count;
//pause before moving on to next page
int pause_count;
//amount current page burned away
int burn_count;


void burn() {
  chance = int(random(100));
  
  //check chance of burning/singe if not already burnt
  if (pixels[current] != page_b.pixels[current]) {
    //singe - determining colour (9/100 chance)
    if (2 <= chance && chance <= 10) {
      if (chance == 2) {
        pixels[current] = color(150,15,30); //dark red (1/100)
      } else {
        if (chance == 3) {
          //pixels[current] = color(120); //light grey (1/100)
        } else {
          pixels[current] = color(50); //dark grey (7/100)
        }
      }
    }
    //fully burn - change pixel and add to burn count (1/100 chance)
    if (chance == 1) {
      pixels[current] = page_b.pixels[current];
      burn_count = burn_count + 1;
    }
  } else {
    // already burnt - add to burn count
    burn_count = burn_count + 1;
  }
}

void setup() {
  
  //correct proportions! (0.654 : 1 ratio)
  //size(707,1080);
  
  size(458,700);
  
  page_count = 1;
  
  //page
  page_a = loadImage(pages[page_count-1]);
  image(page_a,0,0,width,height);
  
  //replacement image
  page_b = loadImage(poems[page_count-1]);
  page_b.loadPixels();
  
  start_count = 200;
  pause_count = 0;
  burn_count = 0;
  
  videoExport = new VideoExport(this);
  videoExport.startMovie();
}

void draw() {
    
    //counting down to start burning
    if (start_count > 0) {
      start_count = start_count - 1;  
    } else {
      //start burning
      
      // burn count resets at the beginning of each loop
      burn_count = 0;
      
      loadPixels();
    
      // Loop through every pixel row
      for (int y = 0; y < height; y++) {
        // Loop through every pixel column
         for (int x = 0; x < width; x++) {
          // Current pixel location
          current = x + y * width;
          if (
            //STEP 1 - checking if adjacent pixels are out of range
            //left and right
            current-1 < 0 ||
            (current+1) % width == 0 ||
            current % width == 0 ||
            current+1 >= pixels.length ||
            //above and below
            current+width >= pixels.length ||
            current-width < 0
          ) {
            // burn if on edge
            burn();
            
          } else {
            if (
              //STEP 2 - checking if adjacent pixels are already burned
              //left and right
              pixels[current+1] == page_b.pixels[current+1] ||
              pixels[current-1] == page_b.pixels[current-1] ||
              //above and below
              pixels[current+width] == page_b.pixels[current+width] ||
              pixels[current-width] == page_b.pixels[current-width]
            ) {
              //burn if next to burnt spot
              burn();
              
            }
          }
        }
      }
      
      updatePixels();
      
      //next page (once the page is a certain % gone)
      if (burn_count >= page_b.pixels.length*0.99) {
        pause_count = pause_count+1;
        
        if (pause_count >= 600 && page_count < pages.length) {
          //new page
          page_count = page_count+1;
          page_a = loadImage(pages[page_count-1]);
          image(page_a,0,0,width,height);
          
          //new replacement image
          page_b = loadImage(poems[page_count-1]);
          page_b.loadPixels();
          
          pause_count = 0;
          start_count = 200;
        }
        
      }
      
    }

  videoExport.saveFrame();
}

//building in 'quit' for recording purposes
void keyPressed() {
  if (key == 'q') {
    videoExport.endMovie();
    exit();
  }
}
