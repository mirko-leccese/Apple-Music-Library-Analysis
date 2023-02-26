#!/bin/bash

# This script executes the "music-library-exporter" CLI to export the personal Apple Music Library to a given path. It can be
# automated with a Chron job to automatically extract the Library on a monthly basis.

# Defining main variable
current_extr=$( date +"%Y-%m-%d %H:%M:%S" )
current_year_month=$( date +"%Y%m" ) 
current_year=$( date +"%Y" )


filename="music_library_$current_year_month.xml"
path="/Users/mirkoleccese/Documents/PROJECTS/MUSIC/Apple-Music-Library-Analysis/LIBRARIES/$current_year/"

# check if directory exists, create it if not
if [ ! -d "$path" ]; then
   mkdir -p "$path"
fi

# Export library
music-library-exporter export --music_media_dir "/Macintosh HD/Utenti/mirkoleccese/Musica/Music/File multimediali" --output_path "$path/$filename"
