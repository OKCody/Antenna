My interest in [Markdown](https://daringfireball.net/projects/markdown/) came about at a time when I was considering platforms which the OER initiative I work on should support.  I was looking at [OER Commons](https://www.oercommons.org/), [Wordpress](https://www.oercommons.org/), [Pressbooks](https://pressbooks.education/), [Connexions](https://cnx.org/), even plain HTML as host platforms of OER and wasn't thrilled about any of them. While I explored these I developed a list of criteria that I used to judge the suitability of them. I was looking for a platform that among other things,

 - Seamlessly supported equations in [LaTeX](https://www.latex-project.org/) markup
 - Was not unnecessarily complicated to use
 - Facilitated content being exported in a number of different formats

Despite being unnecessarily complicated to use I liked Markdown when I first learned about it, but I was skeptical of its practicality. I thought that I would never convince someone to use it who didn't discover its ease of use on their own.  In two years of evangelizing, I'm not confident that I have convinced anyone to adopt it the way I have. I am a dedicated Markdown user. From writing notes and reports at work, to documenting projects, composing Slack messages and Trello cards, the content of this website, I write Markdown every day. I love how portable it is. I love how memorable the syntax is. I love not wrestling with WYSIWYG editors, and I love having complete control over the documents I write.  

As it relates to OER authorship, I think that using Markdown makes good sense.  What follows is the argument that I delivered at the Open Textbook Summit in Vancouver, British Columbia last summer, at the Collective in Knoxville before that, and at OpenEd '18 in Anaheim, California last fall. I've written a [LibGuide on Markdown](http://guides.ou.edu/markdown) and [short bits](https://press.rebus.community/authoropen/chapter/case-study-university-of-oklahoma-libraries/) here and there about it, but it is time that it receives the attention it deserves here in long form. The argument begins with the [Open Content Definition](http://opencontent.org/definition) put forth by David Wiley.

> The terms 'open content' and 'open educational resources' describe any copyrightable work (traditionally excluding software, which is described by other terms like "open source") that is licensed in a manner that provides users with free and perpetual permission to engage in the 5R activities:

Summarized, these are:

1. Retain -- **the right to** make, own, and control . . .
2. Reuse -- **the right to** use content . . .
3. Revise -- **the right to** adapt, adjust, modify, or alter . . .
4. Remix -- **the right to** . . . make something new
5. Redistribute -- **the right to** share copies . . .

Notice that all of these are *permissions*.  They are *rights* that a user must have with respect to content in order for it to be considered "open" by Wiley's definition. He says, "Legal requirements and restrictions make open content and OER less open." The 5Rs get plenty of attention in the Open Education community, as they should; however, permission alone does not enable a user to reuse, revise, or remix content. In order for that to happen a user needs both *permission* and the *ability* to do so. Wiley addresses this too in the Open Content Definition though it seems to get much less attention.

## Permission ≠ Ability

> "While open licenses provide users with legal permission to engage in the 5R activities, many open content publishers make technical choices that interfere with a user's ability to engage in those same activities."

Many people familiar with OER and Creative Commons, have probably seen an image depicting a spectrum of CC licenses where they are arranged from most to least open. I think this illustration is useful for explaining CC licenses, but can stigmatize the use of the more restrictive licenses. While I personally believe there is an application for each of the CC licenses, strictly speaking it makes sense to arrange the licenses in this way though it is incomplete if we're using the spectrum to arrange objects that the licenses describe and not only the licenses on their own. How "open" a resource is, depends both on its license, and the technical decisions made by its creator. Taken together, I contend, that the openness of a resource depends as much on technical matters  as it does on the license applied to it.  Also in his Open Content Definition, Wiley describes some criteria to classify the technical openness of content. I have summarized them here in the form of questions.

### A. Access to Editing Tools:

> Is the open content published in a format that can only be revised or remixed using tools that are extremely expensive or exotic?

### L. Level of Expertise Required:

> Is the open content published in a format that requires a significant amount of technical expertise to revise or remix?

### M. Meaningfully Editable:

> Is the open content published in a manner that makes it essentially impossible to revise or remix?

### S. Self-Sourced:

> Is the format preferred for consuming the open content the same format preferred for revising or remixing it?

This is known as the ALMS framework and it is a guide that describes how OER users are *able* to engage with open content.  Wiley says that it is, "not an argument for 'dumbing' down all open content to plain text. Rather it is an invitation to open content publishers to be thoughtful in the technical choices they make . . . "

I want to be clear that I think PDFs are great for distributing open content.  they are portable, and easy to read using countless free tools; however, there are a few downsides to distributing OER as PDFs only.  Anyone who has tried to modify a PDF has probably experienced difficulty trying to do so. Furthermore, the most common ways of creating PDFs involves costly, proprietary software, including Adobe Acrobat Pro, and Microsoft Word. Right before OpenEd '17 David Wiley tweeted the following and the responses succinctly summarize why open content should not only be distributed as PDFs.

![](../images/Wiley_Tweet.png)

![](../images/Allen_Tweet.png)

![](../images/Caufield_Tweet.png)

Enter Markdown, a minimalistic markup language released in 2004 by John Gruber, intended to be an easy-to-read and easy-to-write plain text format that can be converted to structurally valid HTML. As is the case with all plain text documents, it can be written in any text editor including those packaged with every major operating system, Notepad, TextEdit, and LeafPad. Other fully featured text editors such as [Atom](https://atom.io/) and [Notepad++](https://notepad-plus-plus.org/) offer features that make writing Markdown even easier such as syntax highlighting and preview panes. This is to say that Markdown as an authoring tool satisfies the A. in the ALMS framework.  As for the M, Plain text documents couldn't be more meaningfully editable. With liberties I contend that Markdown-created OER satisfy the S, as they are sort-of self-sourced. ––by that, I mean, that Markdown documents can serve as the source of self-sourced formats.  Put another way, Markdown can be converted into HTML, into ePubs, into Word documents, it can even be converted into a PDF (though not self-sourced themselves). It could be argued, that authoring in a format that is the source of multiple self-sourced formats is even better than authoring in only a single self-sourced format that cannot easily be converted into other formats. This brings us to the L of the ALMS Framework purposefully saved until now to motivate a discussion about tools used for working with Markdown.

## Web-Based Converter

Without adopting an online text editor, there aren't many good options for converting Markdown to other formats unless you are comfortable using a terminal. I understand that for most people, using a command line is an immediate turn off. To be honest, I was not proficient at navigating from the terminal until I started regularly using Markdown where I learned to use the terminal at the same time. [Pandoc](https://pandoc.org/) is perhaps the most powerful tool for converting documents of many types to many other types.  After discovering that Markdown is one of those types, it became my tool of choice for converting Markdown documents, but I knew that if I were to suggest that others use Markdown for authoring OER, the workflow could not involve use of a command line. Realizing this, I set out to develop a user interface to Pandoc.

![https://tools.libraries.ou.edu/markdown](../images/MD_Interface.png)

At least one plugin exists for Atom that will convert Markdown to other formats; however, having Pandoc installed is a dependency in order for it to function.  Even in this case, Pandoc must be installed via a terminal.  With this in mind I set out to develop an interface to Pandoc running on top of an environment where it is already installed. I consider the [web app](https://tools.libraries.ou.edu/markdown) that I produced more as a proof of concept than I do a tool users should rely on for their daily work. The idea behind it was that users could upload a Markdown file to the interface, select as many of the possible output formats as they like (HTML, PED, EPUB, DOCX), select a stylesheet, and then have their content converted to those file types and download within their browser in moments.

To discuss the process in depth, documents often contain more than text alone and for those assets to be included in the output documents, those assets must be included in the file provided to the interface. To do that users should zip their assets (images, and stylesheets) and their plain text document into a single compressed folder. Upload that, and the included assets will be included in the produced documents.  This allows users to upload custom CSS stylesheets should the provided few not be satisfactory. I also want to point out that equations in LaTeX syntax are rendered via [MathJax](https://www.mathjax.org/) and displayed in the output documents seamlessly.

Despite this tool being my first attempt at a web-based tool, and my first lines of PHP, I convinced my institution's library, my employer, to host the tool on their website so that I could show off the workflow as I presented it at conferences.  It worked well enough for that purpose, though it is not ideal for practical use. Firstly, it offers nothing in the way of a preview of your document. The preview on the page is meant to see what the stylesheets look like on generic content.  Not the specific content the user is interested in. In order to be practical, a user should be able to see a live preview of their content without having to zip and upload their materials each and every time. Secondly, the converter is web-based. –it requires an internet connection. **When thinking about OER I avoid assuming that users have a reliable internet connection.** One of the criteria I use to judge other Markdown tools is their ability to function offline so I've always known that this converter would only be a demonstration tool until I learned how to build something better.

## Browser-Based Converter

During the winter holiday of 2017, I began working on an [extension for the Chrome web browser](https://github.com/OKCody/MD_Ext). After all, in the logic I developed in the first converter, Markdown is always converted to HTML as an intermediate step before its final output format. It is at this point that CSS applies style, and MathJax renders equations. After all, nothing does HTML better than web browsers.  My idea was to leverage a browser window to display a live preview of a Markdown document being composed in a text editor of the users choice. Again, this was my first attempt at building a browser extension and my first lines of Javascript, but I managed to achieve the basic functionality of the extension before returning to work in the new year.

![https://github.com/OKCody/](../images/MD_Ext.png)

My idea was to create a tool with the same functionality of my original Markdown converter that renders a live preview of a document, with styling applied, that was also able to perform its conversions without being connected to the internet. This meant implementing the same logic as before, but in a completely different programming language. It watches a file for changes and re-renders the page when changes are detected. Changes to the file are only registered when the file is saved meaning that the preview is updated when changes are saved to the text file being watched.

This extension should be considered to be in an "alpha" state. It works well enough for me to use it regularly; however, I would like to work out a few more kinks before encouraging anyone else to do the same.  Nevertheless, it is available for download at [Github](https://github.com/OKCody/MD_Ext). At present, installing the latest version requires use of a command line:

Download the extension and all of its dependencies with,

```
git clone --recurse-submodules -j8 https://github.com/OKCody/MD_Ext.git
```

Open Chrome and navigate to,

```
chrome://extensions
```

Make sure that "Developer mode" is enabled in Chrome and then decompress the zip archive downloaded earlier and use "Load Unpacked" extension to install it. Of course, when it is ready to be released the installation process will happen within Chrome's Web Store making it very easy to install.

## Conclusion

![XKCD: Standards](https://imgs.xkcd.com/comics/standards.png)

A recurring topic within the OER community is one about what tools we should be using to create OER in order to maximize openness and ease of authorship.  PressBooks, Wordpress, LibreTexts, and OER Commons, among others seem to float to the top.  I understand the problem with competing standards. I do. In this case I think of HTML as the standard. It is the most portable and ubiquitous method for creating digital documents. HTML; however, is not that easy to write. Markdown provides an easy way of composing HTML instead of actually writing HTML. I think it could be argued that either of these tools I've developed could be considered platforms that might someday go unsupported and leave the community high and dry; though, I prefer to think of Markdown and tools for using it as functionalities that will soon come packaged within web browsers themselves. –a paradigm shift that will, fundamentally change the way the web itself works that will in turn change the way that open content is created and distributed.

Markdown is slowly infiltrating the web as a replacement for WYSIWYG interfaces. Slack, Trello, Github, Wordpress, all allow users to compose content in Markdown as an alternative to using a WYSIWYG editors. I think that the difficulties we've encountered as an open community regarding creating and sharing content are not problems of the community itself, rather they are flaws in the way that the web itself works. The team building [Beaker Browser](https://beakerbrowser.com/), a peer-to-peer web browser, are already working on solutions to this. If you are unfamiliar with Beaker or the peer-to-peer web, I recommend taking a look. After all, once your content has been written in Markdown it needs to be put on the web –a function that Beaker enables. I think that tools like Beaker and [Dat](https://datproject.org/) and [IPFS](https://ipfs.io/), will soon change the way that the web works and communities interested in open content will benefit from the paradigm shift those teams are pursuing.  

<center>
<iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/GC2QNMTG9kc?rel=0&amp;start=4122" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
</center>

## P.S.

The following chart represents [Google searches for the term "markdown"](https://trends.google.com/trends/explore?date=all&q=markdown) where the y-axis scale is relative to the maximum number of searches for a differential amount of time, not an absolute number. It has been 14 years since John Gruber released Markdown. I wonder what this same graph will look like in another 14 years. An [adoption curve](https://en.wikipedia.org/wiki/Technology_adoption_life_cycle) maybe?

![Google Trend: "markdown"](../images/Google_Trend_Markdown.png)

## Attribution

*The Open Content Definition and the ALMS framework are based on original writing by David Wiley, which was published freely under a Creative Commons Attribution 4.0 license at [http://opencontent.org/definition/](http://opencontent.org/definition/).*

*The XKCD comic "Standards" is an original creative work by XKCD and has been freely published under a Creative Commons Attribution-NonCommerical 2.5 license at [https://xkcd.com/927/](https://xkcd.com/927/).*






