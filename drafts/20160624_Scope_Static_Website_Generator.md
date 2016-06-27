# Scope: Static Website Generator

## Scope clones a GitHub repository that contains the posts of a site in markdown format. That content get sandwiched between the HTML header and footer that you specify so that creating your own theme is a breeze.

### Features
- Pulls posts directly from a GitHub repo.
- Supports easy styling by modifying HTML header and footer
- Uses Scholdoc and MathJax to convert LaTeX markup to HTML for including equations in posts
- Optionally exports PDFs of posts using print-specific CSS and wktohtml
- Generates an RSS feed of post content
- Site search is implemented by Tipue
- Optionally automatically uploads site content to server via ssh and svc

### Motivation

Scope aims to be as simple as possible while allowing its users maximum flexibility.  Wordpress is a great platform for those publishing content written by multiple authors and those who can create their own themes or are happy with those provided by the community.  Try as it might to be simple, I still find the features of Wordpress to be distracting and I often spend hours trying to implement a single stylistic change to a theme. I was tired of struggling to create a child theme for Wordpress when I knew I could create my own HTML layout fairly easily provided the flexibility to implement any framework.  It is not uncommon for me to include equations in my posts so being able to use MathJax was also a must.

### Use Cases

In order to start using Scope, only a few global variables need to be changed.  These changes are made at the top of the build.sh script.

The typical use case where the user wants to create PDFs of their content and welcomes automatically uploading their site to a server
```
$bash build.sh --pdf -u
```
Another use case where a user might not want to generate PDFs and is not using GitHub to host the content of their posts.
```
$bash build.sh ~/Desktop/website-posts/ --nogit -u
```
The minimal use case where the user does not wish to create PDFs of their content, does not want to automatically upload their site to a server, but they are using GitHub to host the content of their site.
```
$bash build.sh
```
Note that Scope assumes a specific naming convention for the files it uses to create pages.  This is important for including the publication date on the archive page and for making sure that the archive page shows post titles in order from most to least recently published.  Consequently this convention also ensures that the content of the most recent post is what gets displayed on the root index.html page. Following the date should be an underscore and then the title of the post itself where each word is separated by an underscore.  The underscores will be replaced by spaces.  This is what will be listed on the archive page.

Naming convention:

YYYYMMDD_<post_title>.md

Top level pages should not follow this convention if it is not desired for them to be shown on the archive page. Links to top-level pages will need to be manually added to the menu or otherwise linked to as they will not be included in the archive.  At present, top-level pages are not searchable as they do not get indexed, but this will hopefully be fixed soon.

### Implementation


#### Clean up

Each time the build script is run it deletes all files from the previous time the script was ran and creates the root directory where the contents of the generated site will be saved.  


#### Cloning from GitHub

If you are not a Git or GitHub user this function can be overridden by using the "--nogit" flag and pointing the script to the directory where your markdown files are found.  

#### Scholdoc Markdown to HTML conversion


#### Copy site-dependent CSS and images


#### Create index.html for root of site


#### Build the archive page


#### Build top-level pages


#### Build search index


#### Build RSS feed


#### Build pages and optionally generate PDFs, EPUBS


#### Upload site to server
