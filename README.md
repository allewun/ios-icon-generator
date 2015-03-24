# iOS icon generator

Generate all the app icons needed with a single command.

## Usage

```
./ios-icon-generator [IMAGE]
```

The source image should ideally be square and larger than 180x180, as the current largest icon size is 180x180 (for the iPhone 6 Plus).

## Optimization

The icons will be losslessly compressed via [ImageOptim](https://github.com/pornel/ImageOptim) ([CLI](https://github.com/JamieMason/ImageOptim-CLI)), if available on your machine. The easiest way to install it is with:

```
npm install -g imageoptim-cli
```