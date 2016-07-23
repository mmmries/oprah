version=$1
if [ -z "$version" ]
  then
    echo "please provide a version: ./create_new_release.sh 0.0.2"
    exit 1
fi

ssh oprah.riesd.com "sudo docker pull hqmq/oprah:$version && sudo docker tag -f hqmq/oprah:$version oprah:current && ./oprah_migrate.sh && ./oprah_start.sh"
