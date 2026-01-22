upload.sh is a collection of scripts to upload your files to as many providers as possible, using curl and other usually pre-installed linux utilities.  
check out [UploadTo](INSERT URL HERE), a sister program that does the same thing but for multiple providers at the same time and that is compilled, therefore working in other shells such as fish.  
# HOW TO INSTALL

# PROVIDERS

| provider | Upload | Download | Persistence   | Ads | Max size | Note |
| --------------- | ------- | -------- | ------------- | ---------- |---------------|--------|
| buzzheavier.com | Fast | Insane | 15 days | Yes | infinite | No direct download link, +3 persistence per download, supports notes |
| 0x0.st | Slow | fast | 30-365 days | No | 500 MB | persistence depends on size of file sent |
| termbin.com | Fast | Fast | 7 days | No | ~3kb | Only sends text|
| catbox.moe | Fast | Fast | Forever | No | 200 MB | please don't use this service unless you really need an upload to be permanent |
| litterbox.catbox.moe | Fast | Fast | up to 3 days | No | 1 GB | accepts 1h/12h/24h/72h for persistence |
# TODO:
- [ ] add support for buzzheavier.com
- [ ] add support for termbox
- [ ] add support for catbox.moe
- [x] Add support for 0x0.st
- [ ] Add support for litterbox.catbox.moe
- [ ] Add a flag to get more info on the upload (when available) besides the link
- [ ] Add a options flag for toggleable things (eg if link is copyed to the clipboard or not)
- [ ] add a provider change in the options flag
- [ ] add a flag for notes
- [X] add and format a help flag

# project organization/philosophy:
Due to the nature of bash scripts and a considerable amount of their value coming from their simplicity, this will be a single file project that is organized in the following way:  

Each provider will have their own bash script that works by itself.

If it is doable in bash, it should be done in bash (exceptions apply)

All CLI programs used should be considered default for a linux installation; even if the easiest response for the developer is to install something, you should still use the "defaultest" option.  

## flags:
-h / -help : usual help text.  
-p / -provider: sellect which provider to use. format: -provider:name_of_provider  
-i / -info: show extra information on the procedure when available  
-n / -note: change note to send with the file, when available  
-s / -simple: only receives a file and gives out a link, with no other interaction. useful for scripting.  
