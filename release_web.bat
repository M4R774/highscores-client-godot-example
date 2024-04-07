Rem As of Godot 4.0, CLI building is not working
Rem godot --version
Rem godot --export HTML5

Rem -a is for .zip file
Rem -c is for creating an archive
Rem -f is for archive filename
Rem -C my_directory . makes that the contents are directly at the root of the
Rem      archive, not inside Builds folder

cd builds\web\latest
tar.exe -caf ../latest.zip *
cd ..
butler push latest.zip martta/ldjam55:html5
