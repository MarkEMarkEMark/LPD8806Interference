LPD8806Interference
===================

This is a new complex pattern for LED Strip LPD8806

It overlays the 3 RGB channels with levels decided by sine waves.

There are various parameters to tweak, but I've predefined a number of interesting types using the variable "pattern"

(Please note that this code has been ripped from my own G35 Xmas lights project, and made standalone - this is why the loop code is so bad!!!)


I've a problem with it that I'd love for someone to be able to fix. It's best illustrated with the default pattern 2 - 'white twinkle'. On the way 'up' (i.e. wavelength getting progressively smaller) the display is jerky. However, on it's way back down (i.e. when fForward = false - about 17 seconds in) it is as smooth as it should be.

Can anyone see why this is and help me fix it? It's driving me nuts!!!
