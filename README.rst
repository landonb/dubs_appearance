Dubsacks Vim — Appearance Plugin
================================

About This Plugin
-----------------

This plugin configures the appearance of Vim.

- The beautiful `Hack
  <https://github.com/chrissimpkins/Hack>`__
  Regular 9 font, falling back to Courier New 9.

- A 3-Column wide grey vertical long-line indicator over columns 78-80.

  - See `dubs_edit_juice's <https://github.com/landonb/dubs_edit_juice>`__
    ``<F2>`` mappings for paragraph formatting.

- Use ``<Ctrl-c>`` to exit Insert mode, and to enter Command mode, same as ``<ESC>``.

- Use ``<Ctrl-c>`` to copy text in the command-line window.

- Enable syntax highlighting.
  
- Show line numbers.

- Show new buffers with all folds open.

  (Hint: Use ``<zR>`` and ``<zM>`` to open and close all folds,
  respectively, and ``<zA>`` to toggle a single fold).

- Better search defaults:

  - Case-insensitive searching and matching (``:smartcase``).

  - Enable search term highlighting (``:hlsearch``).

  - Highlight search results as the keyword is typed (``:incsearch``).

- Enable ``modeline``: Vim will read modelines at the head or tail,
  like ``vim:tw=78:ts=8:ft=help:norl:``, and set itself accordingly.

- Enable ``:autoindent`` and ``:smartindent``.

  - And enable loading ``indent/`` files.

- Enable ``:wildmenu``, a/k/a, Vim command line tab completion.

- Show the status line and rule.

- Break longs lines on word boundaries.

- Make a close a close. The default Gvim menu behavior for File < Close
  (``<Alt-f>`` ``<c>``) just hides the buffer. Close the file in addition.

- Rewire File > Close (``<Alt-f>`` ``<c>``) so that it closes the buffer, too.

- Rewire File > Save All (``<Alt-f>`` ``<l>``) to save all files.

  - To allow us, File > Split-Open is remapped (to ``<Alt-f>`` ``<t>``).

- Use Window > New V-Split (``<Alt-w>`` ``<s>``) to open a new buffer
  in a new window to the right of the current window.

- Add File > Close All (``<Alt-f>`` ``<e>``) to close all files / delete
  all buffers.

 - If you Close All and then Exit (``<Alt-f>`` ``<x>``), because there's
   only one, empty buffer, Vim will delete ``Session.vim``. This is useful
   if you've edited a ``~/.vim/*`` script and want to reload it; otherwise,
   if a Session file exists, Vim will just read it and ignore other stuff.

- Save the current Session on exit; restore it on open.

  To clear the session -- e.g., after editing any Vim file -- type

    ``<Alt-f>`` ``<e>``, and then
    ``<Alt-f>`` ``<x>``.

  - The first command
      closes all files,
      deletes all buffers, and
      removes the Session file.

  - The second command quits Vim.

  When you restart Vim, it'll start with a fresh
  Session file and load any Vim edits you made.

- Set the ``*.swp`` file ``:directory`` to ``$HOME/.vim_backups/``

- Disable backups (set ``:nobackup``).

  You should use ``<Ctrl-s>`` or ``<Alt-f>`` ``<Alt-l>`` frequently.

  And commit to Git often. Do other things often.

..  Just don't manage a bunch of Gvim backup files.

.. - Also set the ``:backupdir`` to ``$HOME/.vim_backups/``

- Disable the frakking bell.

The plugin also improves upon the default color scheme.

- White background with black text, and non-distracting grey line numbers.

- Slash ``/`` and Star ``*`` Searches are highlighted with a green background.

- Change line numbers color from deep red (default) to dark grey.

- Remove distracting vertical split line between adjacent windows.

- Or, if you have `Dubs After Dark <https://github.com/landonb/dubs_after_dark>`__
  installed, this plugin will load the ``after-dark`` color scheme.

See the source for a few other settings and more comments.

Installation
------------

Standard Pathogen installation:

.. code-block:: bash

   cd ~/.vim/bundle/
   git clone https://github.com/landonb/dubs_appearance.git

Or, Standard submodule installation:

.. code-block:: bash

   cd ~/.vim/bundle/
   git submodule add https://github.com/landonb/dubs_appearance.git

Online help:

.. code-block:: vim

   :Helptags
   :help dubs-appearance

Appearance Commands
---------------------

This script does not define any commands.

