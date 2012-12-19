Name
----

purge-history — a script to remove certain files from Git revision history

Synopsis
--------

    purge-history [-mo] [-b BRANCH] FILE...

Description
-----------

The **purge-history** script provides an easy way to remove certain files from all commits in a given Git branch. It can either remove selected files from the entire revision history, or conversely, preserve only some files and their revision history and obliterate the rest. The script also automatically follows file renames, and optionally discards empty merge commits to make sure that the resulting revision history is as clean as possible.

**purge-history** is a wrapper script around the **git filter-branch** command, and as such, it requires a working installation of **Git** and **GNU bash** to function.

Options
-------

* **-b** *branch* — Rewrite commits in the selected branch. To rewrite commits in all branches at once, use **-b ALL**. The default option is **HEAD**.
* **-m** — After rewriting the revision history, also delete all merge commits that are no longer needed.
* **-o** — Invert the default behavior and removes all files except those explicitly specified on the command line.
* **-h** — Display usage information and immediately terminates the script.
* **-v** — Display version information and immediately terminates the script.

Examples
--------

Imagine that your Git repository contains files named **build-tree.c** and **hash-object.c**. Also imagine that the **build-tree.c** file was originally named **helper.c**, but at some point you renamed it to something more self-explanatory. To remove these two files and their predecessors (in this case **helper.c**) from all commits in the current branch, use the following command:

    purge-history build-tree.c hash-object.c

Now imagine that you want to keep the revision history of the **build-tree.c** file and its predecessor, but permanently remove all other files from the current branch, including their previous renames and all those files that were present in the repository at some point, but no longer exist. To do so, use the **-o** command line option:

    purge-history -o build_tree.c

You can specify which branch to rewrite by using the **-b** command line option. For example, to remove the **build-tree.c** file and its predecessor from all commits in the **experimental** branch, type:

    purge-history -b experimental build-tree.c

To remove this file from all branches at once, specify **ALL** as the branch name:

    purge-history -b ALL build-tree.c

Copyright
---------

Copyright © 2012 Jaromir Hradilek

This program is free software; see the source for copying conditions. It is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

