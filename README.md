# rpi-hugo [Fork of hypriot/rpi-hugo](https://github.com/hypriot/rpi-hugo)

Raspberry Pi compatible Docker Image with [Hugo](http://gohugo.io) - a static webpage builder

## Details
- [Blog Post](http://blog.hypriot.com/post/static-website-generation-on-steriods-with-docker/)
- [Source Project Page](https://github.com/hypriot)
- [Source Repository](https://github.com/hypriot/rpi-hugo)
- [Dockerfile](https://github.com/hypriot/rpi-hugo/blob/master/Dockerfile)

## Setting up Hugo (Updated)

```bash
make
make hugo-themes
```
or you can take a specific theme like this (Here, we want "hugo-inito" into the directory by default)

```bash
make
git submodule add https://github.com/miguelsimoni/hugo-initio.git blog/themes/hugo-initio
```

## Create new article

```bash
make hugo-post
```

## Live preview

### Start

```bash
make hugo-live
```
and on your notebook

```bash
open http://<ip-of-your-rpi>:1313
```

### Stop

```bash
make hugo-live-out
```

## Build final HTML pages

```bash
make hugo-build
```

## How to create this image

Run all the commands from within the project root directory.

### Update HUGO Version (New)

Before create a new image of this project, you can change the version number of HUGO from this file "VERSION".

### Build the Docker Image
```bash
make docker-build
```

## License

The MIT License (MIT)

Copyright (c) 2015 Hypriot

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
