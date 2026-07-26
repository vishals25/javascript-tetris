Javascript Tetris
=================

An HTML5 Tetris Game — containerized with Docker and shipped via GitHub Actions.

This is a fork of [jakesgordon/javascript-tetris](https://github.com/jakesgordon/javascript-tetris)
that packages the game as an nginx container image and publishes it to Docker Hub on every push.

 * [play the original](https://jakesgordon.com/games/tetris/)
 * read the original [blog article](https://jakesgordon.com/writing/javascript-tetris/)
 * image on Docker Hub: [`svishal25/tetris`](https://hub.docker.com/r/svishal25/tetris)

>> _*SUPPORTED BROWSERS*: Chrome, Firefox, Safari, Opera and IE9+_

Running with Docker
===================

Pull and run the published image:

```sh
docker run --rm -p 8080:80 svishal25/tetris:latest
```

Then open <http://localhost:8080>.

Or build it locally:

```sh
docker build -t tetris .
docker run --rm -p 8080:80 tetris
```

The image is based on `nginx:alpine` and serves the static files from
`/usr/share/nginx/html` on port 80. A `HEALTHCHECK` polls `http://localhost/`
every 30s, so `docker ps` reports container health.

Running without Docker
======================

The game is plain HTML/JS with no build step — open `index.html` in a browser,
or serve the directory with anything static:

```sh
python3 -m http.server 8080
```

Continuous Integration
======================

`.github/workflows/ci.yml` builds and pushes the image on every push to `main`:

 1. [`paulhatch/semantic-version`](https://github.com/PaulHatch/semantic-version)
    computes the next version. Commit messages prefixed `MAJOR:` or `MINOR:`
    bump those components; anything else is a patch bump.
 2. The new `vX.Y.Z` git tag is created and pushed.
 3. The image is built with Buildx and pushed to Docker Hub under three tags:
    `vX.Y.Z`, the commit SHA, and `latest`.

Requires two repository secrets: `DOCKERHUB_USERNAME` and `DOCKERHUB_TOKEN`.

Project Layout
==============

| Path | Purpose |
| --- | --- |
| `index.html` | The whole game — markup, styles and JS |
| `stats.js` | FPS/render stats overlay |
| `texture.jpg` | Background texture |
| `Dockerfile` | nginx:alpine image definition |
| `.dockerignore` | Keeps git/CI/docs metadata out of the image |

FUTURE
======

 * menu
 * animation and fx
 * levels
 * high scores
 * touch support
 * music and sound fx


License
=======

[MIT](http://en.wikipedia.org/wiki/MIT_License) license.
