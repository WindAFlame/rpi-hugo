# rpi-hugo [Fork of hypriot/rpi-hugo](https://github.com/hypriot/rpi-hugo)

Raspberry Pi compatible Docker Image with [Hugo](http://gohugo.io) - a static webpage builder

## Details
- [Blog Post](http://blog.hypriot.com/post/static-website-generation-on-steriods-with-docker/)
- [Source Project Page](https://github.com/hypriot)
- [Source Repository](https://github.com/hypriot/rpi-hugo)
- [Dockerfile](https://github.com/hypriot/rpi-hugo/blob/master/Dockerfile)

## Setting up your hugo project

You need to create a workpace for your project.
This workspace is where you can create, start a live server and build your project.

For there features, you need to clone this git.
I recommanded you delete the .git directory for make this your own.

```bash
git clone -b master https://github.com/WindAFlame/rpi-hugo.git
rm -rf ./.git
``` 

## Configure your conf

The project is based on a configuration file "Makefile.conf".

You need to modify this file for put in your stuff.

By default, we have the following configuration :

```
- Build a docker image with this name : ew/rpi-hugo.
 This image expose the 1313 port for live preview.
 
- Use the following hugo version when the docker image is build : 0.37.1.

- Deploy the live preview on this url http://127.0.0.1:1313/.

- Store your hugo project in $(pwd)/blog.

- Create a docker container with this name : rpi-hugo_blog.

- Can't push your project in a git repository because this data is EMPTY.
```

## Create a docker image

Before work on your hugo project. You need to create an image with your hugo version.

By default, this project can create a docker image with the version 0.37.1 of hugo.

```bash
make docker-build
```

_Many features are included in my Makefile for use docker._

## Setting up Hugo

Your project need to create a hugo project. With the following command, you can start a hugo project.

```bash
make
make hugo-themes
```
or you can take a specific theme like this (Here, we want "hugo-inito" into the directory by default)

```bash
make
git submodule add https://github.com/miguelsimoni/hugo-initio.git blog/themes/hugo-initio
```

*Be carefull with this, the project is created in ./blog but if yours was create in /www/blog you need to adapt the git submodule command.*

## Create new article

If you want to create a post, you can it with this command.

```bash
make hugo-post
```
Next, you need to go into your hugo project to edit the post in your favorite writer.

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

## Publish in your git repository

Work in progress

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
