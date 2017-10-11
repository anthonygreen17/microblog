#! /usr/bin/env bash
#
#
#  Adaptation of NTuck's nu_mart deploy.sh script to work for my microblog.
#

export PORT=8000
export PROJ_NAME="microblog"
DIR=$1

if [[ -z $DIR ]]; then
	printf "Plese supply a destination directory.\n"
	exit
fi

# if the directory doesnt exist, ask the user if they want to create it. if not, exit
if [ ! -d "$DIR" ]; then
   while true; do
        read -p "Destination directory $DIR doesnt exist. Create it?? [y/n] " yn
        case $yn in
            [Yy]* ) mkdir -p $DIR && printf "Created $DIR...\n" && break;;
            [Nn]* ) printf "Not creating directory." && exit;;
            * ) echo "Please answer yes or no.";;
        esac
	done
fi

if [ ! -d assets ]; then
	printf "Please execute script from the base of the $PROJ_NAME directory\n"
	exit
fi

echo "Deploying $PROJ_NAME to [$DIR]"

mix deps.get
(cd assets && npm install)
(cd assets && ./node_modules/brunch/bin/brunch b -p)
mix phx.digest
mix release --env=prod

# stop the server if it's running rn
[ -d $DIR/bin ] && $DIR/bin/$PROJ_NAME stop

mix ecto.migrate

SRC=`pwd`
(cd $DIR && tar xzvf $SRC/_build/prod/rel/$PROJ_NAME/releases/0.0.1/$PROJ_NAME.tar.gz)

PORT=$PORT $DIR/bin/$PROJ_NAME start
