#!/usr/bin/env bash

# reference:
# https://developer.apple.com/library/ios/qa/qa1686/_index.html

function create_appiconset {
  if [[ -e "$(destination)/AppIcon.appiconset" ]]; then
    echo "AppIcon.appiconset already exists"
    exit 1
  else
    mkdir "$(destination)/AppIcon.appiconset"
  fi
}


function create_contents_json {
  cat <<EOT >> "$(destination)/AppIcon.appiconset/Contents.json"
{
  "images" : [
    {
      "idiom" : "iphone",
      "size" : "29x29",
      "filename" : "Icon-Small@2x.png",
      "scale" : "2x"
    },
    {
      "idiom" : "iphone",
      "size" : "29x29",
      "filename" : "Icon-Small@3x.png",
      "scale" : "3x"
    },
    {
      "idiom" : "iphone",
      "size" : "40x40",
      "filename" : "Icon-Small-40@2x.png",
      "scale" : "2x"
    },
    {
      "idiom" : "iphone",
      "size" : "40x40",
      "filename" : "Icon-Small-40@3x.png",
      "scale" : "3x"
    },
    {
      "idiom" : "iphone",
      "size" : "60x60",
      "filename" : "Icon-60@2x.png",
      "scale" : "2x"
    },
    {
      "idiom" : "iphone",
      "size" : "60x60",
      "filename" : "Icon-60@3x.png",
      "scale" : "3x"
    },
    {
      "idiom" : "ipad",
      "size" : "29x29",
      "filename" : "Icon-Small.png",
      "scale" : "1x"
    },
    {
      "idiom" : "ipad",
      "size" : "29x29",
      "filename" : "Icon-Small@2x.png",
      "scale" : "2x"
    },
    {
      "idiom" : "ipad",
      "size" : "40x40",
      "filename" : "Icon-Small-40.png",
      "scale" : "1x"
    },
    {
      "idiom" : "ipad",
      "size" : "40x40",
      "filename" : "Icon-Small-40@2x.png",
      "scale" : "2x"
    },
    {
      "idiom" : "ipad",
      "size" : "76x76",
      "filename" : "Icon-76.png",
      "scale" : "1x"
    },
    {
      "idiom" : "ipad",
      "size" : "76x76",
      "filename" : "Icon-76@2x.png",
      "scale" : "2x"
    },
    {
      "idiom" : "ipad",
      "size" : "83.5x83.5",
      "filename" : "Icon-83.5@2x.png",
      "scale" : "2x"
    }
  ],
  "info" : {
    "version" : 1,
    "author" : "xcode"
  }
}
EOT
}


function create_icons {
  image="$1"

  # Settings
  create_icon "$image" "29"  "Icon-Small"
  create_icon "$image" "58"  "Icon-Small@2x"
  create_icon "$image" "87"  "Icon-Small@3x"

  # Spotlight
  create_icon "$image" "40"  "Icon-Small-40"
  create_icon "$image" "80"  "Icon-Small-40@2x"
  create_icon "$image" "120" "Icon-Small-40@3x"

  # Home screen (iPhone)
  create_icon "$image" "120" "Icon-60@2x"
  create_icon "$image" "180" "Icon-60@3x"

  # Home screen (iPad)
  create_icon "$image" "76"  "Icon-76"
  create_icon "$image" "152" "Icon-76@2x"
  create_icon "$image" "167" "Icon-83.5@2x"
}


function create_icon {
  image="$1"
  size="$2"
  name="$3"

  sips -s format png -z "$size" "$size" "$image" --out "$(destination)/AppIcon.appiconset/${name}.png"
}


function optimize_icons {
  if hash imageoptim 2>/dev/null; then
    imageoptim --directory "$(destination)/AppIcon.appiconset"
  else
    echo
    echo "imageoptim-cli is not installed. Icons won't be optimized."
    echo "To install, run:"
    echo "  $ npm install -g imageoptim-cli"
  fi
}


function destination {
  pwd
}




function run {
  if [[ -z "$1" ]]; then
    echo "usage: ./ios-icon-generator [IMAGE]"
  else
    image="$1"

    create_appiconset
    create_contents_json
    create_icons "$image"
    optimize_icons
  fi
}

(run $@)
