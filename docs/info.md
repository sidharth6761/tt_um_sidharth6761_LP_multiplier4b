<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

## How it works

This project implements a 4-bit low power approximate multiplier based on the Mitchell algorithm. The design multiplies two 4-bit unsigned numbers and produces an 8-bit product.
The Mitchell algorithm approximates multiplication by converting operands into a logarithmic representation using a priority encoder to detect the position of the most significant bit. The logarithmic values are added and then converted back using a shift operation to generate the approximate product.

Steps performed in the design:
1)Two 4-bit inputs A and B are received through the ui_in pins.
2)A priority encoder determines the leading one position of each operand.
3)The operands are shifted based on the detected positions.
4)The shifted values are added to approximate the logarithmic multiplication.
5)The result is converted back to produce the 8-bit approximate product.
6)This approach reduces hardware complexity and power consumption compared to an exact multiplier while introducing a small approximation error.

## How to test

Provide two 4-bit inputs using the input pins:

ui[3:0] → Operand A

ui[7:4] → Operand B

The multiplier computes the product internally using the Mitchell approximation.

The result appears on the output pins:

## External hardware

Does not require any external hardware
