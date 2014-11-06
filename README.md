# ss

Screenshot Service - simplistic http based web service powered by Python and WebKit

## Purpose

This is a work in progress, right now this service will accept a submitted html file
and return back a rendering of said html through webkit. Moving forward the seemingly
straightforward step of rendering a remote url will also be added.

Right now the target platform is Linux. There is a chance that this can work elsewhere,
but at least xvfb is tightly bound to Linux, and the font rendering is known to be less
than ideal elsewhere as well.

## Setup

Requirements:
* Virtualbox
* [Vagrant](https://www.vagrantup.com/)

Setup:
1. Clone this repo
2. vagrant up
3. vagrant ssh
4. ifconfig (get the IP address for later)
5. /vagrant/start-framebuffer.sh

## Usage

For a quick test with the command line, type:

```
$ curl --form file=@index.html http://ip:port/screenshot > index.jpg
```

Several arguments are currently supported:

Return back an image limited by viewport

```
curl --form file=@index.html --form width=200 --form height=200 http://ip:port/screenshot > index.jpg
```

More to come...

## TODO

* Add support for retrieving a remote URL
