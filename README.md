# Apple-Music-Library-Analysis

Do you ever have doubts about the accuracy of your streaming habits on Apple Music Replay? Fear not, because you now have the power to analyze your own library and create customized charts using this GitHub repository. Inspired by Jeff's article on Medium about [iTunes Library analysis using Pyhon](https://leojosefm.medium.com/python-analyzing-itunes-library-97bec60e13cb), I've taken the idea even further by developing a fully automatic pipeline for analyzing your music habits, made possible by the invaluable [music-library-exporter](https://github.com/kylekingcdn/music-library-exporter) script developed by kylekingcdn. With the following user-friendly instructions, you can dive right in and start exploring your Apple Music library in no time. 

## Installation
Apple Music Library information (songs saved in our library with play count, album or artist info, etc) is an XML file that can be generated directly from the Apple Music app on your Mac, as follows:

![How to export the XML file](img/export_library.png)

The play count is definetely the single key information if we want to analyze our streaming habits. In the XML file we just have the total number of times we have played a given song to the time we are exporting the library. Therefore, to analyse our streaming over times we need to export multiple times (on a weekly or monthly basis, or even daily if desired!) the library and build a dataset of differences. Manually exporting the XML can be annoying, and unfortunately automatically Apple Music Library export using native Apple Automation is not currently supported. However, luckily there exists scripts such the above cited music-library-exporter which can be automated, e.g. using a Chronjob. In the following we will describe step-by-step how to set up a workflow to extract and analyze over time your Apple Music Library.

First, clone this Github repo in a local folder 
```
git clone https://github.com/mirko-leccese/Apple-Music-Library-Analysis.git
```
You will get a copy of the current GitHub repository, with the following content:
- ```export_library.sh```: a Bash script that runs the music-library-exporter and save the exported XML files in a given path;
- ```LIBRARIES```: We are going to save our exported XML files in this folder called *LIBRARIES*, organized in distinct years subfolders;
- ```my_apple_music_library_analysis.ipynb```: a Jupyter Notebook that parse the XML files, build a Pandas dataframe with streaming information and analyze our Apple Music Library producing simple but efficient data visualization to identify our most streamed songs or albums, our favorite artists and much more. 

Once you have cloned this repo, follow the instructions of kylekingcdn to insall their ```music-library-export```(https://github.com/kylekingcdn/music-library-exporter). 

Open the ```export_library.sh``` and modify absolute paths:
```{bash}
#!/bin/bash

# This script executes the "music-library-exporter" CLI to export the personal Apple Music Library to a given path. It can be
# automated with a Chron job to automatically extract the Library on a monthly basis.

# Defining main variable
current_extr=$( date +"%Y-%m-%d %H:%M:%S" )
current_date=$( date +"%Y-%m-%d" )
current_year_month=$( date -v-1d +"%Y%m" ) 
current_year=$( date -v-1d +"%Y" )


filename="music_library_$current_date.xml"
path="[YOUR_PATH]/Apple-Music-Library-Analysis/LIBRARIES/$current_year/"

# check if directory exists, create it if not
if [ ! -d "$path" ]; then
   mkdir -p "$path"
fi

# Export library
/Users/[YOUR_USER]/bin/music-library-exporter export --music_media_dir "[YOUR_MUSIC_LIBRARY_PATH]" --output_path "$path/$filename"

sleep 5

echo "-------------------------------------------------------------------------------------------"
echo "SUCCESS!! $current_extr: $filename correctly written to --> $path" | tee -a extraction.log
echo "-------------------------------------------------------------------------------------------"
```


