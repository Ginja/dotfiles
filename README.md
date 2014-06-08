#dotfiles

##Instructions

* Fork and clone to ~/dotfiles
```bash
# Swapping my username for yours
cd ~ && git clone https://github.com/Ginja/dotfiles.git dotfiles
```
* (Optional) Place and/or customize your <b>unhidden</b> files inside ~/dotfiles/
* (Optional) Decrypt any *.enc files with the secure.sh script
```bash
~/dotfiles/secure.sh decrypt ~/dotfiles/ssh/config.enc
# Enter password
``` 
* Use the dotfiles.sh script to symlink them back inside ~/
```bash
~/dotfiles/scripts/dotfiles.sh add
```

##Scripts

###dotfiles.sh
* Your dotfiles must be unhidden
* Any existing dotfiles will be backed up to ~/dotfiles/backups before they are removed
* Any folders will be created, and not symlinked
* The following folders and their contents are excluded: backups, .git, and scripts

```bash
Usage: dotfiles/scripts/dotfiles.sh [add|remove|redeploy|purge_backups]
```

###secure.sh
Before you commit, you can add senstive files to .gitignore and use the secure.sh script to commit an encrypted copy (ex: filename.enc).

```bash
Usage: dotfiles/scripts/secure.sh [encrypt|decrypt] [FILE]
```
