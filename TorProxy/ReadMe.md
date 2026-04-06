# TorProxy

## Purpose

[TorProxy](https://github.com/anionDev/TorProxy) is a docker-image for running a hidden service in a docker-container.

The currently used Tor-version is 0.4.8.19-1.

## Usage

### Volumes

Using volumes is not required. There are 2 optional volumes:

- `/var/log/tor`
- `/var/lib/tor/<hiddenservicename>`

### Environment-variables

The following environment-variables are supported:

- `hiddenservicedir`
- `hiddenserviceport`
- `hiddenserviceaddress`
- `lognotice`
- `logdebug`

All of these environment-variables are required.

### Example

See [`docker-compose.example.yml`](https://github.com/anionDev/TorProxy/blob/main/TorProxy/Other/Reference/ReferenceContent/Examples/MinimalDockerComposeFile/docker-compose.yml) for an example how to use this image.

## Additional stuff

After running this container, take a look at the tasks listed at [community.torproject.org/relay/setup/post-install](https://community.torproject.org/relay/setup/post-install).

## Development

### Development-state

![Development-state](https://img.shields.io/badge/development--state-maintenance%20updates%20only-green)

### Branching-system

This repository applies the [GitFlowSimplified](https://projects.aniondev.de/PublicProjects/Common/ProjectTemplates/-/blob/main/Conventions/BranchingSystem/GitFlowSimplified/GitFlowSimplified.md)-branching-system.

### Image-properties

The image-build-artifacts of this repository implement the [DefaultImageUsabilityRequirements](https://projects.aniondev.de/PublicProjects/Common/ProjectTemplates/-/blob/main/Conventions/ImageProperties/DefaultImageUsabilityRequirements/DefaultImageUsabilityRequirements.md)-branching-system.

### Project-Structure

This repository applies the [CommonProjectStructure](https://projects.aniondev.de/PublicProjects/Common/ProjectTemplates/-/blob/main/Conventions/RepositoryStructure/CommonProjectStructure/CommonProjectStructure.md)-project-structure.

### Versioning-system

This repository applies the [SemVerPractise](https://projects.aniondev.de/PublicProjects/Common/ProjectTemplates/-/blob/main/Conventions/Versioning/SemVerPractise/SemVerPractise.md)-versioning-system.

## License

See [License.txt](https://github.com/anionDev/TorProxy/blob/main/License.txt) for license-information.
