#include "LPD8806.h"
#include "SPI.h"

#define COLOR(r, g, b)        (0x808080 | ((uint32_t)g << 16) | ((uint32_t)r << 8) | (uint32_t)b)

/*****************************************************************************/

// Number of RGB LEDs in strand:
int nLEDs = 160;

// Chose 2 pins for output; can be any valid output pins:
//int dataPin  = 2;
//int clockPin = 3;

// First parameter is the number of LEDs in the strand.  The LED strips
// are 32 LEDs per meter but you can extend or cut the strip.  Next two
// parameters are SPI data and clock pins:
//LPD8806 strip = LPD8806(nLEDs, dataPin, clockPin);

// You can optionally use hardware SPI for faster writes, just leave out
// the data and clock pin parameters.  But this does limit use to very
// specific pins on the Arduino.  For "classic" Arduinos (Uno, Duemilanove,
// etc.), data = pin 11, clock = pin 13.  For Arduino Mega, data = pin 51,
// clock = pin 52.  For 32u4 Breakout Board+ and Teensy, data = pin B2,
// clock = pin B1.  For Leonardo, this can ONLY be done on the ICSP pins.
LPD8806 strip = LPD8806(nLEDs);

void setup() {
  // Start up the LED strip
  strip.begin();

  uint8_t i;
  // Start by turning all pixels off:
  for(i=0; i<strip.numPixels(); i++) strip.setPixelColor(i, 0);

  // Update the strip, to start they are all 'off'
  strip.show();
}

void loop() {
	//pattern 2 gives most graphic example of flicker
	ColorPhasing(2);
}

void ColorPhasing(uint8_t pattern_){
    uint8_t wait_;
    float frequencyR_;
    float frequencyG_;
    float frequencyB_;
    float phaseR_;
    float phaseG_;
    float phaseB_;
    uint8_t center_;
    uint8_t width_;
    uint16_t fStep_;
    uint16_t pStep_;
    bool fForward_;
    uint8_t turn_;
	bool grnOff_;
	bool redOff_;
	bool bluOff_;

	wait_ = 0;
	frequencyR_ = 0.06;
	frequencyG_ = 0.06;
	frequencyB_ = 0.06;
	phaseR_ = 0;
	phaseG_ = 2*PI/3;
	phaseB_ = 4*PI/3;
	center_ = 64;
	width_ = 63;
	fStep_ = 0;
	pStep_ = 0;
	fForward_ = true;
	turn_ = 0;
	grnOff_ = false;
	bluOff_ = false;
	redOff_ = false;

	//switch chooses pattern type, i.e. sets up the variables in different pleasing ways
	do
	{

		switch (pattern_ % 14)
		{
			case 0:  //Wavey pastels
				phaseR_ = 0;
				phaseG_ = 2*PI/3;
				phaseB_ = 4*PI/3;
				frequencyR_ = fStep_ / 200.0;
				frequencyG_ = fStep_ / 200.0;
				frequencyB_ = fStep_ / 200.0;
				redOff_ = false; grnOff_ = false; bluOff_ = false;
				break;
			case 1: // subtly changing pastels
				phaseR_ = 0;
				phaseG_ = (2*PI/360) * pStep_;
				phaseB_ = (4*PI/360) * pStep_;
				frequencyR_ = 1.666;
				frequencyG_ = 2.666;
				frequencyB_ = 3.666;
				redOff_ = false; grnOff_ = false; bluOff_ = false;
				break;
			case 2: //White twinkle
				phaseR_ = 1.0;
				phaseG_ = 1.0;
				phaseB_ = 1.0;
				frequencyR_ = fStep_ / 200.0;
				frequencyG_ = fStep_ / 200.0;
				frequencyB_ = fStep_ / 200.0;
				redOff_ = false; grnOff_ = false; bluOff_ = false;
				break;
			case 3: //Red/Cyan change twinkle
				phaseR_ = 0;
				phaseG_ = 1.0;
				phaseB_ = 1.0;
				frequencyR_ = fStep_ / 200.0;
				frequencyG_ = fStep_ / 200.0;
				frequencyB_ = fStep_ / 200.0;
				redOff_ = false; grnOff_ = false; bluOff_ = false;
				break;
			case 4: //Blue/Yellow change twinkle
				phaseR_ = 1.0;
				phaseG_ = 0;
				phaseB_ = 1.0;
				frequencyR_ = fStep_ / 200.0;
				frequencyG_ = fStep_ / 200.0;
				frequencyB_ = fStep_ / 200.0;
				redOff_ = false; grnOff_ = false; bluOff_ = false;
				break;
			case 5: //Green/Magenta change twinkle
				phaseR_ = 1.0;
				phaseG_ = 1.0;
				phaseB_ = 0;
				frequencyR_ = fStep_ / 200.0;
				frequencyG_ = fStep_ / 200.0;
				frequencyB_ = fStep_ / 200.0;
				redOff_ = false; grnOff_ = false; bluOff_ = false;
				break;
			case 6: //Red twinkle 
				phaseR_ = 0;
				phaseG_ = 1.0;
				phaseB_ = 1.0;
				frequencyR_ = 0;
				frequencyG_ = fStep_ / 200.0;
				frequencyB_ = fStep_ / 200.0;
				redOff_ = false; grnOff_ = false; bluOff_ = false;
				break;
			case 7: //Green twinkle 
				phaseR_ = 1.0;
				phaseG_ = 0;
				phaseB_ = 1.0;
				frequencyR_ = fStep_ / 200.0;
				frequencyG_ = 0;
				frequencyB_ = fStep_ / 200.0;
				redOff_ = false; grnOff_ = false; bluOff_ = false;
				break;
			case 8: //Blue twinkle
				phaseR_ = 1.0;
				phaseG_ = 1.0;
				phaseB_ = 0;
				frequencyR_ = fStep_ / 200.0;
				frequencyG_ = fStep_ / 200.0;
				frequencyB_ = 0;
				redOff_ = false; grnOff_ = false; bluOff_ = false;
				break;
			case 9: //Evolving pastel wave
				switch (turn_ % 6)
				{
				case 0:
				case 1:
					phaseR_ = 0;
					phaseG_ = (2*PI/360) * pStep_;
					phaseB_ = (4*PI/360) * pStep_;
					frequencyR_ = fStep_ / 200.0;
					frequencyG_ = fStep_ / 200.0;
					frequencyB_ = fStep_ / 200.0;
					break;
				case 2:
				case 3:
					phaseG_ = 0;
					phaseB_ = (2*PI/360) * pStep_;
					phaseR_ = (4*PI/360) * pStep_;
					frequencyR_ = fStep_ / 200.0;
					frequencyG_ = fStep_ / 200.0;
					frequencyB_ = fStep_ / 200.0;
					break;
				case 4:
				case 5:
					phaseB_ = 0;
					phaseR_ = (2*PI/360) * pStep_;
					phaseG_ = (4*PI/360) * pStep_;
					frequencyR_ = fStep_ / 200.0;
					frequencyG_ = fStep_ / 200.0;
					frequencyB_ = fStep_ / 200.0;
					break;
				}
				redOff_ = false; grnOff_ = false; bluOff_ = false;
				break;
			case 10: //magenta twinkle
				phaseR_ = 0;
				phaseG_ = 2*PI/3;
				phaseB_ = 4*PI/3;
				frequencyR_ = fStep_ / 200.0;
				frequencyG_ = fStep_ / 200.0;
				frequencyB_ = fStep_ / 200.0;
				redOff_ = false; grnOff_ = true; bluOff_ = false;
				break;
			case 11: //yellow twinkle
				phaseR_ = 0;
				phaseG_ = 2*PI/3;
				phaseB_ = 4*PI/3;
				frequencyR_ = fStep_ / 200.0;
				frequencyG_ = fStep_ / 200.0;
				frequencyB_ = fStep_ / 200.0;
				redOff_ = false; grnOff_ = false; bluOff_ = true;
				break;
			case 12: //cyan twinkle
				phaseR_ = 0;
				phaseG_ = 2*PI/3;
				phaseB_ = 4*PI/3;
				frequencyR_ = fStep_ / 200.0;
				frequencyG_ = fStep_ / 200.0;
				frequencyB_ = fStep_ / 200.0;
				redOff_ = true; grnOff_ = false; bluOff_ = false;
				break;
			case 13: //colours slightly askew with white peak (C/M/G/R)
				phaseR_ = 0.0;
				phaseG_ = 2.0 * PI /3.0;
				phaseB_ = 1.0;
				frequencyR_ = (float)fStep_ / 200.0;
				frequencyG_ = (float)fStep_ / 200.0;
				frequencyB_ = (float)fStep_ / 200.0;
				redOff_ = false; grnOff_ = false; bluOff_ = false;
				break;
			case 14: //colours slightly askew with white peak (M/Y/B/G)
				phaseR_ = 1.0;
				phaseG_ = 0.0;
				phaseB_ = 2.0 * PI /3.0;
				frequencyR_ = (float)fStep_ / 200.0;
				frequencyG_ = (float)fStep_ / 200.0;
				frequencyB_ = (float)fStep_ / 200.0;
				redOff_ = false; grnOff_ = false; bluOff_ = false;
				break;
			case 15: //colours slightly askew with white peak (Y/C/R/B)
				phaseR_ = 2.0 * PI /3.0;
				phaseG_ = 1.0;
				phaseB_ = 0.0;
				frequencyR_ = (float)fStep_ / 200.0;
				frequencyG_ = (float)fStep_ / 200.0;
				frequencyB_ = (float)fStep_ / 200.0;
				redOff_ = false; grnOff_ = false; bluOff_ = false;
				break;
			case 16:  //colours slightly askew (C/Y/G/R)
				phaseR_ = 0.0;
				phaseG_ = 2.0 * PI /3.0;
				phaseB_ = 4.0 * PI /3.0;
				frequencyR_ = (float)fStep_ / 200.0;
				frequencyG_ = (float)fStep_ / 200.0;
				frequencyB_ = 0.0;
				redOff_ = false; grnOff_ = false; bluOff_ = false;
				break;
			case 17:  //colours slightly askew (M/C/B/G)
				phaseR_ = 4.0 * PI /3.0;
				phaseG_ = 0.0;
				phaseB_ = 2.0 * PI /3.0;
				frequencyR_ = 0.0;
				frequencyG_ = (float)fStep_ / 200.0;
				frequencyB_ = (float)fStep_ / 200.0;
				redOff_ = false; grnOff_ = false; bluOff_ = false;
				break;
			case 18:  //colours slightly askew (Y/M/R/B)
				phaseR_ = 2.0 * PI /3.0;
				phaseG_ = 4.0 * PI /3.0;
				phaseB_ = 0.0;
				frequencyR_ = (float)fStep_ / 200.0;
				frequencyG_ = 0.0;
				frequencyB_ = (float)fStep_ / 200.0;
				redOff_ = false; grnOff_ = false; bluOff_ = false;
				break;
			default: //nothing - a still pastel rainbow
				;
		}

		for (int i=0; i < strip.numPixels(); i++)
		{
			int red = sin(frequencyR_*i + phaseR_) * width_ + center_;
			int grn = sin(frequencyG_*i + phaseG_) * width_ + center_;
			int blu = sin(frequencyB_*i + phaseB_) * width_ + center_;
			if (redOff_)
			{
				red = 0;
			}
			if (grnOff_)
			{
				grn = 0;
			}
			if (bluOff_)
			{
				blu = 0;
			}
			
			strip.setPixelColor(i, COLOR(red, grn, blu));
		}

			//set direction: 1 2 .. 98 .. 160 .. 98 .. 2 1
		if (fStep_ == 200)
		{
			fForward_ = false;
		}
		if (fStep_ == -1)
		{
			fForward_ = true;
			turn_++;
		}

		if (fForward_)
		{

			fStep_++;
		} else {
			fStep_--;
		}

		pStep_++;
		if (pStep_ == 800)
		{
			pStep_ = 0;
		}

		delay(wait_);

		strip.show();							
} while (true);
{
}
}