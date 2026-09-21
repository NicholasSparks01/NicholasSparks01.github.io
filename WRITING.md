# Writing guide

This site is built with [Hugo](https://gohugo.io/) and the [Hextra](https://imfing.github.io/hextra/) theme,
and is deployed to GitHub Pages automatically on every push to `main`.

## Everyday workflow

```powershell
# 1. Create a page (opens it in VS Code)
.\new.ps1 post    "Reversing a Router Firmware Update"   # general blog post
.\new.ps1 writeup "Heap Overflow in FooLib Parser"       # vulnerability advisory template
.\new.ps1 note    "Frida Cheat Sheet" -Area reverse-engineering   # reference note

# 2. Preview locally with live reload (drafts included)
hugo server -D
#    -> http://localhost:1313/NicholasSparks01/

# 3. Publish: set `draft: false` in the front matter, then
git add . ; git commit -m "Post: Reversing a router firmware update" ; git push
```

About a minute after the push, the post is live.

## Where things live

```
content/
  _index.md                 Home page
  about.md                  About page
  blog/<slug>/index.md      Blog posts. Put images in the same folder.
  notes/<area>/<page>.md    Book-style reference notes with sidebar navigation
archetypes/                 Templates used by new.ps1
  blog/       (post)        writeup/  (advisory)        notes.md
assets/css/custom.css       Colors and style tweaks (change --primary-hue to re-theme)
static/images/              Logo and site-wide images
hugo.yaml                   Site settings: title, menu, features
```

## Front matter cheat sheet

```yaml
title: "Post title"
date: 2026-09-21
draft: true                     # false = published
description: "Shown in listings, search results and link previews."
tags: [Vulnerability Research, Reverse Engineering, Windows, Firmware]
```

Everything above `<!--more-->` becomes the summary on listing pages.

## Formatting

See the **Welcome** post (`content/blog/welcome-how-this-blog-works/index.md`) for working
examples of code blocks with filenames and highlighted lines, callouts, Mermaid diagrams, tabs,
collapsible sections, tables, math, and images. The full list of components is in the
[Hextra docs](https://imfing.github.io/hextra/docs/guide/shortcodes/).

For notes, organize pages into folders under `content/notes/`. Each folder needs an `_index.md`,
and `weight:` sets the order in the sidebar.

## One-time setup (already done on this machine)

- Hugo extended: `winget install Hugo.Hugo.Extended`
- The theme is a git submodule. After cloning on a new machine, run:
  `git submodule update --init --recursive`
- On GitHub: **Settings -> Pages -> Build and deployment -> Source = GitHub Actions**

## Updating the theme

```powershell
cd themes/hextra ; git fetch --tags ; git checkout v0.13.0 ; cd ../..
git commit -am "Update Hextra theme"
```

## Enable comments (optional)

1. Enable **Discussions** on the repo and install the [giscus app](https://github.com/apps/giscus).
2. Get `repoId` and `categoryId` from https://giscus.app.
3. Fill them in under `params.comments` in `hugo.yaml` and set `enable: true`.
