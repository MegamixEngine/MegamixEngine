Git is an optional way to keep up-to-date with changes made to the engine. Using git means you don't have to
go through the hassle of manually copying in engine changes or downloading a fresh copy of the engine

<!--more-->

## Which git client to download?

Download the git terminal interface: [https://git-scm.com/downloads](https://git-scm.com/downloads)

I would recommend **not** using a client with a GUI (graphical user interface). The reason a lot of
people want to use the GUI clients is because people are
afraid that they are going to somehow "mess up" with git and break the whole repository permanently. In reality, so long as you
commit frequently, it's very, very difficult to actually permanently break something.
Git is very good at storing your saved commits and not losing them.

So just use the [git terminal interface](https://git-scm.com/downloads). It's very simple,
despite the fact that you have to type commands. There are only
4 or 5 commands you really need to know, and you can always look them up if you forget.

When you download the terminal interface, it will also come with `git GUI`, a really buggy and
unfriendly graphical user interface. If you desperately want to use a GUI, use a different program
than this one.

**On Windows**, when installing, note that the default is to add some options to the right-click
context menu ("`Windows Explorer Integration`"). I would recommend having
`Git Bash Here` since it makes it easier to clone directories to the folder you want,
but **if it bothers you to have cumbersome additional right-click options,
make sure you uncheck both of these!**

## Initial setup

Give git your username and email address. These can be absolutely anything you like,
and do not have to be your real username or email address. Just so long as they're not blank, git will be happy.
However, people *will* be able to see these, so don't put anything embarrassing here.

```
git config --global user.name "My Username Here"
git config --global user.email "myemailaddress@example.com"
```

(Note that git will not give you a confirmation message when you enter these in. You can double-check
 that it took by typing `git config --global user.name` into the terminal.)

Also, we highly recommend changing the default text editor unless you want to wrestle with
`vim`, a text editor program renown far and wide for its incredibly dense user interface.

On Windows, the following command changes your editor to be notepad:

```
git config --global core.editor notepad
```

If you want a different text editor (e.g. notepad++), check out this guide on [StackOverflow](https://stackoverflow.com/questions/10564/how-can-i-set-up-an-editor-to-work-with-git-on-windows).

*Note: if you ever accidentally open vim, don't panic,
just press the escape key and type `:q!` and press enter to quit. Obviously.*

## How to download the engine with git

First navigate to the folder you want to download it to. (Type `pwd` in the console to make sure you're in the correct directory. If it says `/`, you will either need to use the `cd` command (e.g. `cd "Documents and Settings"`) or if you installed the "Windows Explorer Integrations" above, you can right-click on a folder on your computer and open git bash that way. The `ls` command is also helpful to display the contents of the current folder.)

Once you're in the desired folder, you can then type into the terminal:

```
git clone https://github.com/MegamixEngine/MegamixEngine.github.io
```

Swap out the URL in question for the URL of the repo you want to download. Note that
the windows git bash terminal is too good for `ctrl+v`; you must use `shift+insert` to paste.

If you later change your mind and want the repository to be located elsewhere, you can cut-paste the whole folder to somewhere else you prefer.
(Just make sure you don't miss the hidden `.git` subfolder!)

## How to hook up an existing project folder with git

If you downloaded the engine without using git, and you've made a lot of changes, then the process becomes a lot harder.
It's still possible, however. First, you need to know the version of the engine that downloaded. Then you need to
clone the engine as in the header above ("How to download the engine with git").

After the engine is cloned, open the engine directory in git bash and type this:

`git tag`

Scroll through these until you find the version that you downloaded. It's **very** important to note
exactly which one you downloaded! Next type this:

```
git reset --hard version-1.x
```

`version-1.x` should be replaced with the version tag you want.

Now, in your file browser, delete everything in the cloned repository folder (if you have show-hidden-files enabled, make sure you do not delete the hidden `.git` folder. If you don't see this folder, don't worry about it.)
Finally, copy the contents of **your** project into the cloned repository folder and then open git bash again. Type `git status` to see
a list of files that you have added, removed, or edited, and type `git diff` to manually inspect what lines have been added.
(Type `q` to close the `diff` window.)

At this point, you can commit your changes with `git add --all; git commit -m "began using git with project"`. Finally, you
can pull the latest changes made to the engine since the version you downloaded by typing

```
git pull origin master
```

Now this raises the possiblity of a *merge conflict*, which would be caused by you changing something
that was changed in a later version of the engine. Read through the remainder of the guide to learn how to deal with these.
It's important that merge conflicts be dealt with correctly, lest you encounter worse problems later on.

## How to make commits (save changes to the repo)

After you've edited the files you want to edit, saving changes to a repo is a four-step process:
(0) check everything is okay, (1) tell git what files to commit in the next commit, (2) tell git to make a commit, (3) download any changes made since you last downloaded, (4) upload the commit to git. There's a TLDR at the end.

**Step Zero**: Navigate to the top-level folder in the project and
run

```
git status
```

. It will list all the files that you've edited and also other useful miscellany
in a very readable format. This is a good thing to do every time
you want to commit, or any time you're confused because something is not working correctly. If there are
any unexpected messages at this step, stop and think.

**Step One**: You have to tell git which files should be commited. If you want to commit everything you've changed
(this is usually the case), just type

```
git add --all
```

in the top-level folder.

**Step Two**: You have to create the commit.

```
git commit
```

This will open up a text editor! It could open up vim if you didn't configure your text editor. If you accidentally open
vim (you'll know because the console will clear and everything will become horrible for you), don't panic, just press
the escape key and type `:q!` and then enter. Then try changing your editor above.

**Step Three**: Before you can upload your changes, you need to download any changes that have been made recently by your
team-mates:

```
git pull origin master
```

This could trigger a merge! If that happens, see the next section.

**Step Four**: It's finally time to upload your changes.

```
git push origin master
```

And you're done!

**TL;DR**:

```
git status
git add --all
git commit
git pull
git push
```

## Merging (AKA suffering)

There are four probable things that could happen when you pull. Either

- It will fail because you have uncommitted changes (*always commit before pulling!*),
- It will do nothing because nobody else has made changes,
- It will have to merge in other changes but there are no conflicts
- There will be conflicts and you'll have to handle them manually

We'll cover the last two cases.

### Clean merge (the easy case)

In this event, git will automatically make a merge commit.
It will just open up the text editor (see the above warning about vim!) and it will
provide you with a default commit message. There's no reason to change this; just save and close the editor.

### Merge conflicts (it's bad)

If git tells you there are conflicts, first do what you should always do in any uncertain situation:

```
git status
```

This will tell you what files need to be fixed. Then just open those files manually in a text editor
and search for these things:

```
<<<<<
```

These are conflict markers. A typical merge conflict will look like this:

```

Stuff that was automatically merged, blah blah blah

<<<<<<< MASTER

something your INCONSIDERATE TEAM-MATE did

=======

something YOU did that is much better obviously

>>>>>>> HEAD

More stuff that was automatically merged, blah blah

```

At the end of the day, you'll need to delete the `<<<<<<` markers or
your code won't work. However, you should *stop and think*. If necessary,
consult the team-mate who is caused the conflict that is now making your life miserable.

When you're done fixing up the merge commits (make sure you searched for every `<<<<<<` marker!), just enter this into the terminal:

```
git add --all
git commit
```

This will finalize the merge. Then you can go back to step three of pushing your changes in the previous section.

## How to avoid merge conflicts

There are two good ways to avoid merge conflicts:

1. Pull as often as you can! If you pull so frequently that no two people ever work on the same
file without having pulled the other's changes, then there will never be any merge conflicts, ever.
This isn't always practical -- sometimes two people will need to edit the same thing at the same time.
2. Edit as few files in as few places as possible. In particular, don't do something like find-and-replace or
reformat or beautify the entire code base without orchestrating it with your team-mates first. Also, try to avoid
renaming files unless you really need to -- this can sometimes confuse git.

## Other good practices

1. You can make commits as often as you like, even without pulling/pushing! Any time you make a commit,
that's a point that you can reset the project back to if needed (see below). The more frequently you commit,
the better an "undo" history you'll have access to.
2. Never commit sensitive data to a repository! Once it's on the repo, it's *very difficult* to remove. Even if
you replace something with a later commit, people will always be able to reset to your earlier commit. This
is also a good reason to think carefully before committing that 3-gigabyte AVI file to the repo as well.
3. You may also want to add a `.gitignore` file to your project if there are files you don't want to commit,
like backup files or compiled executables. Look this up on Google.

## Resetting to an earlier commit

There are two ways to undo changes in git. One way is to *reset* to a previous commit,
the other is to *revert* a commit, which is a more complicated concept and probably not what
you are looking for.

To reset to the most recent commit, just type:

```
git reset --hard
```

**BE CAREFUL!** This actually *is not reversible*. What you may want to do instead is to commit your changes and then
reset to the *previous* commit:

```
git add --all;
git commit
git reset HEAD~1
```

This will make sure you can still access your changes later (they won't be uploaded when you push, though.)

To reset to an even earlier commit, you will need to know the "SHA" of the commit. A SHA is just a
long ID or name for a commit, and it looks something like `8f8ab949` or `8f8ab94901afc39041fa3f447bb752dbb4036799`.
Use `git log` to list all the recent commits (up/down to scroll, `q` to quit), and when you find the one you want
to reset back to, just type `git reset --hard 8f8ab949` (just enter the first few digits of the SHA).

For reference, *reverting* a commit actually creates a *new* commmit that undoes the specified commit. This
is useful if you've already uploaded a change. You can look up how to use it; there are some gotchas. (Don't just
type `git revert 8f8ab949`! Instead type `git revert 8f8ab949..HEAD`.)

In general: if you want to undo something you've uploaded, use `git revert`, otherwise use `git reset` because
it's simpler.

## What comes next?

The above guide is for the basics. You'll probably learn a lot more by running into problems
and googling how to solve them. Once you've become a great enough master, you can learn how to use
branches and how to "rebase" commits as well.
