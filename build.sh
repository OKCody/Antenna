
if [ -e site/ ];
then
  rm -rf site
  mkdir site/
else
  mkdir site/
fi

mkdir site/pages/
for filename in pages/*.md
do
  title=${filename##*/}
  title=${title:9}
  title=${title%.md}
  title=${title//_/ }
  title="<h1 class=\"title\">$title</h1>"
  pandoc $filename -o temp.html
  filename=${filename##*/}
  filename=${filename%.md}
  cat head.html > site/pages/$filename.html
  echo $title >> site/pages/$filename.html
  cat temp.html tail.html >> site/pages/$filename.html
  rm temp.html
done

# Important that this is run immediately after pages are generated so as to
# only select the most recent of these, not the top-most alphabetically of
# top-lever pages or others
cp $(ls site/pages/*.html | tail -1) site/index.html

for filename in top-level/*.md
do
  pandoc $filename -o temp.html
  filename=${filename##*/}
  filename=${filename%.md}
  cat head.html temp.html tail.html > site/$filename.html
  rm temp.html
done

touch temp.html
for filename in pages/*.md
do
  title=${filename##*/}
  title=${title:9}
  title=${title%.md}
  title=${title//_/ }
  echo -e "<h4><a href=\"${filename%.md}.html\">$title</a></h4>\n$(cat temp.html)" > temp.html
done
echo -e "<h1 class=\"title\">Archive</h1>\n$(cat temp.html)" > temp.html
cat head.html temp.html tail.html > site/archive.html
rm temp.html

if [ -e opti/ ];
then
  :
else
  mkdir opti/
fi
for filename in images/*.jpg images/*.png
do
  newfile=${filename##images/}
  newfile=${newfile:0:-3}jpg
  if [ -e "opti/$newfile" ];
  then
    :
  else
    echo $newfile
    convert $filename -resize x400 -quality 85 opti/$newfile
  fi
done

cp -r pages/site-assets site/site-assets
cp stylesheet.css site/stylesheet.css
mkdir site/images
cp images/* site/images/
mkdir site/opti/
cp opti/* site/opti/
cp -r tipuesearch/ site/tipuesearch
