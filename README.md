Swift Playground Project based on my [YouTube video](https://youtu.be/mLH0-zCOJko)

This code is implemented in three parts:
- SwiftUI View for showing the preview in the playground.
- UIColor Helper Method
- Interpolation Function

The main point of interest is the interpolate function.

Input has two colors. The start and end values of the gradient. The output is a color that is between the two initial values.
The purpose of this function is to generate a middle color that avoids the muddy/grey area of the RGB color wheel.

To do this, the colors are converted to HSB. The Saturation and Brightness of the new color are averages of the two input colors.
The same thing is done to the Hue, but due to this value being plotted on a circle, a little extra work is done to ensure that the average chosen, contains the shortest distance around that circle.

You can find out more about the theory on this here:
https://stackoverflow.com/a/39147465/2114482

And a much better gradient creation tool can be found here:
https://learnui.design/tools/gradient-generator.html

![image](https://raw.githubusercontent.com/BeauNouvelle/Gradient-Interpolation/main/screencap.png)

