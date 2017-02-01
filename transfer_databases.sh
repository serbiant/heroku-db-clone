command -v aws > /dev/null 2>&1 || { echo "aws-cli is not installed. Aborting." >&2; exit 1; }
command -v heroku > /dev/null 2>&1 || { echo "heroku is not installed. Aborting." >&2; exit 1; }

echo "Enter heroku app name you are going to capture dump from:"
read app_from

echo "Enter heroku app name you are going to upload dump to:"
read app_to

echo "Capturing backup from the $app_from..."
heroku pg:backups:capture -a $app_from

echo "Downloading backup."
heroku pg:backups:download -a $app_from

echo "Cleaning database of the $app_to"
heroku pg:reset -a $app_to --confirm $app_to

echo "Creating AWS S3 bucket for dumps / looking for existing one.."

aws s3 mb "s3://${app_from}-dumps"

echo "Uploading dump to the AWS S3..."
aws s3 cp latest.dump s3://${app_from}-dumps/latest.dump

link=$(aws s3 presign s3://${app_from}-dumps/latest.dump)

echo "Pushing dump to the DB."
heroku pg:backups:restore $link -a $app_to DATABASE_URL --confirm $app_to

echo "Cleaning up latest.dump from local and AWS as well..."
rm -f latest.dump
aws s3 rm s3://${app_from}-dumps/latest.dump

echo "Done!"
