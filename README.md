## Setting up PC for Github Tutorial

First, install git bash. Once you have it installed, use this to clone the repo. By default the location it will be stored is C:/Users/YOURUSERNAME/magmml3-judge-repo

```git clone https://github.com/nstbayless/magmml3-judge-repo```


Then from there, if you ever want to push any changes to what's here, do this, ignoring stuff in parenthesis:


```cd magmml3-judge-repo``` (Only do this if you've just launched up git bash)

```git add --all``` (this adds every file you've changed to the remote repository)

```git commit -m "Comment what you've changed about the project as a whole here"``` (This effectively packet your changes into what you will push)

```git pull``` (This updates your own repository to the remote except your changes. If you happen to work on the same individual file as someone else you might run into a merge conflict. In a best-case scenario git will add the changes together, so to speak, but if the changes are too close together you might run into an unmergeable conflict...which I still don't entirely know how to work around because it's gross and ugly but we'll cross that bridge when we come to it. Long story short, so long as you work on seperate files from those others are working on, or if working on the same file you coordinate your changes with someone else by communicating with them, this should rarely happen.)

```git push``` (This pushes all commits you have to the remote repository)


If you ever want to grab changes made without pushing anything, just use ```git pull```.


To switch branches (the default it will set you to should be master), use:

```git fetch origin XXX:XXX; git checkout XXX```, where `XXX` is one of the following:

- `master`: The intended final product of the game. If you want to implement something destined for the final product of the game, make sure it is eventually merged or cherry-picked into this branch.

- `judge-build`: A temporary branch. Changes should be made here only if they are intended for the judge build. If a change needs to be made to both the `master` branch and `judge-build`, it can be put here and then merged into master. **Never merge any of the other branches into `judge-build`.**

- `dev-scratchpad`: development build for working on objects before cherrypicking them to master. It should also start up *much* faster than master so even after judging is finished, it's recommended to work on your objects, code, and assets here, then move them to master once they're mostly complete.

- `pit` pit-of-pits-specific build until judging is complete.


## Lightweight mode

To get fast (sub-minute or 30 seconds even) load/save/compile times for GML, you need to run the script `listUnreferenced.py` to generate a lightweight version of the project file.

1. Make sure python3.5 or above is installed and is on the PATH.
2. Open the Windows command prompt (not git bash) in the `meta/` folder of the project. (shift+right click in windows explorer and select the command prompt option.)
3. run the following: `python3 ./listUnreferenced.py ../MaGMML3.project.gmx --generate-lightweight`
	- if `python3` is not found, try `python` or `python3.5` or `python35`. Ensure one of these is on the PATH.
4. open `lw_MaGMML3.project.gmx`
5. After confirming this works, simply run 'Generate Lightweight Project.bat', for any subsequent time you need to generate the lightweight build.

This new `.project.gmx` file is gitignored so that you can't commit it. However, changes to any existing resources will be committed in git.
**If you add a new resource**, you will need to copy it manually to the usual `MaGMML3.project.gmx` file. 
(Future R&D may provide a way for this step to be automated.)
