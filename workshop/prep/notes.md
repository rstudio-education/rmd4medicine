- knit to word document w/ tables/figures
- knit to rticles (pick a format)
- find dataset (Melanie's vitamin d study?)


# R Markdown for Medicine: From Data to Manuscript

## Learning objectives

### Personas

- Anya Academic
- Beatric Browser

### Blocks

Pre-work: do one of the markdown tutorials- this will be in teaser slide deck too

1. Orientation (20 min + 10)
    - launch project, edit file, knit to HTML, woohoo
    - this is Carl's 00
1. R Markdown Basic Building Blocks (20 min + 10)
    - take from block 1: basic building blocks from communicate workshop
    - also take from slides 29-37 in Carl's R in 90 minutes (skip slides 38-44)
    - We can switch to knit to word here, change the output format
1. Graphics (20 min + 10)
    - take from Carl's 03-presentations.Rmd
    - note: skip 02-data-preparation.Rmd
    - perhaps sneak in a parameter there
    - add factors for graphics (forcats- rearrange axis labels)
-- 15 min break (we are now at 1:45 in; we have 165 min left)
1. Workflows I (20 min + 10)
    - cover file paths (`here` package)
    - cover file organization
1. Tables (20 min + 10)
    - perhaps switch to knitting to ppt doc for this?
    - focus on gt?
1. Else (20 min + 10)
-- 15 min break (we are now at 1:45 in; we have 165 min left)
1. Wrap-up: what else is possible
    - bibliographies
    - multi-plot layouts
    - rticles / bookdown
    - presentations (xaringan- make a demo one based on same data)

## Constraints

Manuscripts must be submitted in MS word, need bibliographies formatted

+ Limit of 4-7 (tables + figures) depending on journal

+ Need for multipanel figures

+ Images 300 PPI or greater, can be JPEG, TIFF, EPS

+ Figures should be named consecutively such as "figure 1.tif," "figure 2.jpg," etc., with the file extension appended (.tif, .jpg, .ai, .eps, etc). Each figure should be saved as a separate electronic file.

+ Maximum size usually 7 x 9.33 in

+ Presentations must be in PPT 16 x9

+ Must have table 1

+ Must have nice multipanel figures

+ Must be able to mix text, data


Starting point

Outline of manuscript with bullet points for intro, methods, results, conclusions

Have data

Need to generate

1.       Table 1

2.       Boxplot

3.       Demonstrate some inline r code for stats, p values, proportions, etc.

4.       Barplot

5.       Scatter?

6.       Possibly geom_sf from NCQA data?

7.       Use patchwork to make multipanel figure with tags for panels A, B, C, D and unified figure caption

8.       ggsave to tiff, eps, ai for manuscripts, png for slides

9.       A nice table of adverse events by treatment arm, with practice formatting (opportunity to show off flextable or gt)

10.   Citations

11.   Output to Word

12.   Output to ppt (bring in images)
