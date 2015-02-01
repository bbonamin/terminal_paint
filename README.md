# TerminalPaint

A basic interactive bitmap editor for the terminal.

## Installation
* Requires Ruby 2.1+

```
  $ git clone https://github.com/bbonamin/terminal_paint  
  $ cd terminal_paint  
  $ rake gem  
  $ gem install pkg/terminal_paint-0.0.1.gem  
```


## Usage

| Command     | Description |
|-------------|-------------|
| I M N       | Creates a new M x N image with all pixels colored white (O). |
| C           | Clears the table, setting all pixels to white (O). |
| L X Y C     | Colors the pixel (X, Y) with color C. |
| V X Y1 Y2 C | Draws a vertical segment of colour C in column X between rows Y1 and Y2 (inclusive). |
| H X1 X2 Y C | Draws a horizontal segment of color C in row Y between columns X1 and X2 (inclusive). |
| F X Y C     | Fills the region R with the colour C. R is defined as: Pixel (X, Y) belongs to R. Any other pixel with the same color as (X, Y) which shares a common side with any pixel in R also belongs to R. |
| S           | Shows the contents of the current image. |
| Z           | Inverts the colors of the current image. (using the letter position in the alphabet with an descending order) |
| X           | Terminates the session. |

## Contributing

1. Fork it ( https://github.com/bbonamin/terminal_paint/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
