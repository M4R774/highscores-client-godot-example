Rem As of Godot 4.0, CLI building is not working
Rem godot --version
Rem godot --export HTML5

Rem -a is for .zip file
Rem -c is for creating an archive
Rem -f is for archive filename
Rem -C my_directory . makes that the contents are directly at the root of the
Rem      archive, not inside Builds folder
cd Builds/HTML5
tar.exe -caf ../html5_executable.zip *
cd ..
butler push html5_executable.zip martta/online-highscore-demo:html5
