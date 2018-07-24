#!/bin/bash
info() {
    printf '%s\n' "$@"
}

info '' "NadekoBot Installer started."

if hash git 1>/dev/null 2>&1; then
    info '' "Git Installed."
else
    info '' "Git is not installed. Please install Git."
    exit 1
fi


if hash dotnet 1>/dev/null 2>&1
then
    info '' "Dotnet installed."
else
    info '' "Dotnet is not installed. Please install dotnet."
    exit 1
fi

root=/opt

cd "$root"

info '' "Downloading NadekoBot, please wait…"

[[ -z $1 ]] && branch=$NADEKOBOT_DEFAULT_BRANCH || branch=$1
git clone -b $branch --depth 1 --recursive https://github.com/Kwoth/NadekoBot.git

info '' "NadekoBot $1 downloaded." '' "Downloading Nadeko dependencies…"
cd $root/NadekoBot
dotnet restore
info '' "Download done." '' "Building NadekoBot…"
#dotnet add /opt/NadekoBot/src/NadekoBot package ImageSharp --version 1.0.0-alpha9-00194 --source https://www.myget.org/F/imagesharp/api/v3/index.json
dotnet build --configuration Release
info '' "Building done." "Installation Complete."
exit 0
