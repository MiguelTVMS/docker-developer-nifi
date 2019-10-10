# docker-developer-nifi
NIFI Container image to be used by developers.

The idea behind this docker image is to allow the developer to have the option to have the `flow.xml.gz` file stored locally while developing a new flow. The main advantage of this approach is that you can restart the container safely and even store the file in source code.

The major difference between the original NIFI Docker image and this image is a folder created inside the NIFI folder called `flow_conf` and mapped as a volume. This image is set to store the `flow.xml.gz` inside that folder. One question this raises is, why not use the `conf` folder volume? The problem with that volume is that it holds a lot more files than just the flow configuration files. And when running in windows some permission problems happen and NIFI cannot start correctly.

## How to use it

To run this image se the following command:

```bash
docker run -it --name developer-nifi -p "8080" -v "./flow_conf:/opt/nifi/nifi-current/flow_conf" jmtvms/docker-developer-nifi
```

This command will map a local folder called `flow_conf` to the `/opt/nifi/nifi-current/flow_conf` inside the container. When running all the changes made to the flows inside the NIFI will be stored locally. With that, you don't lose anything between container restarts. You can even use this nifi container as a development environment and store the `flow_conf` folder within your git repository.

## Available environment variables
Besides the original environment variables available inside the original [NIFI Docker image](https://hub.docker.com/r/apache/nifi), the following environment variables where added:

- `NIFI_FLOW_CONFIGURATION_FOLDER` - Indicates the path where the flow configuration files will be stored. The default value is `${NIFI_HOME}/flow_conf`. The `NIFI_HOME` environment variable is inherited from the original [NIFI Docker image](https://hub.docker.com/r/apache/nifi).
- `NIFI_FLOW_CONFIGURATION_FILE` - The full path used to store the flow configuration file. The default value is `${NIFI_FLOW_CONFIGURATION_FOLDER}/flow.xml.gz`.
- `NIFI_FLOW_CONFIGURATION_ARCHIVE_DIR` - The location where the flow archive folder will be created. The default value is `${NIFI_FLOW_CONFIGURATION_FOLDER}/archive/`. 
- `NIFI_FLOWSERVICE_WRITEDELAY_INTERVAL` - The time that will take to changes made in the flow to be persisted in the flow configuration file. The NIFI default value is `2 sec`, but this image default value is `1 sec`. The time is reduced for this image since the main reason is to persist the flow files on a local volume.

Here are the mapping between environment variables and properties inside the `nifi.properties` file.

| Property                             | Environment Variable                 |
| :----------------------------------- | :----------------------------------- |
| nifi.flow.configuration.file         | NIFI_FLOW_CONFIGURATION_FILE         |
| nifi.flow.configuration.archive.dir  | NIFI_FLOW_CONFIGURATION_ARCHIVE_DIR  |
| nifi.flowservice.writedelay.interval | NIFI_FLOWSERVICE_WRITEDELAY_INTERVAL |