mkdir www

# download data from github
curl -L -o www/maps.zip \
https://api.github.com/repos/adelevie/tv-broadcast-maps/zipball

# unzip data
unzip www/maps.zip -d www/

# delete old zipfile
rm -rf www/maps.zip

# get the name of the folder
OLD_FOLDER_NAME=$(ls www/ | head -1)

# create new directory
mkdir www/maps

# move data to new directory
mv www/$OLD_FOLDER_NAME/json/ www/maps

# delete old copy of data
rm -rf www/$OLD_FOLDER_NAME

cp data/state-outlines.js www/state-outlines.js

ruby render.rb

echo "To view these in your browser, run 'node dev-server.js'."