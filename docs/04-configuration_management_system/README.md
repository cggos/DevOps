# CMS - Configuration Management System

-----

[TOC]

## Source Code Repository

## CI - Continuous Integration

* [Jenkins](https://jenkins.io/): Build great things at any scale
* [HUDSON](http://hudson-ci.org/)
* [Apache Continuum](http://continuum.apache.org/): Continuous Integration and Build Server
* [Travis CI](https://travis-ci.org/): Test and Deploy with Confidence
* [AppVeyor](https://www.appveyor.com/): Continuous Integration solution for Windows and Linux
* [GoCD](https://www.gocd.org/): EASILY MODEL AND VISUALIZE COMPLEX WORKFLOWS WITH GoCD, A FREE AND OPEN SOURCE CONTINUOUS DELIVERY SERVER.

## VCS - Version Control System

* [CVS - Concurrent Versions System](http://www.nongnu.org/cvs/) is a version control system, an important component of **Source Configuration Management (SCM)**
* [TortoiseCVS](http://www.tortoisecvs.org/): lets you work with files under CVS version control directly from Windows Explorer
* [RabbitVCS](http://rabbitvcs.org/) is a set of graphical tools written to provide simple and straightforward access to the version control systems you use.
* [Mercurial (hg)](https://www.mercurial-scm.org/) is a free, distributed source control management tool.
* SVN
  - TortoiseSVN
* ClearCase
* MS SourceSafe（VSS）

### wstool

[wstool](https://www.mankier.com/1/wstool) is a command to manipulate multiple version controlled folders, using it you can update several folders using **a variety SCMs (SVN, Mercurial, git, Bazaar)** with just one command

### vcstool

[Vcstool](http://wiki.ros.org/vcstool) is a version control system (VCS) tool, designed to make working with multiple repositories easier.

vcstool provides commands to manage several local SCM repositories (supports git, mercurial, subversion, bazaar) based on a single workspace definition file (.repos or .rosinstall).

vcstool replaces wstool. In contrast to wstool it doesn't have any state beside the working directories of the repositories in the file system.

For compatibility with rosinstall_generator is can read .rosinstall files. The file format of .repos files generated by vcs export provides stricter guarantees (e.g. that all entries are collision free when fetching them).

* install
  ```sh
  sudo apt install python3-vcstool
  # or
  sudo pip install -U vcstool
  ```

* Create a Workspace
  ```sh
  mkdir -p ~/ros_ws/src
  cd ~/ros_ws
  ```

* Populate the Workspace from a **.rosinstall** File ([rosinstall format](https://docs.ros.org/en/independent/api/rosinstall/html/rosinstall_file_format.html))
  ```sh
  vcs import src < PATH_TO_ROSINSTALL_FILE.rosinstall
  ```

* Updating the Workspace
  ```sh
  vcs pull src
  ```
  