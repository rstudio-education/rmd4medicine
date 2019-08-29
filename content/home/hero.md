+++
# Hero widget.
widget = "hero"  # See https://sourcethemes.com/academic/docs/page-builder/
headless = true  # This file represents a page section.
active = true  # Activate this widget? true/false
weight = 10  # Order that this section will appear.

title = "R Markdown for Medicine"

# Hero image (optional). Enter filename of an image in the `static/img/` folder.
hero_media = "rmd4med-sq.jpg"

[design.background]
  # Apply a background color, gradient, or image.
  #   Uncomment (by removing `#`) an option to apply it.
  #   Choose a light or dark text color by setting `text_color_light`.
  #   Any HTML color name or Hex value is valid.

  # Background color.
  # color = "white"
  
  # Background gradient.
  # gradient_start = "#4bb4e3"
  # gradient_end = "#2b94c3"
  
  # Background image.
  # image = ""  # Name of image in `static/img/`.
  # image_darken = 0.6  # Darken the image? Range 0-1 where 0 is transparent and 1 is opaque.

  # Text color (true=light or false=dark).
  text_color_light = false
  
[design.spacing]
  # Customize the section spacing. Order is top, right, bottom, left.
  padding = ["100px", "0", "100px", "50px"]

# Call to action links (optional).
#   Display link(s) by specifying a URL and label below. Icon is optional for `[cta]`.
#   Remove a link/note by deleting a cta/note block.
[cta]
  url = "https://r-medicine.com/#registration"
  label = "Register Now"
  icon_pack = ""
  icon = ""
  
[cta_alt]
  url = "about"
  label = "About this workshop"

# Note. An optional note to show underneath the links.
[cta_note]
  label = 'Register by September 14 @ 9:00am'
+++

A four-hour workshop that will take you on a tour of how to get from data to manuscript using R Markdown. Starting with a mock clinical trial dataset, we'll use R Markdown to combine prose, R code, and figures and tables created with R code into a nicely formatted and reproducible final manuscript. You'll learn:

+ The basics of R Markdown & `knitr`
+ How to add and format tables 
+ Efficient workflows for working with data in R Markdown
+ How to add and format graphics
