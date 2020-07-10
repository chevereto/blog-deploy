# !/usr/bin/env sh

set -e

if [ -f "./config.sh" ]; then
    . ./config.sh
    echo 'Using config.sh'
else
    . ./config.sh.dist
    echo 'Using config.sh.dist'
fi

if [ "$1" = 'prod' ] && [ "$2" != 'true' ]; then
    echo -n "Are you sure to going production without sourcing blog repo? It will source from ./blog (y/n)? "
    read answer
    if [ "$answer" != "${answer#[Nn]}" ]; then
        echo 'Ok no worries...'
        exit 1
    fi
fi

if [ "$2" = 'true' ]; then
    if [ -d "blog" ]; then
        cd blog
        if [ "$(git config --get remote.origin.url)" != "$GIT_BLOG" ]; then
            echo "Blog repo changed!"
            rm -rf -- "$(pwd -P)" && cd ..
            git clone $GIT_BLOG
        else
            git reset --hard
            git pull
            cd -
        fi
    else
        git clone $GIT_BLOG
    fi
else
    echo 'Skipping blog sourcing...'
fi

yarn

if [ "$1" = 'dev' ]; then
    echo 'yarn: Dev VuePress'
    yarn dev
fi

if [ "$1" = 'prod' ]; then
    echo 'yarn: Build VuePress'
    yarn build

    cd blog/.vuepress/dist

    if [ -z "$CNAME" ]; then
        echo 'CNAME: None'
    else
        echo 'CNAME: created at blog/.vuepress/dist'
        echo $CNAME >CNAME
    fi

    git init
    git add -A
    git commit -m 'deploy'
    git push -f $GIT_HOSTING master

    cd -
fi
