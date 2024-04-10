<a href="https://elest.io">
  <img src="https://elest.io/images/elestio.svg" alt="elest.io" width="150" height="75">
</a>

[![Discord](https://img.shields.io/static/v1.svg?logo=discord&color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=Discord&message=community)](https://discord.gg/4T4JGaMYrD "Get instant assistance and engage in live discussions with both the community and team through our chat feature.")
[![Elestio examples](https://img.shields.io/static/v1.svg?logo=github&color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=github&message=open%20source)](https://github.com/elestio-examples "Access the source code for all our repositories by viewing them.")
[![Blog](https://img.shields.io/static/v1.svg?color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=elest.io&message=Blog)](https://blog.elest.io "Latest news about elestio, open source software, and DevOps techniques.")

# Countly, verified and packaged by Elestio

[Countly](https://countly.com/) is a product analytics platform that helps teams track, analyze and act-on their user actions and behaviour on mobile, web and desktop applications.

<img src="https://github.com/elestio-examples/countly/raw/main/countly.gif" alt="countly" width="800">

Deploy a <a target="_blank" href="https://elest.io/open-source/countly">fully managed countly</a> on <a target="_blank" href="https://elest.io/">elest.io</a> if you want automated backups, reverse proxy with SSL termination, firewall, automated OS & Software updates, and a team of Linux experts and open source enthusiasts to ensure your services are always safe, and functional.

[![deploy](https://github.com/elestio-examples/countly/raw/main/deploy-on-elestio.png)](https://dash.elest.io/deploy?source=cicd&social=dockerCompose&url=https://github.com/elestio-examples/countly)

# Why use Elestio images?

- Elestio stays in sync with updates from the original source and quickly releases new versions of this image through our automated processes.
- Elestio images provide timely access to the most recent bug fixes and features.
- Our team performs quality control checks to ensure the products we release meet our high standards.

# Usage

## Git clone

You can deploy it easily with the following command:

    git clone https://github.com/elestio-examples/countly.git

Copy the .env file from tests folder to the project directory

    cp ./tests/.env ./.env

Edit the .env file with your own values.

Run the project with the following command

    ./scripts/preInstall.sh
    docker-compose up -d
    ./scripts/postInstall.sh

You can access the Web UI at: `http://your-domain:30247`

## Docker-compose

Here are some example snippets to help you get started creating a container.

    version: "3.7"

    services:
        mongodb:
            image: "bitnami/mongodb:latest"
            volumes:
                - "./mongodb_data:/bitnami"

        countly-api:
            user: 0:0
            image: "elestio4test/countly-api:${SOFTWARE_VERSION_TAG}"
            environment:
                - COUNTLY_PLUGINS=mobile,web,desktop,plugins,density,locale,browser,sources,views,logger,systemlogs,populator,reports,crashes,push,star-rating,slipping-away-users,compare,server-stats,dbviewer,times-of-day,compliance-hub,alerts,onboarding,consolidate,remote-config,hooks,dashboards,sdk,data-manager
                - COUNTLY_CONFIG__MONGODB_HOST=mongodb
                - COUNTLY_CONFIG_API_API_WORKERS=4 # CPU core count
                - COUNTLY_CONFIG__FILESTORAGE="gridfs"
                - NODE_OPTIONS="--max-old-space-size=2048"
            depends_on:
                - mongodb
            volumes:
                - ./mail.js:/opt/countly/extend/mail.js

        countly-frontend:
            user: 0:0
            image: "elestio4test/countly-frontend:${SOFTWARE_VERSION_TAG}"
            environment:
                - COUNTLY_PLUGINS=mobile,web,desktop,plugins,density,locale,browser,sources,views,logger,systemlogs,populator,reports,crashes,push,star-rating,slipping-away-users,compare,server-stats,dbviewer,times-of-day,compliance-hub,alerts,onboarding,consolidate,remote-config,hooks,dashboards,sdk,data-manager
                - COUNTLY_CONFIG__MONGODB_HOST=mongodb
                - NODE_OPTIONS="--max-old-space-size=2048"
            depends_on:
                - mongodb
        nginx:
            image: "bitnami/nginx"
            ports:
                - "172.17.0.1:30247:8080"
            volumes:
                - "./nginx.server.conf:/opt/bitnami/nginx/conf/server_blocks/countly.conf:ro"
            depends_on:
                - countly-api
                - countly-frontend

### Environment variables

|       Variable       | Value (example) |
| :------------------: | :-------------: |
| SOFTWARE_VERSION_TAG |     latest      |
|     ADMIN_EMAIL      | admin@email.com |
|    ADMIN_PASSWORD    |  your-password  |
|      FROM_EMAIL      | from@email.com  |

# Maintenance

## Logging

The Elestio countly Docker image sends the container logs to stdout. To view the logs, you can use the following command:

    docker-compose logs -f

To stop the stack you can use the following command:

    docker-compose down

## Backup and Restore with Docker Compose

To make backup and restore operations easier, we are using folder volume mounts. You can simply stop your stack with docker-compose down, then backup all the files and subfolders in the folder near the docker-compose.yml file.

Creating a ZIP Archive
For example, if you want to create a ZIP archive, navigate to the folder where you have your docker-compose.yml file and use this command:

    zip -r myarchive.zip .

Restoring from ZIP Archive
To restore from a ZIP archive, unzip the archive into the original folder using the following command:

    unzip myarchive.zip -d /path/to/original/folder

Starting Your Stack
Once your backup is complete, you can start your stack again with the following command:

    docker-compose up -d

That's it! With these simple steps, you can easily backup and restore your data volumes using Docker Compose.

# Links

- <a target="_blank" href="https://github.com/Countly/countly-server">Countly Github repository</a>

- <a target="_blank" href="https://support.count.ly/hc/en-us">Countly documentation</a>

- <a target="_blank" href="https://github.com/elestio-examples/countly">Elestio/Countly Github repository</a>
