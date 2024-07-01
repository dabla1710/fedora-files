# Automated Setup Script for a Project Zomboid Dedicated Server on Fedora 40 
# Author: Daniel Blaich https://www.github.com/0
# OS: Fedora 40
# Last Edit: 2024-06-29
# Feel free to edit this script this to your needs
# this should work on fedora and provide a custom install directory
# If you encounter an issues please submit a issue for   


function updateProjectZomboidServerApplication() {
  ./srcds_run -game 380870 -autoupdate
  chmod +x start_server.sh
  ls -la
}

function createUserToRunServer() {
  sudo adduser pzuser
  sudo mkdir -p /opt/pzserver
  sudo chown pzuser:pzuser /opt/pzserver  
  sudo -u pzuser -i
}

function createServerConfig() {
  echo "
    EOL
    // update_zomboid.txt
    //
    @ShutdownOnFailedCommand 1 //set to 0 if updating multiple servers at once
    @NoPromptForPassword 1
    force_install_dir /opt/pzserver/
    //for servers which don't need a login
    login anonymous
    app_update 380870 validate
    quit
    EOL
  " >> update_zomboid_server.txt 
}

# --- start script ---
read -p "Do you want to install the Project zomboid server ? [y/n]" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
  echo "Downloading and installing 'steamdcmd' ... doing dangerous stuff"
  # steamcmd dependencies
  sudo dnf install glibc.i686 libstdc++.i686 -y
  # create steamcmd directory
  mkdir -p ~/steamcmd && ( cd ~/steamcmd || (echo "Could not find steamcmd folder" && exit && return 1) )
  #download and execute steamcmd
  wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz
  tar -xvzf steamcmd_linux.tar.gz && rm steamcmd_linux.tar.gz
    # --- define directory here and update project zomboid server
  read -p "Do you want to install to default path: '/opt/pzserver' [y/n]" -n 1 -r
  echo ""
  if [[ $REPLY =~ ^[Yy]$ ]]
    then
      # user decision - default directory
      sudo mkdir -p /opt/pzserver
      cd ~/steamcmd/ || ( echo "Could not find steamcmd folder" && exit && return 1 )
      sh steamcmd.sh +force_install_dir "/opt/pzserver" +login anonymous +app_update 380870 validate +quit
      echo "--- Project Zomboid Dedicated Server installed & updated! ---"    # steamcmd enable autoupdate and run server
      # steamcmd enable autoupdate and run server
      cd /opt/pzserver || ( echo "Could not find pzserver folder" && exit && return 1 )
      updateProjectZomboidServerApplication
      createServerConfig
      createUserToRunServer;
    else
      # user decision - custom directory
      echo "Use absolute paths starting from root - e.g. '/home/$USER/.../pzserver'"
      echo ""
      read -p "Please enter path to directory:" custom_directory_path
      sudo mkdir -p "$custom_directory_path"
      cd ~/steamcmd/ || ( echo "Could not find steamcmd folder" && exit && return 1 )
      sh steamcmd.sh +force_install_dir "$custom_directory_path" +login anonymous +app_update 380870 validate +quit
      echo "--- Project Zomboid Dedicated Server installed & updated! ---"    # steamcmd enable autoupdate and run server
      # steamcmd enable autoupdate and run server
      cd $custom_directory_path  || ( exit && echo "Could not find steamcmd folder" && return 1 )
      updateProjectZomboidServerApplication
      createUserToRunServer
      createServerConfig
  fi # END if Do you want to install to default path: /opt/pzserver [y/n]
fi # End if Do you want to install the Project zomboid server [y/n] ?
