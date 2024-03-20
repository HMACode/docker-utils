
# Docker-Utils
+ A cli containing basic commands, aiming to help simplify some docker related tasks. For now it only supports docker volume backup and restore. 
+ Cli is built using [Bashly](https://bashly.dannyb.co/). 


## Prerequisites
+ Must have docker installed (da).
+ On windows, you can install [Windows Subsystem for Linux](https://learn.microsoft.com/en-us/windows/wsl/install)   to run the command


## Install 

+ Clone the current repository
+ Add exec permission to script docker-utils, then add location to your path.
+ To get list of commands: 

````bash
docker-utils --help
docker-utils - Utilily commands for managing docker related tasks

Usage:
  docker-utils COMMAND
  docker-utils [COMMAND] --help | -h
  docker-utils --version | -v

Commands:
  backup    Backup a docker volume
  restore   Restore a volume using a backup file

Options:
  --help, -h
    Show this help

  --version, -v
    Show version number
````
