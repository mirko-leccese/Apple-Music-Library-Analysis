!/bin/bash


current_extr=$( date +"%Y-%m-%d %H:%M:%S" )
current_year_month=$( date +"%Y%m" ) 
current_year=$( date +"%Y" )

echo $current_extr
filename="music_library_$current_year_month.xml"
echo $filename


path="/Users/mirkoleccese/Documents/PROJECTS/MUSIC/Apple-Music-Library-Analysis/LIBRARIES/$current_year/"
music-library-exporter export --music_media_dir "/Macintosh HD/Utenti/mirkoleccese/Musica/Music/File multimediali" --output_path "$path/$filename"
