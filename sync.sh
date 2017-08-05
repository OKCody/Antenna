rsync -r -v --rsh="ssh -i /Users/tayl9634/.ssh/LightsailDefaultPrivateKey.pem" --rsync-path="sudo rsync" site/ ubuntu@codytaylor.cc:/var/www/html/
ssh codytaylor.cc 'sudo chmod -R 755 /var/www/html/*'
