if [ -e "site/" ];
then
  rm -rf site/
else
  :
fi
bash build.sh
