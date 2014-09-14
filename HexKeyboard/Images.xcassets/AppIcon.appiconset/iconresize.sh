#!/bin/bash
f=$(pwd)

sips --resampleWidth 512 "${f}/${1}" --out "${f}/iTunesArtwork"
sips --resampleWidth 1024 "${f}/${1}" --out "${f}/iTunesArtwork@2x"
sips --resampleWidth 57 "${f}/${1}" --out "${f}/Icon.png"
sips --resampleWidth 114 "${f}/${1}" --out "${f}/Icon@2x.png"
sips --resampleWidth 29 "${f}/${1}" --out "${f}/Icon-Small.png"
sips --resampleWidth 58 "${f}/${1}" --out "${f}/Icon-Small@2x.png"
sips --resampleWidth 50 "${f}/${1}" --out "${f}/Icon-Small-50.png"
sips --resampleWidth 72 "${f}/${1}" --out "${f}/Icon-72.png"
sips --resampleWidth 144 "${f}/${1}" --out "${f}/Icon-72@2x.png"    
sips --resampleWidth 76 "${f}/${1}" --out "${f}/Icon-76.png"
sips --resampleWidth 152 "${f}/${1}" --out "${f}/Icon-76@2x.png"
sips --resampleWidth 60 "${f}/${1}" --out "${f}/Icon-60.png"
sips --resampleWidth 120 "${f}/${1}" --out "${f}/Icon-60@2x.png"
sips --resampleWidth 180 "${f}/${1}" --out "${f}/Icon-60@3x.png"