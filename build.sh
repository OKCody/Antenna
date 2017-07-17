if [ -e site/ ];
then
  rm -rf site
  mkdir site/
else
  mkdir site/
fi

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
  cat head.html > site/$filename.html
  echo $title >> site/$filename.html
  cat temp.html tail.html >> site/$filename.html
  rm temp.html
done

# Important that this is run immediately after pages are generated so as to
# only select the most recent of these, not the top-most alphabetically of
# top-lever pages or others
cp $(ls site/*.html | tail -1) site/index.html

for filename in top-level/*.md
do
  pandoc $filename -o temp.html
  filename=${filename##*/}
  filename=${filename%.md}
  cat head.html temp.html tail.html > site/$filename.html
  rm temp.html
done

cp -r pages/site-assets site/site-assets
cp stylesheet.css site/stylesheet.css
