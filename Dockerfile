######## INSTALL ########

# Set the base image
FROM mcr.microsoft.com/windows:1909

# Set alternative shell
SHELL ["powershell"]

# Set environment variables
ENV HOME "c:\krp-server"

# Create system user
RUN New-LocalUser -Name "krp-server" -NoPassword -AccountNeverExpires -UserMayNotChangePassword | Set-LocalUser -PasswordNeverExpires $true

# Switch to user
USER krp-server

# Create SteamCMD directory
RUN New-Item -ItemType Directory $HOME

# Set SteamCMD working directory
WORKDIR $HOME

# Download and install Kart Racing Pro
RUN Invoke-WebRequest http://95.216.172.205/krp-rel13e.zip -O c:\krp-server\krp-rel13e.zip; \
    Expand-Archive c:\krp-server\krp-rel13e.zip -DestinationPath c:\krp-server; \
    Remove-Item c:\krp-server\krp-rel13e.zip

# Set default command
ENTRYPOINT c:\krp-server\kart.exe