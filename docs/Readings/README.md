# Phy426 Readings 2018

The class will do a number of weekly readings.  They will be handed in
by committing onto GitHub, and I'll check them periodically to make sure
you are doing them/keeping up w/ material.

In order for me to grade these, you will have to edit the files in this
repository and "commit" them.  This shouldn't be too hard, but will
require a bit of work to set up.  

## Step 1: Sign up for github account.

If you don't already have a [github](https://github.com) account, sign up
for one.  

## Step 2: Get a git client for your machine

Git is the software that does version control.  It allows you to work
with "git repositories" and save "commits" of your work.  These repositories
can be synced with `https://github.com` so I can see your work.  

I can't really help you with getting a git client for your machine, but
`git` clients are extremely easy to look
up online for any architecture.  On a mac I do `brew install git`.  

I  exclusively use a command-line client. You can also use a
[GUI git client](https://git-scm.com/downloads/guis/).  

## Step 3: Clone this repository onto your local machine

See the instructions [here](https://help.github.com/articles/cloning-a-repository/)

But basically, you get an address for this repository from the green "Clone
or Download" button, and then:

```
git clone https://github.com/jklymak/Phy426Readings2018.git
```

This will save the directory `Phy426Readings/` into your local directory.  

Currently this looks like:

```
ls
README.md  Week01.md  Week02.md
```
This should also have created a remote repository on github for you (you
will likely have been asked for your password etc) at
`https://github.com/YOURNAME/Phy426Readings2018`

## Step 4: Answer the questions in `Week01.md`

Use a text editor to answer the questions in `Week01.md`.

## Step 5: Commit your work

At any stage, commit your work:

```
git commit -a -m "Edits to Week01.md"
```

You can see your commits by doing:

```
git log

commit 973467ec661dbcf07b4d94cc600eae012f9cb1ed (HEAD -> master, origin/master, origin/HEAD)
Author: Jody Klymak <jklymak@gmail.com>
Date:   Fri Dec 15 15:33:21 2017 -0800

    Initial commit
```

## Step 6: Push your commit up to github

If you are done committing, you can push:

```
git push origin master
```

Will push any commits you've made up to your copy of the assignments.  You
can check github that they have been changed by going to:
`https://github.com/YOURNAME/Phy426Readings2018`

# More advanced stuff

I will more than likely change/update the readings.  This gets a little
tricky, but is easy to deal with if I only update readings you haven't
made commits on (so I'll try and stay far ahead).  If this happens,
you will have to
[add an upstream remote](https://help.github.com/articles/configuring-a-remote-for-a-fork/)

```
git remote add upstream https://github.com/jklymak/Phy426Readings2018
```

Now if you do:

```
$git remote -v

origin	https://github.com/YOURUSERNAME/Phy426Readings2018.git (fetch)
origin	https://github.com/YOURUSERNAME/Phy426Readings2018.git (push)
upstream	https://github.com/jklymak/Phy426Readings2018.git (fetch)
upstream	https://github.com/jklymak/Phy426Readings2018.git (push)
```

To get my changes onto your local machine:

```
git fetch upstream master
```

To make your version the same as my version, modulo any changes you
have made: ([See this link as well](https://www.atlassian.com/git/articles/git-forks-and-upstreams))

```
git rebase upstream/master
```

This *should* just work.  If there are conflicts, it means that you and I
both edited a file since you last "rebased". You can attempt to resolve the
conflict, but this proceedure is a [bit arcane](https://help.github.com/articles/resolving-a-merge-conflict-using-the-command-line/)

```
git rebase --abort
```
and contact me.  If it happens a lot, we will come up w/ a solution.
