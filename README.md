# heroku-db-clone
Simple bash script that clone **Postgres** database from one Heroku app to another one. 

## General purpose

Basically, this tiny bash script might be used for copying database from **production** environment to **staging** to be able to play with real data without any harmful actions. For this case, notice that you might need to copy **S3 bucket or other services** that DB entities point to as well.

Generally, you can use this script when setting up several heroku apps for different environments, or you just simply want to clone database to another app. 
 
## Requirements
- [heroku-cli](https://devcenter.heroku.com/articles/heroku-cli) installed and authenticated.
- [aws-cli](https://aws.amazon.com/ru/cli/) installed and authenticated.
- You must be the **owner** or **collaborator** for both applications.

## Usage
```!bash
$ sh transfer_databases.sh 
```

## Tips
In case you got a permission error, just make it `executable`:
```!bash
$ sudo chmod 755 transfer_databases.sh  
```

## Misc

For any suggestions, help requests and contributing, just contact **vladimir.tagai@duniceedge.com**
