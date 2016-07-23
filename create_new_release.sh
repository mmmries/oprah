version=$1
if [ -z "$version" ]
  then
    echo "please provide a version: ./create_new_release.sh 0.0.2"
    exit 1
fi

brunch build --production
docker build -t hqmq/oprah:$version .
docker push hqmq/oprah:$version
git tag v$version
git push
git push --tags
