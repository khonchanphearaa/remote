## Hash pwd 

Use hash password with bcrypt module

The ```Sudo#12haha!``` this password that want to hash  

```bash
node -e "console.log(require('crypto').createHash ? 'Use bcrypt module' : ''); const b = require('bcrypt'); b.hash('Sudo#12haha!', 10).then(console.log);"
```

## Runn script 

On ```Mac``` that make sure allow permissions exec file ```chmod +x ~/mac-pwd.sh``` 

```bash
~/mac-pwd.sh
```

On ```Window``` 

- Go to File > Save As
- Change "Save as type" to All Files (.)
- Name it window-pwd.bat
- To run it, just double-click the window-pwd.bat file.
