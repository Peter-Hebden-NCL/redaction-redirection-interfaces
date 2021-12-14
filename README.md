# Redaction/redirection interfaces source code

**These three interfaces were developed for the 'Redaction/Redirection' poetry installation at Newcastle Poetry Festival 2019, using work by the poets Andrew McMillan, Miriam Gamble and Phoebe Power. Each creates a different animated display from the poem text.**



### Content

This code repository contains the source files for the three animated reading displays, the code for which can be found in the respective folders. Two of the projects 'McMillan' and 'Gamble' are built using HTML/JS, while 'Power' is a Processing-based project.

In 'McMillan', extracts of text are slowly revealed over a series of short video clips in the background of the reading space.

In 'Gamble', the the text scrolls slowly up the screen, with some elements first changing colour and then disappearing altogether as it moves upwards. This is accompanied by a roster of images in the background of the reading space.

The 'Power' script compares different versions of images a page, initially displaying one version on-screen and then using a burning-style animation to slowly transform it into the other by performing a gradual pixel-by-pixel comparision of the two images and replacing any pixels that are different with the pixel from the second image.

The poems in these interfaces have been replaced with placeholder text, which is clearly marked in the  HTML and JS files. All three project require the addition of image or video assets to function. The requirements for these are indicated in comments in the code for each project. 



### Third-party software

- **FFmpeg** - Processing library used for handling image comparision in the 'Power' project. (Used under the GNU Lesser General Public License, version 2.1. A copy of the license can be found at: http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html)



### Attribution

This code repository is part of the PhD thesis 'Poetry in Digital Media' by Peter Hebden, Newcastle University 2021. This source code is shared under the MIT License. A copy of the license is included in the root folder of this project.

