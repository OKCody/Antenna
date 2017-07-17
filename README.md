# Antenna

Antenna is contains the text contents and SVG assets required to build [codytaylor.cc](http://codytaylor.cc).

## Use

```
git clone https://github.com/OKCody/Pages
cd Pages
bash build.sh
```

New content should be written in Markdown and saved in Antenna/pages/

## Structure

```
Antenna/
└───drafts/
└───pages/
└──────site-assets/
│   │   │    by-black.svg
│   │   │    by.svg
│   │   │    cc-black.svg
│   │   │    cc.svg
│   │   │    github-black.svg
│   │   │    github.svg
│   │   │    photo.svg
│   │   │    twitter-blue.svg
│   │   │    twitter.svg
└───site/
└───top-level/
│   │   about.md
│   │   archive.md
│   │   license.md
│   .gitignore
│   build.sh
│   example.html
│   head.html
│   stylesheet.css
│   tail.html
```

Site-dependent assets should be stored in "pages/site-assets/".  These will be copied to "site/site-assets/" by build.sh and will be accessible by the correct path if authoring in "pages/".

