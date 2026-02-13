upload.sh is a collection of scripts to upload your files to as many providers as possible, using curl and other usually pre-installed linux utilities.  
check out [UploadTo](INSERT URL HERE), a sister program that does the same thing but for multiple providers at the same time and that is compilled, therefore working in other shells such as fish.  
# HOW TO INSTALL  
you can download a script for a specific provider with this command, where the name of the provider is everything before the first dot:

`curl -H 'Accept: application/vnd.github.v3.raw' -O -L https://api.github.com/repos/DaviCompai/upload.sh/contents/providers/<name of the provider (remove <>)>.sh`

Ensure that bin exists:

`mkdir ~/.local/bin`

Check that ~/.local/bin is linked:

`echo "$PATH" | tr ":" "\n"`

If it isn't, run this:

`echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc`

Make it executable:

`chmod +x <name_of_provider>`

Move the script to bin:

`mv <name_of_provider> ~/.local/bin/`

remember that you can change the name of the script to wathever you want, which will also change the command to use it

to install the 0x0 script (recommended for small files) and name it "upload":
```
curl -H 'Accept: application/vnd.github.v3.raw' -O -L https://api.github.com/repos/DaviCompai/upload.sh/contents/providers/0x0.sh
mkdir ~/bin
chmod +x 0x0.sh
mv 0x0.sh ~/.local/bin/upload
```
# PROVIDERS  
the provider name for the installation setup is everything before the first dot.

| provider | Upload | Download | Persistence   | Ads | Max size | Note |
| --------------- | ------- | -------- | ------------- | ---------- |---------------|--------|
| buzzheavier.com | Fast | Insane | 15 days | Yes | infinite | No direct download link, +3 persistence per download, supports notes |
| 0x0.st | Slow | fast | 30-365 days | No | 500 MB | persistence depends on size of file sent |
| termbin.com | Fast | Fast | 7 days | No | ~3kb | Only sends text|
| catbox.moe | Fast | Fast | Forever | No | 200 MB | please don't use this service unless you really need an upload to be permanent |
| litterbox.catbox.moe | Fast | Fast | up to 3 days | No | 1 GB | accepts 1h/12h/24h/72h for persistence |
# TODO:
- [x] add support for buzzheavier.com
- [ ] add support for termbox
- [ ] add support for catbox.moe
- [x] Add support for 0x0.st
- [ ] Add support for litterbox.catbox.moe
- [ ] make a "mega script" that unifies all scripts into one, allowing for easy provider switching without different commands/files.


Add support means having a basic -help flag and being able to upload a file trought the default "command file.example", with optional flags for providers-specific features (such as -i to show how many days a file lasts in 0x0, or a -n flag for adding notes to buzzheavier files)
# project organization/philosophy:
Due to the nature of bash scripts and a considerable amount of their value coming from their simplicity, the provider directory will be organized in the following way:  

Each provider will have their own bash script that works by itself.

If it is doable in bash, it should be done in bash (exceptions apply)

All CLI programs used should be considered default for a linux installation; even if the easiest response for the developer is to install something, you should still use the "defaultest" option.  

## flags:
-h / -help : usual help text.  
-i / -info: show extra information on the procedure when available  
-n / -note: change note to send with the file, when available  
-s / -simple: only receives a file and gives out a link, with no other interaction. useful for scripting.  
