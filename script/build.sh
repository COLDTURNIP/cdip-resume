#!/bin/bash

#=====================================================================
#          FILE:  cv.sh
#         USAGE:  Run manually to generate my CV
#   DESCRIPTION:  Uses Pandoc to pull together Markdown documents
#                 & process them with Pandoc to generate my CV
#       CREATOR:  Scott Granneman (RSG), scott@ChainsawOnATireSwing.com
#        AUTHOR:  Raphanus Lo (COLDTURNIP), coldturnip@gmail.com
#       VERSION:  0.1
#       CREATED:  05/11/2013 11:50:30 CDT
#      REVISION:  09/08/2013 23:37:00 GMT+8
#=====================================================================

###
## Utilities
#

function gettop()
{
  if [[ -d .git ]] ; then
      echo $(pwd)
  else
    local HERE=$(pwd)
    while [[ ( ! -d .git ) && ( $(pwd) != "/" ) ]]; do
      cd .. > /dev/null 2> /dev/null
    done
    if [[ -d .git ]] ; then
        echo $(pwd)
    fi
    cd ${HERE}
  fi
}

###
## Variables
#

# Directory for CV
cvDir=$(gettop)

# Directory for CV Builds
cvSrcDir=${cvDir}/src
cvOutDir=${cvDir}/out

# Name of the CV file
author="Yun-Chang (Raphanus) Lo"
cvName="${author} - CV - $(date +%Y-%m-%d)"

# File order
orderedFile="       \
  description       \
  experience        \
  skills            \
  education         \
  research          \
  experience-extra  \
  "

###
## Create HTML files for each Markdown file
#

for i in $(ls ${cvSrcDir}/*.md) ; do
  # Get the name of the file, sans extension, for generating HTML file
  cvBuildName=$(basename "$i" .md)
  # Convert to HTML
  pandoc --section-divs -f markdown -t html5 -o ${cvOutDir}/${cvBuildName}.html $i
done

###
## Join the HTML files into one HTML CV
#
pandocCvHtmlOut=${cvOutDir}/${cvName}.html
pandocHtmlCmd="pandoc -s -H ${cvSrcDir}/style.css --section-divs -f markdown -t html5"
pandocHtmlCmd="${pandocHtmlCmd} -o \"${pandocCvHtmlOut}\""
for i in ${orderedFile} ; do
  pandocHtmlCmd="${pandocHtmlCmd} -A ${cvOutDir}/${i}.html"
done
pandocHtmlCmd="${pandocHtmlCmd} ${cvSrcDir}/cv.md"
eval ${pandocHtmlCmd}

###
## Convert the HTML CV into PDF CV
#

pandoc --latex-engine=xelatex -H ${cvSrcDir}/style-header.tex \
  "${pandocCvHtmlOut}" -o "${cvOutDir}/${cvName}.tex"
pandoc --latex-engine=xelatex -H ${cvSrcDir}/style-header.tex \
  "${pandocCvHtmlOut}" -o "${cvOutDir}/${cvName}.pdf"

###
## References
#

# Convert to HTML
# TODO: finish me
if [[ 1 == 0 ]]; then
pandocRefHtmlOut=${cvOutDir}/references.html
pandoc --section-divs -f markdown -t html5 -o "${pandocRefHtmlOut}" \
    "${cvSrcDir}/references.md"

# Convert HTML to PDF
pandoc --latex-engine=xelatex -H ${cvSrcDir}/style-header.tex "${pandocRefHtmlOut}" \
    -o "${cvOutDir}/${author} - References - $(date +%Y-%m-%d).pdf"
fi

###
## Cover Letter
#

# Convert to HTML
pandocCovHtmlOut=${cvOutDir}/cover-letter.html
pandoc --section-divs -f markdown -t html5 -o "${pandocCovHtmlOut}" \
    "${cvSrcDir}/cover-letter.md"

# Convert HTML to PDF
pandoc --latex-engine=xelatex -H ${cvSrcDir}/style-header.tex "${pandocCovHtmlOut}" \
    -o "${cvOutDir}/${author} - Cover Letter - $(date +%Y-%m-%d).pdf"


